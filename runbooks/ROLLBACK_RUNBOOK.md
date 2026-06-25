# Rollback Runbook

## Automated Rollbacks
NovaPay uses Argo Rollouts for automated rollbacks. If the `success-rate-analysis` drops below 99% during a Canary deployment, Argo will inherently abort and scale back the stable ReplicaSet. **No human intervention is required.**

## Manual Rollbacks (Emergency)
If automated detection fails (e.g., logical error without HTTP 500s), execute a manual rollback:

### Method 1: GitHub Actions (Preferred)
1. Go to GitHub Actions -> `Emergency Manual Rollback`.
2. Click "Run Workflow".
3. Enter the service name (e.g., `novapay-payments`).

### Method 2: CLI (Break-Glass)
If GitHub is down, access the cluster via Bastion and run:
```bash
./scripts/execute-rollback.sh novapay-payments payments-prod
```
