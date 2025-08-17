-- Everyone can read their own profile
create policy "Users can read own profile"
on profiles for select
to authenticated
using (id = auth.uid());

-- Users can update only their own profile
create policy "Users can update own profile"
on profiles for update
to authenticated
using (id = auth.uid());

-- Only admins can read/update all profiles
create policy "Admins manage profiles"
on profiles for all
to authenticated
using (exists (
  select 1 from profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

