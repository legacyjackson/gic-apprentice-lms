// ============================================================================
// lookup-county.js — address -> county lookup, proxied through the U.S. Census
// Bureau's free public geocoder (geocoding.geo.census.gov).
// ============================================================================
// Public endpoint (no auth) — this just proxies a free government geocoding
// service. It exists only because that service doesn't send CORS headers, so
// the browser can't call it directly; a server-to-server request isn't
// subject to CORS at all.
// ============================================================================

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

  const address = String(body.address || '').trim();
  const city    = String(body.city || '').trim();
  const state   = String(body.state || '').trim();
  const zip     = String(body.zip || '').trim();

  if (!city || !state || !zip) return ok({ county: null });

  const oneLine = [address, city, state, zip].filter(Boolean).join(', ');
  const url = `https://geocoding.geo.census.gov/geocoder/geographies/onelineaddress?address=${encodeURIComponent(oneLine)}&benchmark=Public_AR_Current&vintage=Current_Current&layers=Counties&format=json`;

  try {
    const res = await fetch(url);
    if (!res.ok) return ok({ county: null });
    const json = await res.json();
    const county = json?.result?.addressMatches?.[0]?.geographies?.Counties?.[0]?.NAME || null;
    return ok({ county });
  } catch (e) {
    return ok({ county: null }); // best-effort — the county field stays manually editable regardless
  }
};
