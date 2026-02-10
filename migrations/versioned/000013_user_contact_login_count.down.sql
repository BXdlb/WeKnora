-- Migration: 000013_user_contact_login_count (down)

DROP INDEX IF EXISTS idx_users_contact;
ALTER TABLE users DROP CONSTRAINT IF EXISTS users_contact_key;
ALTER TABLE users DROP COLUMN IF EXISTS login_count;
ALTER TABLE users DROP COLUMN IF EXISTS contact;
ALTER TABLE users ALTER COLUMN password_hash SET NOT NULL;
