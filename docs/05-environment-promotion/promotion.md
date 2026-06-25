# 05 - Environment Promotion Workflow

## 4-Environment Model

NovaPay uses a strictly gated 4-environment architecture to promote code.

### 1. Development (DEV)
- **Trigger:** Automated on feature branch PR.
- **Data:** Mock/Synthetic data.
- **Gates:** 80% Unit Test Coverage, SAST (0 Critical).

### 2. Staging (STG)
- **Trigger:** Automated upon merge to `main`.
- **Data:** Anonymized production-like data.
- **Gates:** Integration Tests, DAST Scan, Container Image Signing, Trivy SBOM Check.

### 3. Pre-Production (PRE-PROD)
- **Trigger:** Manual trigger after QA sign-off in Staging.
- **Data:** Masked production data.
- **Gates:** Performance/Load Testing, UAT approval, Database Migration simulation.

### 4. Production (PROD)
- **Trigger:** Dual Approval (Release Manager + SRE Lead).
- **Data:** Live Financial Data.
- **Gates:** Segregation of Duties. ArgoCD syncs the deployment. Argo Rollouts handles the 5% Canary release.
