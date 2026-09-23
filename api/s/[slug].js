// api/s/[slug].js
// Link shortener — redirige /s/:slug al link largo (con UTMs) guardado en Supabase
// y suma el click. Pensado para links cortos en bio/DM de Instagram y otras campañas.

export default async function handler(req, res) {
  const { slug } = req.query;

  if (!slug) {
    return res.status(400).send('Falta el slug');
  }

  try {
    const response = await fetch(
      `${process.env.SUPABASE_URL}/rest/v1/rpc/increment_link_click`,
      {
        method: 'POST',
        headers: {
          apikey: process.env.SUPABASE_SERVICE_ROLE_KEY,
          Authorization: `Bearer ${process.env.SUPABASE_SERVICE_ROLE_KEY}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ p_slug: slug }),
      }
    );

    if (!response.ok) {
      console.error('Supabase RPC error', await response.text());
      return res.status(500).send('Error');
    }

    const destination = await response.json();

    if (!destination) {
      return res.status(404).send('Link no encontrado');
    }

    res.writeHead(302, { Location: destination });
    res.end();
  } catch (err) {
    console.error(err);
    res.status(500).send('Error');
  }
}
