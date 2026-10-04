-- Ya aplicado manualmente. Aliases para que sigan funcionando los links viejos
-- ya publicados (bio, DMs, ads) con los slugs anteriores al rename de 0002.

insert into public.links (slug, destination)
select 'losas', destination from public.links where slug = 'calculadora_losas'
union all
select 'hierro', destination from public.links where slug = 'acopio'
on conflict (slug) do nothing;
