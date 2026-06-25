# Incident Response Runbook

## 1. Initial Triage
- **Acknowledge Alert:** Respond in `#incidents-prod` channel.
- **Check Dashboards:** Review Grafana `DORA Metrics & SLI Dashboard`.
- **Identify Scope:** Is it a specific API (e.g., `/payments`) or cluster-wide?

## 2. Investigation
- **Logs:** Check Loki for HTTP 5xx errors or exceptions.
- **Metrics:** Review Prometheus for CPU/Memory throttling on EKS.
- **Recent Deployments:** Check ArgoCD for recent syncs or GitOps commits.

## 3. Mitigation (Break-Glass)
- If the issue is tied to a recent deployment, immediately trigger the **Emergency Manual Rollback** GitHub Action.
- If it's a database lock, execute `pg_cancel_backend(pid)` on the blocking queries.

## 4. Resolution & Postmortem
- Stabilize the system.
- Create a Postmortem document covering Root Cause, Timeline, and Action Items.
