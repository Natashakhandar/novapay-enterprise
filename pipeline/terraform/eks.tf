module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = "${var.project_name}-eks-${var.environment}"
  cluster_version = "1.28"

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # Security: Disable public endpoint for RBI compliance
  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  # Enable Secret Encryption with KMS
  create_kms_key = true
  cluster_encryption_config = {
    resources = ["secrets"]
  }

  # Enable OIDC for IAM Roles for Service Accounts (IRSA)
  enable_irsa = true

  eks_managed_node_groups = {
    banking_core = {
      min_size     = 3
      max_size     = 10
      desired_size = 3
      instance_types = ["m6i.large"]
      capacity_type  = "ON_DEMAND"
      
      # Encryption at rest for node EBS volumes
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 50
            volume_type           = "gp3"
            encrypted             = true
            delete_on_termination = true
          }
        }
      }
    }
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
