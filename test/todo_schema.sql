CREATE DOMAIN todo_time AS TIMESTAMP
  WITH TIME ZONE DEFAULT NOW() NOT NULL;

CREATE TYPE priority_enum AS ENUM ('cool', 'warm',
                                   'hot', 'burning');

CREATE TABLE todo_items (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL UNIQUE,
  priority priority_enum NOT NULL DEFAULT 'warm',
  description TEXT,
  created_at todo_time,
  created_by TEXT NOT NULL
);
