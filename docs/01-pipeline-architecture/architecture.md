# 01 - Pipeline Architecture

## The 8-Stage Canonical Pipeline

This repository implements the mandatory 8-stage CI/CD pipeline using GitHub Actions, fulfilling all requirements for NovaPay Digital Bank:

1. **Source Control & Trigger:** GitHub Flow with branch protection rules on `main`. Pushes trigger the `.github/workflows/ci.yml`.
2. **Build & Compilation:** Multi-stage Docker builds reducing image size by 80% (using Distroless Java base).
3. **Static Analysis (SAST):** SonarQube integration blocking builds with Critical or High vulnerabilities.
4. **Dependency & Container Scanning:** Trivy scans the Docker image. CycloneDX SBOM is generated and attached as a build artifact.
5. **Integration Testing:** Spring Boot TestContainers are utilized for ephemeral integration testing against PostgreSQL.
6. **Dynamic Analysis (DAST):** OWASP ZAP Baseline Scan runs against the deployed staging container (`dast.yml`).
7. **Policy & Compliance Gates:** OPA (Rego) and Kyverno block privileged containers and require Cosign image signatures.
8. **Deployment with Verification:** ArgoCD pulls the manifest, and Argo Rollouts initiates the Canary deployment with Prometheus metric verification.

### Architecture Diagram Reference
Refer to the `docs/ARCHITECTURE.md` file for the Mermaid flowchart representing the complete DevSecOps flow from Developer Commit to EKS Production.
