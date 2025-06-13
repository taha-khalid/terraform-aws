module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  # seting the name and kubernetes version of the cluster
  # The cluster name is generated using a random string to ensure uniqueness.
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes-version

  # It allows the EKS cluster to installed the default add-ons.
  bootstrap_self_managed_addons = true

  # This enables cluster endpoint access publicly and allows all ips to access it.
  # It doesn't matter if the control plane is private or public, this setting allows the cluster endpoint to be accessed from the internet (laptop)
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  # VPC configuration in which the cluster is deployed
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  # This section defines the defaults for the EKS managed node groups.
  # It specifies the instance types and AMI type for the nodes.
  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]
    ami_type       = "AL2023_x86_64_STANDARD"
  }

  # This section defines the specific EKS managed node group.
  # Using this section the module will deploy a managed node group named my-node-group
  # with a minimum size of 2, maximum size of 4, and desired size of 2 and the defaults followed as mentioned above unless specified otherwise.
  eks_managed_node_groups = {
    my-node-group = {
      min_size     = 2
      max_size     = 4
      desired_size = 2
      labels = {
        "node-group"  = "taha-self-test"
        "environment" = "dev"
        "terraform"   = "true"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
