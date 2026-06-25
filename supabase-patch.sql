-- Adaptia RPG - Patch completo
-- Rode no SQL Editor do Supabase antes/depois de subir os HTMLs.

-- Aparencia do brasao/emblema
alter table public.personagens
add column if not exists aparencia jsonb not null default
'{"forma":"escudo","cor":"dourado","icone":"estrela","nivel_visual":1}'::jsonb;

update public.personagens
set aparencia = '{"forma":"escudo","cor":"dourado","icone":"estrela","nivel_visual":1}'::jsonb
where aparencia is null;

-- Dono do personagem para login por Supabase Auth
alter table public.personagens
add column if not exists owner_id uuid references auth.users(id) on delete set null;

create index if not exists idx_personagens_owner_id
on public.personagens(owner_id);

-- Perfil simples do usuario da Adaptia
create table if not exists public.perfis_adaptia (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null,
  nome_exibicao text,
  criado_em timestamptz not null default now()
);

alter table public.perfis_adaptia enable row level security;

drop policy if exists "perfil_select_own" on public.perfis_adaptia;
drop policy if exists "perfil_insert_own" on public.perfis_adaptia;
drop policy if exists "perfil_update_own" on public.perfis_adaptia;

create policy "perfil_select_own"
on public.perfis_adaptia
for select
to authenticated
using ((select auth.uid()) = id);

create policy "perfil_insert_own"
on public.perfis_adaptia
for insert
to authenticated
with check ((select auth.uid()) = id);

create policy "perfil_update_own"
on public.perfis_adaptia
for update
to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);

-- Politicas de personagens para login sem quebrar a Tela do Mestre
alter table public.personagens enable row level security;

drop policy if exists "personagens_select_public_internal" on public.personagens;
drop policy if exists "personagens_insert_authenticated_owner" on public.personagens;
drop policy if exists "personagens_update_owner_or_import" on public.personagens;
drop policy if exists "personagens_delete_owner" on public.personagens;

create policy "personagens_select_public_internal"
on public.personagens
for select
to anon, authenticated
using (true);

create policy "personagens_insert_authenticated_owner"
on public.personagens
for insert
to authenticated
with check (owner_id = (select auth.uid()));

create policy "personagens_update_owner_or_import"
on public.personagens
for update
to authenticated
using (owner_id = (select auth.uid()) or owner_id is null)
with check (owner_id = (select auth.uid()));

create policy "personagens_delete_owner"
on public.personagens
for delete
to authenticated
using (owner_id = (select auth.uid()));

-- Realtime necessario para Tela do Mestre e Controle
-- Observacao: se algum ALTER PUBLICATION reclamar que a tabela ja existe, ignore ou use o bloco abaixo.
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
