module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "8.3.1"

  name           = "${var.project_name}-aurora-${var.environment}"
  engine         = "aurora-postgresql"
  engine_version = "15.3"
  
  instance_class = "db.r6g.large"
  instances = {
    writer = {}
    reader1 = {}
    reader2 = {}
  }

  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = module.vpc.database_subnet_group_name
  create_db_subnet_group = true
  subnets              = module.vpc.private_subnets

  # Security & Compliance
  storage_encrypted   = true
  apply_immediately   = false
  skip_final_snapshot = false
  deletion_protection = true

  # Auto-generate password and store in Secrets Manager
  manage_master_user_password = true

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
