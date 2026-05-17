// ============================================================================
// export-progress.js — RAPIDS/DOL progress CSV export
// Auth: admin or approver role required.
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

  // Fetch all data
  const [{ data: profiles }, { data: modules }, { data: allProgress }, { data: allSubs }] = await Promise.all([
    admin.from('profiles').select('id,full_name,email,role,created_at').eq('role', 'apprentice'),
    admin.from('modules').select('id,module_number,title,competency_id,ri_hours,ojl_hours').order('module_number'),
    admin.from('module_progress').select('*'),
    admin.from('competency_submissions').select('apprentice_id,module_id,status,ojl_hours_credited,reviewed_at').eq('status', 'approved')
  ]);

  const progressMap = {};
  (allProgress || []).forEach(p => { progressMap[`${p.user_id}:${p.module_id}`] = p; });

  const subsMap = {};
  (allSubs || []).forEach(s => { subsMap[`${s.apprentice_id}:${s.module_id}`] = s; });

  const rows = [];
  (profiles || []).forEach(p => {
    (modules || []).forEach(m => {
      const prog = progressMap[`${p.id}:${m.id}`];
      const sub  = subsMap[`${p.id}:${m.id}`];
      rows.push({
        'Apprentice Name':    p.full_name || '',
        'Email':              p.email || '',
        'Module Number':      m.module_number,
        'Competency ID':      m.competency_id || '',
        'Module Title':       m.title || '',
        'RI Hours':           m.ri_hours || 0,
        'OJL Hours Required': m.ojl_hours || 0,
        'Status':             prog?.status || 'not_started',
        'Quiz Score':         prog?.best_quiz_score ?? '',
        'Completion Date':    prog?.status === 'completed' ? (prog.updated_at || '').slice(0, 10) : '',
        'OJL Hours Credited': sub?.ojl_hours_credited || 0,
        'OJL Approved Date':  sub?.reviewed_at ? sub.reviewed_at.slice(0, 10) : '',
        'Started':            p.created_at ? p.created_at.slice(0, 10) : '',
      });
    });
  });

  const headers = [
    'Apprentice Name','Email','Module Number','Competency ID','Module Title',
    'RI Hours','OJL Hours Required','Status','Quiz Score','Completion Date',
    'OJL Hours Credited','OJL Approved Date','Started'
  ];
  const csv = toCSV(rows, headers);

  return {
    statusCode: 200,
    headers: {
      ...CORS,
      'Content-Type': 'text/csv',
      'Content-Disposition': `attachment; filename="gic-apprentice-progress-${new Date().toISOString().slice(0,10)}.csv"`
    },
    body: csv
  };
};
