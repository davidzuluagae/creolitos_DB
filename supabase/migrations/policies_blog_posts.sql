-- Customers can read blog posts
create policy "Customers read blog posts"
on blog_posts for select
to authenticated
using (true);

-- Only admins can insert/update/delete blog posts
create policy "Admins manage blog posts"
on blog_posts for all
to authenticated
using (exists (
  select 1 from profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

