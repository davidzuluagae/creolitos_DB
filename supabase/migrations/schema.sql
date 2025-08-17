-- Create roles enum
create type user_role as enum ('admin', 'customer');

-- Profiles table
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role user_role not null default 'customer',
  name text,
  created_at timestamp with time zone default now()
);

-- Events
create table events (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  date timestamptz not null,
  location text,
  price numeric default 0,
  capacity int,
  created_at timestamptz default now()
);

-- RSVPs
create table rsvps (
  id uuid primary key default gen_random_uuid(),
  event_id uuid references events(id) on delete cascade,
  user_id uuid references auth.users(id) on delete cascade,
  status text check (status in ('going','interested','paid')),
  payment_status text check (payment_status in ('pending','paid','failed')),
  created_at timestamptz default now()
);

-- Payments
create table payments (
  id uuid primary key default gen_random_uuid(),
  event_id uuid references events(id) on delete cascade,
  user_id uuid references auth.users(id) on delete cascade,
  stripe_session_id text,
  amount numeric,
  status text check (status in ('pending','paid','failed')),
  created_at timestamptz default now()
);

-- Contact Messages
create table contact_messages (
  id uuid primary key default gen_random_uuid(),
  name text,
  email text,
  message text,
  created_at timestamptz default now()
);

-- Gallery
create table gallery (
  id uuid primary key default gen_random_uuid(),
  title text,
  image_url text,
  description text,
  created_at timestamptz default now()
);

-- Blog Posts
create table blog_posts (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  slug text unique not null,
  excerpt text,
  content text,
  author_id uuid references auth.users(id),
  published_at timestamptz,
  created_at timestamptz default now()
);

-- Enable Row Level Security
alter table profiles enable row level security;
alter table events enable row level security;
alter table rsvps enable row level security;
alter table payments enable row level security;
alter table contact_messages enable row level security;
alter table gallery enable row level security;
alter table blog_posts enable row level security;

