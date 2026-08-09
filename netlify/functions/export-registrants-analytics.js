// ============================================================================
// export-registrants-analytics.js — filtered/selected analytics CSV export
// Auth: admin or approver role required.
// Body: { userIds: string[] }  — apprentice profile ids to include.
// ============================================================================

const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL         = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

const CORS = {
  'Access-Control-Allow-Origin':  '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

const err = (s, m) => ({ statusCode: s, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: m }) });

function esc(v) {
  if (v === null || v === undefined) return '';
  const s = String(v);
  return s.includes(',') || s.includes('"') || s.includes('\n') ? `"${s.replace(/"/g, '""')}"` : s;
}

function toCSV(rows, headers) {
  const lines = [headers.map(esc).join(',')];
  rows.forEach(r => lines.push(headers.map(h => esc(r[h])).join(',')));
  return lines.join('\r\n');
}

function ageFromDob(dob) {
  if (!dob) return '';
  return Math.floor((Date.now() - new Date(dob).getTime()) / (365.25 * 24 * 3600 * 1000));
}

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

  const userIds = Array.isArray(body.userIds) && body.userIds.length ? body.userIds : null;

  let profileQuery = admin.from('profiles')
    .select('id,full_name,email,created_at,employer_sponsor_id,mentor_id,last_active_at')
    .eq('role', 'apprentice');
  if (userIds) profileQuery = profileQuery.in('id', userIds);

  const { data: profiles } = await profileQuery;
  const ids = (profiles || []).map(p => p.id);

  const [{ data: modules }, { data: regs }, { data: prog }, { data: subs }, { data: logins }, { data: reads }, { data: sponsors }, { data: mentors }] = await Promise.all([
    admin.from('modules').select('status'),
    admin.from('registrants').select('activated_profile_id,dob,county').in('activated_profile_id', ids.length ? ids : ['00000000-0000-0000-0000-000000000000']),
    admin.from('module_progress').select('user_id,status,best_quiz_score,quiz_attempts').in('user_id', ids.length ? ids : ['00000000-0000-0000-0000-000000000000']),
    admin.from('competency_submissions').select('apprentice_id,status,ojl_hours_credited').in('apprentice_id', ids.length ? ids : ['00000000-0000-0000-0000-000000000000']),
    admin.from('login_events').select('user_id').in('user_id', ids.length ? ids : ['00000000-0000-0000-0000-000000000000']),
    admin.from('lesson_reads').select('user_id,seconds_spent').in('user_id', ids.length ? ids : ['00000000-0000-0000-0000-000000000000']),
    admin.from('employer_sponsors').select('id,name'),
    admin.from('profiles').select('id,full_name,email').in('role', ['mentor','admin','approver'])
  ]);

  const approvedModules = (modules || []).filter(m => m.status === 'approved').length;
  const sponsorNameById = {}; (sponsors || []).forEach(s => { sponsorNameById[s.id] = s.name; });
  const mentorNameById = {}; (mentors || []).forEach(m => { mentorNameById[m.id] = m.full_name || m.email; });
  const regByProfile = {}; (regs || []).forEach(r => { regByProfile[r.activated_profile_id] = r; });

  const byUser = {};
  (profiles || []).forEach(p => {
    const reg = regByProfile[p.id];
    byUser[p.id] = {
      ...p, completed: 0, inProgress: 0, scores: [], quizAttempts: 0, ojlHours: 0,
      loginCount: 0, secondsSpent: 0, county: reg?.county || '', dob: reg?.dob || ''
    };
  });
  (prog || []).forEach(p => {
    const u = byUser[p.user_id]; if (!u) return;
    if (p.status === 'completed') u.completed++;
    if (p.status === 'in_progress') u.inProgress++;
    if (p.best_quiz_score) u.scores.push(p.best_quiz_score);
    u.quizAttempts += (p.quiz_attempts || 0);
  });
  (subs || []).forEach(s => { if (byUser[s.apprentice_id] && s.status === 'approved') byUser[s.apprentice_id].ojlHours += (s.ojl_hours_credited || 0); });
  (logins || []).forEach(l => { if (byUser[l.user_id]) byUser[l.user_id].loginCount++; });
  (reads || []).forEach(r => { if (byUser[r.user_id]) byUser[r.user_id].secondsSpent += (r.seconds_spent || 0); });

  const rows = Object.values(byUser).map(u => ({
    'Name':               u.full_name || '',
    'Email':              u.email || '',
    'County':             u.county || '',
    'Age':                ageFromDob(u.dob),
    'Sponsor':            u.employer_sponsor_id ? (sponsorNameById[u.employer_sponsor_id] || '') : '',
    'Mentor':             u.mentor_id ? (mentorNameById[u.mentor_id] || '') : '',
    'Registered':         u.created_at ? u.created_at.slice(0, 10) : '',
    'Progress %':         approvedModules > 0 ? Math.round((u.completed / approvedModules) * 100) : 0,
    'Modules Completed':  u.completed,
    'Modules In Progress': u.inProgress,
    'Quiz Avg %':         u.scores.length ? Math.round(u.scores.reduce((s,x) => s + x, 0) / u.scores.length) : '',
    'Quiz Attempts':      u.quizAttempts,
    'OJL Hours':          u.ojlHours,
    'Logins':             u.loginCount,
    'Last Active':        u.last_active_at ? u.last_active_at.slice(0, 10) : '',
    'Lesson Time (min)':  Math.round((u.secondsSpent || 0) / 60),
  }));

  const headers = ['Name','Email','County','Age','Sponsor','Mentor','Registered','Progress %','Modules Completed','Modules In Progress','Quiz Avg %','Quiz Attempts','OJL Hours','Logins','Last Active','Lesson Time (min)'];
  const csv = toCSV(rows, headers);

  return {
    statusCode: 200,
    headers: {
      ...CORS,
      'Content-Type': 'text/csv',
      'Content-Disposition': `attachment; filename="gic-analytics-${new Date().toISOString().slice(0,10)}.csv"`
    },
    body: csv
  };
};
