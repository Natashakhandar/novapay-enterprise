-- Zero Downtime Migration: Expand Phase
-- Adds new columns without default values to avoid table locking on large tables.

DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name='transactions' AND column_name='currency_code') THEN
        ALTER TABLE transactions ADD COLUMN currency_code VARCHAR(3);
        ALTER TABLE transactions ADD COLUMN fx_rate DECIMAL(10, 4);
    END IF;
END $$;
