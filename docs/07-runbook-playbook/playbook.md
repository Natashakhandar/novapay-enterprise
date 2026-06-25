# 07 - Incident Response Playbook

## Production Incident Runbook

This playbook outlines the response architecture for production incidents affecting NovaPay Digital Bank.

### Severity Classifications

| Severity | Definition | Response Time Target | Escalation Path |
| :--- | :--- | :--- | :--- |
| **SEV-1** | Complete service outage or data integrity risk (e.g., UPI payments failing). | < 5 minutes | CTO + CISO + VP Engineering |
| **SEV-2** | Major feature degradation affecting >10% of users. | < 15 minutes | VP Engineering + SRE Lead |
| **SEV-3** | Minor degradation, workaround exists. | < 1 hour | SRE On-Call + Tech Lead |
| **SEV-4** | Cosmetic issue, no user impact. | Next business day | Assigned Engineer |

### The Friday 5 PM Incident Simulation
**Scenario:** A critical hotfix bypassed staging. HTTP 500 errors hit 12%, DB pool exhausted, downstream gateways timing out at 35%.

**Playbook Execution Steps:**
1. **Detection (T+0):** Prometheus fires CRITICAL alert to PagerDuty.
2. **Mitigation (T+1 min):** Argo Rollouts auto-aborts the Canary deployment due to the 12% 500 error rate crossing the 5% threshold. Traffic is 100% routed back to the stable version.
3. **Assessment (T+5 mins):** The SRE verifies via Grafana that the 500 error rate has dropped back to baseline. The DB connection pool recovers.
4. **Communication (T+10 mins):** Status page updated automatically. Stakeholders notified on `#incidents-prod` Slack channel.
5. **Post-Mortem (T+24 hours):** RCA conducted. The pipeline gate that allowed staging bypass is identified and hardened.
