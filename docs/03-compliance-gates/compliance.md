# 03 - Compliance Gates

## Automated Compliance and Regulatory Mapping

To address the 17 outstanding RBI audit non-conformances, the CI/CD pipeline enforces 6 strict automated gates:

1. **SAST Gate (SonarQube):** Fails the build if any Critical/High vulnerabilities are detected. Mapped to PCI-DSS Req 6.2.
2. **DAST Gate (OWASP ZAP):** Blocks staging promotion if runtime vulnerabilities exist. Mapped to PCI-DSS Req 6.4.
3. **Dependency Scanning (Trivy):** Halts CI if CVSS scores > 8.0 are found in third-party libraries. Generates CycloneDX SBOM.
4. **Segregation of Duties (RBAC):** Developers cannot deploy to production. ArgoCD manages deployments using dedicated Kubernetes ServiceAccounts. Mapped to RBI IT Framework Section 4.3.
5. **Kubernetes Policy Engine (OPA/Kyverno):**
   - Blocks containers running as `root`.
   - Requires `ReadOnlyRootFilesystem`.
6. **Supply Chain Security (Cosign):** The Kyverno Admission Controller rejects any container image that is not cryptographically signed.
