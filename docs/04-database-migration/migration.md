# 04 - Zero-Downtime Database Migration

## The Expand-Contract Pattern

Banking databases cannot experience downtime during schema changes. NovaPay utilizes the **Expand-Contract** pattern implemented via Flyway scripts.

### Phase 1: EXPAND (`V1_0_1__expand_schema.sql`)
- Add the new column/table without modifying existing data.
- Ensure the new column is nullable or has a default value so old code (`v1.0`) can still write to it without errors.
- Both `v1.0` and `v2.0` of the application can run simultaneously.

### Phase 2: MIGRATE (Background Job)
- Backfill historical data into the new columns.
- Done in small batches to avoid locking massive financial tables.

### Phase 3: CONTRACT (`V1_0_2__contract_schema.sql`)
- Drop the old column/table only after confirming that **no `v1.0` pods** remain and all data is successfully backfilled.
- This phase is irreversible and requires separate TRC approval.

### Rollback (`U1_0_1__rollback_schema.sql`)
If the EXPAND phase causes issues, the rollback script safely drops the new, unused columns without touching the primary data.
