# Compliance Mapping

## RBI Master Direction on Digital Payment Security Controls

| RBI Requirement | Implementation | Technical Component |
| :--- | :--- | :--- |
| **Segregation of Duties** | Developers cannot deploy to prod. ArgoCD handles syncs via CI automation. | GitHub Environments, ArgoCD, Kubernetes RBAC |
| **Vulnerability Assessment** | SAST and DAST run on every commit. Container scanning runs on builds. | SonarQube, ZAP, Trivy |
| **Audit Logging** | EKS Audit Logs, VPC Flow Logs, and RDS Logs are exported to CloudWatch. | AWS CloudWatch, Fluent Bit |
| **Incident Response** | Automated rollbacks on high error rates; defined DR runbooks. | Argo Rollouts, Prometheus, Terraform |

## PCI DSS v4.0

| PCI DSS Requirement | Implementation | Technical Component |
| :--- | :--- | :--- |
| **Req 3: Protect Stored Data** | EBS volumes and RDS storage are encrypted at rest using KMS. | AWS KMS, Terraform `encrypted=true` |
| **Req 4: Protect Data in Transit** | Istio enforces strict mTLS between all pods. External traffic uses TLS 1.3. | Istio Service Mesh |
| **Req 6: Secure Systems/Apps** | Containers run as non-root; OPA blocks privilege escalation. | OPA Rego Policies, Kyverno |
