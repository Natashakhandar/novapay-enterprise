output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "rds_cluster_endpoint" {
  value = module.db.cluster_endpoint
}

output "rds_secret_arn" {
  value = module.db.cluster_master_user_secret[0].secret_arn
}
