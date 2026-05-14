-- ============================================================
-- SESSION 7: Industry Updates & Certificates
-- ============================================================

-- Industry Updates table
create table if not exists public.industry_updates (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  summary text not null,
  category text default 'general',
  source text,
  relevance text,
  checked_at timestamptz not null default now(),
  dismissed boolean not null default false,
  created_at timestamptz not null default now()
);
alter table public.industry_updates enable row level security;
drop policy if exists "industry_updates_read" on public.industry_updates;
create policy "industry_updates_read" on public.industry_updates for select to authenticated using (true);
drop policy if exists "industry_updates_admin_write" on public.industry_updates;
create policy "industry_updates_admin_write" on public.industry_updates for all
  to authenticated using (get_my_role() in ('admin','approver'));

-- Certificates table
create table if not exists public.certificates (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  user_name text not null,
  user_email text not null,
  exam_score integer not null,
  issued_at timestamptz not null default now(),
  certificate_number text unique not null
);
alter table public.certificates enable row level security;
drop policy if exists "certificates_own_read" on public.certificates;
create policy "certificates_own_read" on public.certificates for select to authenticated
  using (user_id = auth.uid() or get_my_role() in ('admin','approver','mentor'));
drop policy if exists "certificates_insert" on public.certificates;
create policy "certificates_insert" on public.certificates for insert to authenticated
  with check (user_id = auth.uid());
