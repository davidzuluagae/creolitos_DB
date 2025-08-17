-- Anyone authenticated can create a message
create policy "Users can submit contact messages"
on contact_messages for insert
to authenticated
with check (true);

-- Only admins can read/manage contact messages
create policy "Admins manage contact messages"
on contact_messages for all
to authenticated
using (exists (
  select 1 from profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

