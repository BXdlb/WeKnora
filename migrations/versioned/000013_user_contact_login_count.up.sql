-- Migration: 000013_user_contact_login_count
-- Description: simplify auth data to identifier-based login and store login counts

ALTER TABLE users ADD COLUMN IF NOT EXISTS contact VARCHAR(255);
ALTER TABLE users ADD COLUMN IF NOT EXISTS login_count BIGINT NOT NULL DEFAULT 0;

UPDATE users
SET contact = COALESCE(NULLIF(contact, ''), email)
WHERE contact IS NULL OR contact = '';

ALTER TABLE users ALTER COLUMN contact SET NOT NULL;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'users_contact_key') THEN
        ALTER TABLE users ADD CONSTRAINT users_contact_key UNIQUE (contact);
    END IF;
END $$;

ALTER TABLE users ALTER COLUMN password_hash DROP NOT NULL;

CREATE INDEX IF NOT EXISTS idx_users_contact ON users(contact);
