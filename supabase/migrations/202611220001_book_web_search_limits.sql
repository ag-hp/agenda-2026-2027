create table public.book_web_search_limits (
  day date not null,
  scope text not null,
  calls integer not null default 0,
  primary key (day, scope)
);

alter table public.book_web_search_limits enable row level security;
revoke all on public.book_web_search_limits from anon, authenticated;

create function public.reserve_book_web_search(p_user_id uuid)
returns boolean
language plpgsql
security definer
set search_path = ''
as $$
declare
  quota_day date := (now() at time zone 'UTC')::date;
  user_scope text := p_user_id::text;
  global_calls integer;
  user_calls integer;
begin
  if p_user_id is null then return false; end if;

  insert into public.book_web_search_limits (day, scope)
  values (quota_day, 'global') on conflict do nothing;

  select calls into global_calls from public.book_web_search_limits
  where day = quota_day and scope = 'global' for update;
  if global_calls >= 40 then return false; end if;

  insert into public.book_web_search_limits (day, scope)
  values (quota_day, user_scope) on conflict do nothing;

  select calls into user_calls from public.book_web_search_limits
  where day = quota_day and scope = user_scope for update;
  if user_calls >= 8 then return false; end if;

  update public.book_web_search_limits set calls = calls + 1
  where day = quota_day and scope in ('global', user_scope);
  return true;
end;
$$;

revoke execute on function public.reserve_book_web_search(uuid) from public, anon, authenticated;
grant execute on function public.reserve_book_web_search(uuid) to service_role;
