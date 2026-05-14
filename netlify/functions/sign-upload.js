// ============================================================================
// sign-upload.js — DO Spaces presigned PUT URL
// ============================================================================
// Auth: requires a valid Supabase session JWT in Authorization header.
// Returns a presigned URL the client uses to PUT the video directly to DO Spaces.
// ============================================================================

const { S3Client, PutObjectCommand } = require('@aws-sdk/client-s3');
const { getSignedUrl }               = require('@aws-sdk/s3-request-presigner');
const { createClient }               = require('@supabase/supabase-js');

const SUPABASE_URL         = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const DO_REGION            = process.env.DO_SPACES_REGION || 'sfo3';
const DO_BUCKET            = process.env.DO_SPACES_BUCKET || 'gic-apprentice';

const s3 = new S3Client({
  endpoint: `https://${DO_REGION}.digitaloceanspaces.com`,
  region:   'us-east-1',                   // DO Spaces accepts any region string
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

const ok    = (b) => ({ statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(b) });
const err   = (s, m) => ({ statusCode: s, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: m }) });

const sanitize = (s) => String(s || '').replace(/[^a-zA-Z0-9._-]/g, '_').slice(0, 80);

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' };
  if (event.httpMethod !== 'POST')    return err(405, 'Method not allowed');

  // -- Auth: verify Supabase JWT
  const authHeader = event.headers.authorization || event.headers.Authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) return err(401, 'Missing bearer token');
  const jwt = authHeader.slice(7);

  const admin = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false }
  });
  const { data: userData, error: userErr } = await admin.auth.getUser(jwt);
  if (userErr || !userData?.user) return err(401, 'Invalid session');
  const userId = userData.user.id;

  // -- Parse body
  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return err(400, 'Invalid JSON'); }

  const filename     = sanitize(body.filename) || `recording-${Date.now()}.webm`;
  const contentType  = String(body.contentType || 'video/webm').slice(0, 60);
  const moduleId     = String(body.moduleId || 'general').replace(/[^a-zA-Z0-9-]/g, '');

  if (!contentType.startsWith('video/') && !contentType.startsWith('audio/'))
    return err(400, 'Only audio/video uploads are permitted');

  // -- Build object key — scoped to user so RLS-equivalent isolation at the storage layer
  const stamp = Date.now();
  const key   = `submissions/${userId}/${moduleId || 'm'}/${stamp}-${filename}`;

  const command = new PutObjectCommand({
    Bucket:      DO_BUCKET,
    Key:         key,
    ContentType: contentType,
    ACL:         'private',
  });

  try {
    const url = await getSignedUrl(s3, command, { expiresIn: 600 });   // 10 min
    return ok({
      uploadUrl: url,
      key,
      bucket: DO_BUCKET,
      expiresIn: 600,
    });
  } catch (e) {
    return err(500, 'Failed to sign upload URL: ' + (e.message || 'unknown'));
  }
};
