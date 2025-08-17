-- Customers can create RSVPs only for themselves
create policy "Customers create own RSVPs"
on rsvps for insert
to authenticated
with check (user_id = auth.uid());

-- Customers can read their own RSVPs
create policy "Customers read own RSVPs"
on rsvps for select
to authenticated
using (user_id = auth.uid());

-- Admins can see/manage all RSVPs
create policy "Admins manage RSVPs"
on rsvps for all
to authenticated
using (exists (
  select 1 from profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

