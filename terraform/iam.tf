# OIDC Provider for GitHub Actions (Eliminates long-lived AWS keys)
module "iam_github_oidc_provider" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
  version = "5.30.0"
}

module "iam_github_oidc_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "5.30.0"

  name = "GitHubActionsDeployRole"
  subjects = [
    "repo:NovaPay-Bank/novapay-enterprise:ref:refs/heads/main"
  ]

  policies = {
    EKSDeployPolicy = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    ECRPushPolicy   = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  }
}

# IAM Role for Service Accounts (IRSA) - External Secrets Operator
module "external_secrets_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.30.0"

  role_name = "external-secrets-operator-${var.environment}"
  attach_external_secrets_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:external-secrets"]
    }
  }
}
