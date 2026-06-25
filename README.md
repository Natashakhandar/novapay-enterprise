# NovaPay Digital Bank - Enterprise DevSecOps Platform

This repository represents the complete, production-grade enterprise DevSecOps implementation for NovaPay Digital Bank. It solves 17 outstanding RBI audit non-conformances by enforcing Zero-Trust, GitOps, and fully automated compliance pipelines.

## Repository Structure

*   `terraform/`: AWS Infrastructure (EKS, RDS, VPC)
*   `app/`: Core banking application (Distroless Dockerfile, Docker Compose)
*   `helm/novapay-api/`: Kubernetes configurations for the application
*   `k8s-infrastructure/`: ArgoCD, Istio, OPA, Kyverno, and Security Policies
*   `.github/workflows/`: Full CI/CD, DAST, and Rollback automation
*   `monitoring/`: Prometheus and Grafana configurations
*   `db/migrations/`: Zero-downtime database schemas
*   `runbooks/`: Incident response and disaster recovery procedures
*   `docs/`: Architecture diagrams and Compliance mappings

## Quick Start
1. Provision infrastructure: `cd terraform && terraform apply`
2. Deploy application: Push to `main` to trigger the CI/CD pipeline.
3. Review security policies in `k8s-infrastructure/compliance`.
