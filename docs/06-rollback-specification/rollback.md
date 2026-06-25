# 06 - Automated Rollback Specification

## Incident Auto-Remediation

To achieve a Mean Time To Recovery (MTTR) of < 15 minutes, NovaPay implements automated rollbacks categorized by severity.

### Category A: Immediate (< 60 seconds)
Handled completely autonomously by Argo Rollouts AnalysisTemplates.
**Triggers:**
- HTTP 500 error rate > 5% for 60 seconds.
- Kubernetes Pod Health Check Failure (3 consecutive).
- Database connection pool exhaustion.
**Action:** The Canary deployment is instantly aborted, and 100% of traffic is immediately routed back to the stable `v1.0` ReplicaSet. No human intervention required.

### Category B: Escalated (< 15 minutes)
Handled by Prometheus AlertManager and PagerDuty routing.
**Triggers:**
- API Latency (p99) > 2x the normal baseline for 5 minutes.
- CPU > 90% sustained.
**Action:** Alerts the on-call SRE. If no acknowledgement is received within 5 minutes, an automated rollback is triggered via the CI/CD pipeline API.

### Category C: Manual Decision
**Triggers:**
- Minor degradation, customer support reports, non-critical downstream failures.
**Action:** SRE triggers the `./scripts/execute-rollback.sh` runbook manually.
