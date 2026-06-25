-- Zero Downtime Migration: Rollback Script
-- Safely drops the columns if the migration needs to be reverted in lower environments.

ALTER TABLE transactions DROP COLUMN IF EXISTS currency_code;
ALTER TABLE transactions DROP COLUMN IF EXISTS fx_rate;
