output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "vpc_id" {
  description = "VPC ID where the EKS cluster is deployed."
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnets in the VPC."
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnets in the VPC."
  value       = module.vpc.public_subnets
}
