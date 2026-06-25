# ERRATA FINDINGS

As per the assessment instructions, here are the 3 deliberate technical errors identified in the project documentation:

### 1. Error in Part A (Compliance/Pipeline Constraints)
**Original Statement:** The document states that DAST scanning (OWASP ZAP) should run in the Staging environment to catch vulnerabilities.
**Correction:** While DAST *can* run in staging, true shift-left DevSecOps mandates that lightweight DAST or IAST runs earlier in the ephemeral test environments or pre-staging integration phases to prevent vulnerable code from ever reaching a shared Staging environment.

### 2. Error in Part C (Cloudflare Case Study)
**Original Statement:** The prompt explicitly hints at an error in the Cloudflare case study regarding the outage duration (stating 21 minutes).
**Correction:** The actual duration of the catastrophic Cloudflare WAF outage on July 2, 2019, was **27 minutes**, not 21 minutes. This highlights the absolute necessity of independent out-of-band rollback systems that do not rely on the primary affected control plane.

### 3. Error in Part D (Deployment Windows)
**Original Statement:** The document suggests defining blackout windows during peak hours.
**Correction:** In a true **Zero-Downtime Architecture** (like the Canary pattern designed here), blackout windows become an anti-pattern. If deployments are truly zero-downtime and automated rollbacks trigger in < 60 seconds, deployments *should* be able to happen at any time, even during peak hours (e.g., Netflix and Amazon deploy during peak). Blackout windows indicate a lack of trust in the CI/CD deployment verification gates.
