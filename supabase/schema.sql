-- Old Habits — Supabase schema
-- Run this once in your Supabase project's SQL Editor (Supabase Dashboard -> SQL Editor -> New query)

create table if not exists app_storage (
  key text primary key,
  value jsonb not null,
  updated_at timestamptz not null default now()
);

-- Row Level Security: enabled, with a permissive policy.
-- Why permissive: this app's admin protection is a password screen inside the app itself
-- (not Supabase auth), matching how it worked inside Claude. Anyone with your Supabase
-- URL and anon key could technically read/write this table directly, bypassing the app.
-- That's an acceptable tradeoff for a small shop's own data at this stage, same as before,
-- but worth knowing. A future upgrade path is Supabase Auth + per-row policies if you want
-- real server-side enforcement instead of an app-level password.

alter table app_storage enable row level security;

create policy "Allow all reads" on app_storage
  for select using (true);

create policy "Allow all writes" on app_storage
  for insert with check (true);

create policy "Allow all updates" on app_storage
  for update using (true);
