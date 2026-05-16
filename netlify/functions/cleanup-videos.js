// ============================================================================
// cleanup-videos.js — Delete DO Spaces videos for submissions approved >30 days ago
// Runs daily at midnight via Netlify scheduled function.
// ============================================================================

const { S3Client, DeleteObjectCommand } = require('@aws-sdk/client-s3');
const { createClient }                  = require('@supabase/supabase-js');

const SUPABASE_URL         = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const DO_REGION            = process.env.DO_SPACES_REGION || 'sfo3';
const DO_BUCKET            = process.env.DO_SPACES_BUCKET || 'gic-apprentice';
const RETENTION_DAYS       = 30;

const s3 = new S3Client({
  endpoint: `https://${DO_REGION}.digitaloceanspaces.com`,
  region:   'us-east-1',
  credentials: {
    accessKeyId:     process.env.DO_SPACES_KEY,
    secretAccessKey: process.env.DO_SPACES_SECRET,
  },
});

exports.handler = async () => {
  const admin = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false }
  });

  const cutoff = new Date(Date.now() - RETENTION_DAYS * 24 * 60 * 60 * 1000).toISOString();

  // Find approved submissions with a video that are older than retention window
  const { data: stale, error } = await admin
    .from('competency_submissions')
    .select('id, video_path')
    .eq('status', 'approved')
    .lt('reviewed_at', cutoff)
    .not('video_path', 'is', null);

  if (error) {
    console.error('Query error:', error.message);
    return { statusCode: 500, body: error.message };
  }

  let deleted = 0;
  let failed  = 0;

  for (const sub of stale || []) {
    try {
      await s3.send(new DeleteObjectCommand({ Bucket: DO_BUCKET, Key: sub.video_path }));
      await admin
        .from('competency_submissions')
        .update({ video_path: null, updated_at: new Date().toISOString() })
        .eq('id', sub.id);
      deleted++;
    } catch (e) {
      console.error(`Failed to delete ${sub.video_path}:`, e.message);
      failed++;
    }
  }

  console.log(`Cleanup complete: ${deleted} deleted, ${failed} failed`);
  return { statusCode: 200, body: JSON.stringify({ deleted, failed }) };
};
