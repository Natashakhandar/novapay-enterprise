# Disaster Recovery Plan

## Objective
Restore NovaPay operations in a secondary AWS Region (`ap-south-2`) within the 4-hour RTO.

## Prerequisites
- Terraform state must be available in the cross-region replicated S3 bucket.
- RDS automated snapshots must be available in the secondary region.

## Execution Steps

1. **Infrastructure Provisioning:**
   ```bash
   cd terraform
   terraform workspace select dr-region
   terraform apply -var="aws_region=ap-south-2" -auto-approve
   ```

2. **Database Restoration:**
   - Terraform will automatically spin up RDS from the latest cross-region snapshot.

3. **Application Deployment:**
   - Update ArgoCD cluster credentials to point to the new DR EKS cluster.
   - ArgoCD will automatically sync all applications from Git, matching the exact state of Production before the outage.

4. **DNS Switch:**
   - Update Route53 failover records to point `payments.novapay.com` to the DR Application Load Balancer.
