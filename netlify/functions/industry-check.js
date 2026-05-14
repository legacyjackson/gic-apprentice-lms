// Scheduled daily industry update check using OpenAI
const { createClient } = require('@supabase/supabase-js');

exports.handler = async (event) => {
  const OPENAI_KEY = process.env.OPENAI_API_KEY;
  const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false }
  });

  const today = new Date().toISOString().split('T')[0];

  const prompt = `You are a compliance and curriculum officer for a DOL-registered financial counselor apprenticeship program. Today is ${today}.

Check for any regulatory, compliance, or industry changes in the past 7 days that a Wealth Solutions Counselor apprenticeship should be aware of. Focus on:
- SEC, FINRA, DOL rule changes or guidance
- IRS tax limit updates (contribution limits, brackets, RMD rules)
- CFPB guidance affecting consumer financial advice
- Major market structure or financial planning practice changes
- Any changes that would require updating curriculum content

Return a JSON array of up to 5 items. Each item: { "title": "...", "summary": "...", "category": "regulatory|tax|market|compliance|general", "relevance": "which modules or topics this affects" }

If there are no significant updates, return an empty array [].`;

  try {
    const r = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: { 'Authorization': 'Bearer ' + OPENAI_KEY, 'Content-Type': 'application/json' },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.3,
        response_format: { type: 'json_object' }
      })
    });
    const data = await r.json();
    let updates = [];
    try {
      const parsed = JSON.parse(data.choices?.[0]?.message?.content || '{}');
      updates = Array.isArray(parsed) ? parsed : (parsed.updates || parsed.items || []);
    } catch {}

    if (updates.length > 0) {
      await supabase.from('industry_updates').insert(
        updates.map(u => ({ title: u.title, summary: u.summary, category: u.category || 'general', source: 'AI Daily Check', relevance: u.relevance || '' }))
      );
    }

    return { statusCode: 200, body: JSON.stringify({ checked: today, inserted: updates.length }) };
  } catch (e) {
    return { statusCode: 500, body: JSON.stringify({ error: e.message }) };
  }
};
