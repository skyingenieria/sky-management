-- Link shortener: tabla + función de redirect con conteo de clicks.
-- RLS habilitado sin policies: solo accesible via service_role key (bypassa RLS).

create table public.links (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  destination text not null,
  clicks integer not null default 0,
  created_at timestamptz not null default now(),
  last_clicked_at timestamptz
);

alter table public.links enable row level security;

create or replace function public.increment_link_click(p_slug text)
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
  dest text;
begin
  update public.links
    set clicks = clicks + 1, last_clicked_at = now()
    where slug = p_slug
    returning destination into dest;
  return dest;
end;
$$;

insert into public.links (slug, destination) values
('hierro', 'https://skyingenieria.com/herramientas/hierro-por-m2?utm_source=instagram&utm_medium=bio&utm_campaign=calculadora-hormigon'),
('losas', 'https://skyingenieria.com/herramientas/losas?utm_source=instagram&utm_medium=bio&utm_campaign=calculadora-losas');
