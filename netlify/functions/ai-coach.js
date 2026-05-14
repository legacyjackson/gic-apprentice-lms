// ============================================================================
// ai-coach.js — OpenAI study-coach proxy
// ============================================================================
// Positions Claude/GPT as a study coach for apprentices: explains concepts,
// gives examples, quizzes them. Explicitly NOT a financial advisor.
//
// Auth: requires valid Supabase JWT.
// ============================================================================

const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL         = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const OPENAI_KEY           = process.env.OPENAI_API_KEY;
const OPENAI_MODEL         = process.env.OPENAI_MODEL || 'gpt-4o-mini';

const SYSTEM_PROMPT = `You are the study coach for the Global Investment Company Wealth Solutions Counselor Apprenticeship — a DOL-Registered Apprenticeship preparing future financial counselors.

Your role:
- Help apprentices understand concepts from their current lesson.
- Provide concrete examples, analogies, and short practice questions.
- Reinforce the curriculum's framing; do not introduce conflicting frameworks.
- Be warm, plain-spoken, and concise. Default to 3–6 sentences.

Hard boundaries:
- You are NOT a financial, legal, tax, or investment advisor. You give educational explanations only.
- Never recommend specific securities, allocations, or financial products.
- If asked for personal financial advice, redirect to: "Run that scenario by your GIC mentor — that's a real-money decision and worth a conversation, not a coaching reply."
- If asked something outside the curriculum, gently redirect to the lesson.
- Do not invent statistics or cite sources you can't verify.

Style:
- No bullet salad. Plain paragraphs.
- Use the apprentice's first name if provided.
- End with a single short follow-up prompt when it helps learning ("Want to try a worked example?").`;

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
  if (!OPENAI_KEY)                    return err(500, 'OPENAI_API_KEY not configured');

  const authHeader = event.headers.authorization || event.headers.Authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) return err(401, 'Missing bearer token');
  const jwt = authHeader.slice(7);

  const admin = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false }
  });
  const { data: userData, error: userErr } = await admin.auth.getUser(jwt);
  if (userErr || !userData?.user) return err(401, 'Invalid session');

  let body;
  try { body = JSON.parse(event.body || '{}'); }
  catch { return err(400, 'Invalid JSON'); }

  const question      = String(body.question || '').slice(0, 2000).trim();
  const lessonContext = String(body.lessonContext || '').slice(0, 6000);
  const apprenticeName= String(body.apprenticeName || '').slice(0, 80);
  const history       = Array.isArray(body.history) ? body.history.slice(-10) : [];

  if (!question) return err(400, 'question required');

  const contextBlock = lessonContext
    ? `Current lesson context (use this to ground your answer):\n${lessonContext}\n\n`
    : '';
  const namePrefix = apprenticeName ? `Apprentice's first name: ${apprenticeName.split(' ')[0]}\n\n` : '';

  const messages = [
    { role: 'system', content: SYSTEM_PROMPT },
    { role: 'system', content: namePrefix + contextBlock },
    ...history
      .filter(m => m && (m.role === 'user' || m.role === 'assistant') && typeof m.content === 'string')
      .map(m => ({ role: m.role, content: String(m.content).slice(0, 4000) })),
    { role: 'user', content: question }
  ];

  try {
    const r = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': 'Bearer ' + OPENAI_KEY,
        'Content-Type':  'application/json'
      },
      body: JSON.stringify({
        model: OPENAI_MODEL,
        messages,
        temperature: 0.4,
        max_tokens: 600
      })
    });

    if (!r.ok) {
      const txt = await r.text();
      return err(502, 'OpenAI error: ' + txt.slice(0, 300));
    }
    const data   = await r.json();
    const answer = data?.choices?.[0]?.message?.content || '';
    return ok({ answer, model: OPENAI_MODEL });
  } catch (e) {
    return err(500, 'Coach call failed: ' + (e.message || 'unknown'));
  }
};
