import { head } from '@vercel/blob';

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

export default async function handler(req, response) {
  response.setHeader('Access-Control-Allow-Origin', '*');
  if (req.method !== 'GET') return response.status(405).end();

  const { room } = req.query;
  if (!room || !UUID_RE.test(room)) return response.status(400).json({ error: 'invalid room' });

  try {
    const info = await head(`rooms/${room}.json`);
    const fetched = await fetch(info.url + '?nc=' + Date.now());
    const data = await fetched.json();
    return response.json({ state: data.state || null });
  } catch (e) {
    return response.json({ state: null });
  }
}
