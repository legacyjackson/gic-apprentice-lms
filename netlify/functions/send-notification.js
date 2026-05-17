// ============================================================================
// send-notification.js — transactional email via Resend
// Called internally by other functions or DB webhooks.
// Env vars required: RESEND_API_KEY
// ============================================================================

const FROM = 'GIC Apprentice Program <admin@globalinvestmentcompanies.com>';

const CORS = {
  'Access-Control-Allow-Origin':  '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

const ok  = (b)    => ({ statusCode: 200, headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify(b) });
const err = (s, m) => ({ statusCode: s,   headers: { ...CORS, 'Content-Type': 'application/json' }, body: JSON.stringify({ error: m }) });

async function sendEmail({ to, subject, html }) {
  const apiKey = process.env.RESEND_API_KEY;
  if (!apiKey) throw new Error('RESEND_API_KEY not configured');

  const res = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${apiKey}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ from: FROM, to: Array.isArray(to) ? to : [to], subject, html })
  });
  if (!res.ok) {
    const body = await res.text();
    throw new Error(`Resend error ${res.status}: ${body}`);
  }
  return res.json();
}

// Pre-built templates
function templates(type, data) {
  const base = (content) => `
    <div style="font-family:'Helvetica Neue',Arial,sans-serif;max-width:560px;margin:0 auto;color:#0F1631">
      <div style="padding:32px 0 16px;border-bottom:2px solid #2D1FB1">
        <p style="margin:0;font-size:11px;letter-spacing:.14em;text-transform:uppercase;color:#8A745E">Global Investment Company · Apprentice Program</p>
      </div>
      <div style="padding:32px 0">${content}</div>
      <div style="padding:16px 0;border-top:1px solid #E5DFD3;font-size:11px;color:#8A745E">
        This message was sent automatically. Reply to this email or contact your mentor directly.
      </div>
    </div>`;

  switch (type) {
    case 'question_answered':
      return {
        subject: `Your question has been answered`,
        html: base(`
          <h2 style="margin:0 0 16px;font-size:24px">Your mentor responded</h2>
          <p style="margin:0 0 8px;color:#6B5B4A">Question:</p>
          <p style="margin:0 0 24px;padding:12px 16px;background:#F7F4EF;border-left:3px solid #2D1FB1;font-style:italic">${data.question}</p>
          <p style="margin:0 0 8px;color:#6B5B4A">Answer:</p>
          <p style="margin:0 0 24px;padding:12px 16px;background:#F0F7F3;border-left:3px solid #1F7A4A">${data.answer}</p>
          <p style="margin:0 0 4px"><strong>${data.responder}</strong></p>
          <p style="margin:0;color:#8A745E;font-size:13px">Log in to view your full question thread.</p>`)
      };

    case 'submission_reviewed':
      const approved = data.status === 'approved';
      return {
        subject: approved ? `OJL submission approved — ${data.module}` : `OJL submission needs revision — ${data.module}`,
        html: base(`
          <h2 style="margin:0 0 16px;font-size:24px">${approved ? 'Submission approved' : 'Revision requested'}</h2>
          <p style="margin:0 0 16px;color:#6B5B4A">Module: <strong>${data.module}</strong></p>
          ${approved ? `<p style="margin:0 0 16px;padding:12px 16px;background:#F0F7F3;border-left:3px solid #1F7A4A;color:#1F7A4A"><strong>${data.hours} OJL hour${data.hours === 1 ? '' : 's'} credited to your record.</strong></p>` : ''}
          ${data.feedback ? `<p style="margin:0 0 8px;color:#6B5B4A">Feedback:</p><p style="margin:0 0 24px;padding:12px 16px;background:#F7F4EF;border-left:3px solid #B83D5C">${data.feedback}</p>` : ''}
          <p style="margin:0;color:#8A745E;font-size:13px">Log in to view your submission details.</p>`)
      };

    case 'new_question':
      return {
        subject: `New question from ${data.apprentice} — Module ${data.module}`,
        html: base(`
          <h2 style="margin:0 0 16px;font-size:24px">New question to review</h2>
          <p style="margin:0 0 4px"><strong>${data.apprentice}</strong> asked in <strong>${data.lessonTitle || 'Module ' + data.module}</strong>:</p>
          <p style="margin:0 0 24px;padding:12px 16px;background:#F7F4EF;border-left:3px solid #2D1FB1;font-style:italic">${data.question}</p>
          <p style="margin:0;color:#8A745E;font-size:13px">Log in to the Mentor dashboard to respond.</p>`)
      };

    case 'waiver_requested':
      return {
        subject: `Jump-ahead request from ${data.apprentice} — ${data.module}`,
        html: base(`
          <h2 style="margin:0 0 16px;font-size:24px">Prerequisite waiver request</h2>
          <p style="margin:0 0 16px"><strong>${data.apprentice}</strong> is requesting early access to <strong>${data.module}</strong>.</p>
          <p style="margin:0 0 8px;color:#6B5B4A">Their reason:</p>
          <p style="margin:0 0 24px;padding:12px 16px;background:#F7F4EF;border-left:3px solid #C8841C;font-style:italic">${data.reason}</p>
          <p style="margin:0;color:#8A745E;font-size:13px">Log in to the Mentor dashboard → Waivers to approve or deny.</p>`)
      };

    case 'waiver_decided':
      const isApproved = data.status === 'approved';
      return {
        subject: isApproved ? `Jump-ahead approved — ${data.module}` : `Jump-ahead request denied — ${data.module}`,
        html: base(`
          <h2 style="margin:0 0 16px;font-size:24px">${isApproved ? 'Early access granted' : 'Request not approved'}</h2>
          <p style="margin:0 0 16px;color:#6B5B4A">Module: <strong>${data.module}</strong></p>
          ${isApproved ? `<p style="margin:0 0 16px;padding:12px 16px;background:#F0F7F3;border-left:3px solid #1F7A4A;color:#1F7A4A"><strong>You can now access this module.</strong></p>` : ''}
          ${data.note ? `<p style="margin:0 0 8px;color:#6B5B4A">Note from mentor:</p><p style="margin:0 0 24px;padding:12px 16px;background:#F7F4EF;border-left:3px solid #8A745E">${data.note}</p>` : ''}
          <p style="margin:0;color:#8A745E;font-size:13px">Log in to continue your modules.</p>`)
      };

    default:
      throw new Error('Unknown notification type: ' + type);
  }
}

exports.handler = async (event) => {
  if (event.httpMethod === 'OPTIONS') return { statusCode: 204, headers: CORS, body: '' };
  if (event.httpMethod !== 'POST')    return err(405, 'Method not allowed');

  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return err(400, 'Invalid JSON'); }

  const { type, to, data } = body;
  if (!type || !to) return err(400, 'type and to are required');

  try {
    const { subject, html } = templates(type, data || {});
    const result = await sendEmail({ to, subject, html });
    return ok({ sent: true, id: result?.id });
  } catch (e) {
    console.error('Email send failed:', e.message);
    return err(500, e.message);
  }
};

// Helper used internally by other functions
exports.notify = async (type, to, data) => {
  try {
    const { subject, html } = templates(type, data || {});
    await sendEmail({ to, subject, html });
  } catch (e) {
    console.error('notify() failed:', e.message);
  }
};
