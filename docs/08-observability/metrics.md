# 08 - Observability & DORA Metrics

## Elite DevOps Performance

NovaPay's pipeline architecture is designed to achieve and measure "Elite" performance across all 4 DORA metrics, monitored via our generated Grafana dashboards.

### 1. Deployment Frequency
**Goal:** Multiple deployments per day.
**Measurement:** Number of successful GitHub Actions workflows (`cd.yml`) that resulted in an ArgoCD sync to production.

### 2. Lead Time for Changes
**Goal:** < 1 hour.
**Measurement:** Timestamp difference between the initial git commit and the ArgoCD successful deployment webhook event. The highly parallelized GitHub Actions CI workflow (caching Maven dependencies and Docker layers) ensures builds complete in minutes.

### 3. Change Failure Rate
**Goal:** < 5%.
**Measurement:** The ratio of deployments that trigger an automated Argo Rollout abort or require a manual hotfix, compared to the total number of deployments. The extensive 6 compliance gates and DAST/SAST testing ensure broken code rarely makes it to production.

### 4. Mean Time to Recovery (MTTR)
**Goal:** < 15 minutes (Down from the original 4.5 hours).
**Measurement:** Time from the first Prometheus CRITICAL alert firing to the Argo Rollouts fallback completing. The automated Category A rollback triggers handle failures in < 60 seconds, drastically reducing MTTR to near-zero.
