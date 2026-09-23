# sky-management

Gestión administrativa, marketing y contable de Sky Ingeniería. Deploy en Vercel, datos en Supabase (project ref `yijrqqorowznclzbwfke`).

## Módulos

- **Link shortener** (`/api/s/[slug].js`): redirige `/s/:slug` al link largo guardado en la tabla `links` de Supabase y cuenta clicks. Pensado para acortar links con UTM para Instagram/campañas.
  - `/s/calculadora_losa` → calculadora de losas
  - `/s/acopio` → calculadora hierro por m²

## Variables de entorno (Vercel)

- `SUPABASE_URL` = `https://yijrqqorowznclzbwfke.supabase.co`
- `SUPABASE_SERVICE_ROLE_KEY` = service role key del proyecto (Supabase → Settings → API)

## Setup DB

Correr en el SQL Editor de Supabase (ver `supabase/migrations`).
