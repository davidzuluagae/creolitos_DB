-- Customers can read events
create policy "Customers can read events"
on events for select
to authenticated
using (true);

-- Only admins can insert/update/delete events
create policy "Admins manage events"
on events for all
to authenticated
using (exists (
  select 1 from profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

