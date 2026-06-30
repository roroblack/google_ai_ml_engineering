import { put, head } from '@vercel/blob';

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

export default async function handler(req, response) {
  response.setHeader('Access-Control-Allow-Origin', '*');
  if (req.method === 'OPTIONS') return response.status(200).end();
  if (req.method !== 'POST') return response.status(405).end();

  const { room, key, state } = req.body || {};
  if (!room || !key || !state) return response.status(400).json({ error: 'missing fields' });
  if (!UUID_RE.test(room) || !UUID_RE.test(key)) return response.status(400).json({ error: 'invalid id' });

  try {
    try {
      const info = await head(`rooms/${room}.json`);
      const fetched = await fetch(info.url + '?nc=' + Date.now());
      const existing = await fetched.json();
      if (existing.writeKey !== key) return response.status(403).json({ error: 'invalid key' });
    } catch (e) {
      if (e.name !== 'BlobNotFoundError' && !e.message?.includes('not found')) throw e;
    }

    await put(`rooms/${room}.json`, JSON.stringify({ writeKey: key, state }), {
      access: 'public',
      allowOverwrite: true,
      addRandomSuffix: false,
      contentType: 'application/json',
      cacheControlMaxAge: 0,
    });

    response.json({ ok: true });
  } catch (e) {
    console.error('[save] error:', e);
    response.status(500).json({ error: e.message, name: e.name, env: !!process.env.BLOB_READ_WRITE_TOKEN + '/' + !!process.env.BLOB_STORE_ID });
  }
}
