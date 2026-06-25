-- Adaptia RPG - Patch complementar recomendado
-- Rode no SQL Editor do Supabase se ainda nao aplicou estes ajustes.

alter table public.personagens
add column if not exists aparencia jsonb not null default
'{"forma":"escudo","cor":"dourado","icone":"estrela","nivel_visual":1}'::jsonb;

update public.personagens
set aparencia = '{"forma":"escudo","cor":"dourado","icone":"estrela","nivel_visual":1}'::jsonb
where aparencia is null;

do $$
begin
  if exists (select 1 from pg_publication where pubname = 'supabase_realtime') then
    if not exists (
      select 1 from pg_publication_tables
      where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'acoes_jogador'
    ) then
      execute 'alter publication supabase_realtime add table public.acoes_jogador';
    end if;

    if not exists (
      select 1 from pg_publication_tables
      where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'sessoes'
    ) then
      execute 'alter publication supabase_realtime add table public.sessoes';
    end if;

    if not exists (
      select 1 from pg_publication_tables
      where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'participantes_sessao'
    ) then
      execute 'alter publication supabase_realtime add table public.participantes_sessao';
    end if;
  end if;
end;
$$;
