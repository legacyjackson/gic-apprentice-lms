// ============================================================================
// enroll-apprentice.js — Token-gated apprentice enrollment
// ============================================================================
// Public endpoint (no JWT required) — the token IS the authorization.
// Flow:
//   1. Validate token via redeem_sponsorship_token RPC (atomic increment)
//   2. Create Supabase auth user via admin API
//   3. Link the new profile to the employer sponsor + record the token used
//
// Failure modes leave no half-created state (best-effort cleanup on user-create
// failure after token redemption).
// ============================================================================

const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL         = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

const CORS = {
  'Access-Control-Allow-Origin':  '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type',
};

const ok  = (b)    => ({ statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(b) });
const err = (s, m) => ({ statusCode: s,   headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: m }) });

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' };
  if (event.httpMethod !== 'POST')    return err(405, 'Method not allowed');

  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return err(400, 'Invalid JSON'); }

  const token    = String(body.token || '').trim().toUpperCase();
  const email    = String(body.email || '').trim().toLowerCase();
  const password = String(body.password || '');
  const fullName = String(body.fullName || '').trim().slice(0, 120);

  if (!token)               return err(400, 'Sponsorship code required');
  if (!email || !email.includes('@')) return err(400, 'Valid email required');
  if (!password || password.length < 8)  return err(400, 'Password must be at least 8 characters');
  if (!fullName)            return err(400, 'Full name required');

  const admin = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false }
  });

  // -- 1. Redeem token (atomic; returns sponsor_id or null)
  const { data: sponsorId, error: redeemErr } = await admin.rpc('redeem_sponsorship_token', { p_token: token });
  if (redeemErr) return err(500, 'Token validation failed: ' + redeemErr.message);
  if (!sponsorId) return err(400, 'That code is invalid, expired, or already used.');

  // -- 2. Create the user
  const { data: created, error: createErr } = await admin.auth.admin.createUser({
    email,
    password,
    email_confirm: true,                     // bypass email confirmation
    user_metadata: { full_name: fullName }
  });

  if (createErr || !created?.user) {
    // We've decremented a token use; admins can manually reset if needed.
    return err(400, 'Could not create account: ' + (createErr?.message || 'unknown'));
  }
  const newUserId = created.user.id;

  // -- 3. Link profile to sponsor + record token. The auto-create trigger from
  //       supabase_setup.sql will have made a profile row; update it.
  const { error: linkErr } = await admin
    .from('profiles')
    .update({
      full_name: fullName,
      employer_sponsor_id: sponsorId,
      enrolled_via_token: token,
      role: 'apprentice'
    })
    .eq('id', newUserId);

  if (linkErr) {
    // Profile didn't exist — insert one
    await admin.from('profiles').insert({
      id: newUserId,
      email,
      full_name: fullName,
      employer_sponsor_id: sponsorId,
      enrolled_via_token: token,
      role: 'apprentice'
    });
  }

  // -- 4. Sponsor name for the success screen
  const { data: sponsor } = await admin
    .from('employer_sponsors')
    .select('name')
    .eq('id', sponsorId)
    .maybeSingle();

  return ok({
    success: true,
    sponsorName: sponsor?.name || '',
    email
  });
};
