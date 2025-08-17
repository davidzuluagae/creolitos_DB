-- Everyone can read gallery items
create policy "Customers read gallery"
on gallery for select
to authenticated
using (true);

-- Only admins can manage gallery
create policy "Admins manage gallery"
on gallery for all
to authenticated
using (exists (
  select 1 from profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

