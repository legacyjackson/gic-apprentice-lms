// ============================================================================
// delete-user.js — permanently delete an apprentice account
// Auth: admin or approver role required.
// Body: { userId }
// ============================================================================
// Deleting via the Supabase Auth Admin API (not a plain table delete) so the
// auth.users row itself is removed — profiles.id references auth.users(id)
// on delete cascade, which in turn cascades through module_progress,
// lesson_reads, login_events, competency_submissions, prerequisite_waivers,
// etc. A plain `delete from profiles` would leave an orphaned auth account
// that can still sign in but gets stuck on a permanent loading screen.
// Restricted to targets with role='apprentice' — this endpoint is not for
// removing staff accounts.
// ============================================================================

const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL         = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

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
  if (!authHeader?.startsWith('Bearer ')) return err(401, 'Missing bearer token');

  const admin = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false }
  });

  const { data: userData, error: userErr } = await admin.auth.getUser(authHeader.slice(7));
  if (userErr || !userData?.user) return err(401, 'Invalid session');

  const { data: requester } = await admin.from('profiles').select('role').eq('id', userData.user.id).maybeSingle();
  if (!requester || !['admin', 'approver'].includes(requester.role)) return err(403, 'Admin access required');

  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return err(400, 'Invalid JSON'); }

  const userId = String(body.userId || '').trim();
  if (!userId) return err(400, 'userId required');
  if (userId === userData.user.id) return err(400, "You can't delete your own account through this tool.");

  const { data: target } = await admin.from('profiles').select('id,role,full_name,email').eq('id', userId).maybeSingle();
  if (!target) return err(404, 'User not found');
  if (target.role !== 'apprentice') return err(400, 'This tool only deletes apprentice accounts.');

  const { error: deleteErr } = await admin.auth.admin.deleteUser(userId);
  if (deleteErr) return err(500, 'Delete failed: ' + deleteErr.message);

  return ok({ success: true, deleted: { id: target.id, full_name: target.full_name, email: target.email } });
};
