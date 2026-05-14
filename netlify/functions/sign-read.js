// ============================================================================
// sign-read.js — DO Spaces presigned GET URL
// ============================================================================
// Auth: requires valid Supabase JWT.
// Authz: the requested object key must belong to a submission the user can view.
//        - apprentice can view their own submissions
//        - mentor can view their mentees' submissions
//        - admin/approver can view any
// ============================================================================

const { S3Client, GetObjectCommand } = require('@aws-sdk/client-s3');
const { getSignedUrl }               = require('@aws-sdk/s3-request-presigner');
const { createClient }               = require('@supabase/supabase-js');

const SUPABASE_URL         = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const DO_REGION            = process.env.DO_SPACES_REGION || 'sfo3';
const DO_BUCKET            = process.env.DO_SPACES_BUCKET || 'gic-apprentice';

const s3 = new S3Client({
  endpoint: `https://${DO_REGION}.digitaloceanspaces.com`,
  region:   'us-east-1',
  credentials: {
    accessKeyId:     process.env.DO_SPACES_KEY,
    secretAccessKey: process.env.DO_SPACES_SECRET,
  },
});

const CORS = {
  'Access-Control-Allow-Origin':  '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

const ok  = (b)    => ({ statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(b) });
const err = (s, m) => ({ statusCode: s,   headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: m }) });

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' };
  if (event.httpMethod !== 'POST')    return err(405, 'Method not allowed');

  const authHeader = event.headers.authorization || event.headers.Authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) return err(401, 'Missing bearer token');
  const jwt = authHeader.slice(7);

  const admin = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false }
  });
  const { data: userData, error: userErr } = await admin.auth.getUser(jwt);
  if (userErr || !userData?.user) return err(401, 'Invalid session');
  const userId = userData.user.id;

  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return err(400, 'Invalid JSON'); }

  const submissionId = body.submissionId;
  if (!submissionId) return err(400, 'submissionId required');

  // -- Lookup submission + the requesting user's role
  const [{ data: submission }, { data: requester }] = await Promise.all([
    admin.from('competency_submissions').select('id,apprentice_id,video_path').eq('id', submissionId).maybeSingle(),
    admin.from('profiles').select('id,role').eq('id', userId).maybeSingle()
  ]);

  if (!submission) return err(404, 'Submission not found');
  if (!requester)  return err(403, 'No profile');

  // -- Authz
  let allowed = false;
  if (submission.apprentice_id === userId) {
    allowed = true;
  } else if (requester.role === 'admin' || requester.role === 'approver') {
    allowed = true;
  } else if (requester.role === 'mentor') {
    const { data: mentee } = await admin
      .from('profiles')
      .select('mentor_id')
      .eq('id', submission.apprentice_id)
      .maybeSingle();
    allowed = mentee?.mentor_id === userId;
  }
  if (!allowed) return err(403, 'Not authorized to view this submission');

  // -- Sign GET URL
  try {
    const command = new GetObjectCommand({ Bucket: DO_BUCKET, Key: submission.video_path });
    const url     = await getSignedUrl(s3, command, { expiresIn: 3600 });   // 1 hour
    return ok({ url, expiresIn: 3600 });
  } catch (e) {
    return err(500, 'Failed to sign read URL: ' + (e.message || 'unknown'));
  }
};
