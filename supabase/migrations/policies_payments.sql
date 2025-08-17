-- Customers can create payments only for themselves
create policy "Customers create own payments"
on payments for insert
to authenticated
with check (user_id = auth.uid());

-- Customers can read only their own payments
create policy "Customers read own payments"
on payments for select
to authenticated
using (user_id = auth.uid());

-- Admins manage all payments
create policy "Admins manage payments"
on payments for all
to authenticated
using (exists (
  select 1 from profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

