module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" # Upgraded to use modern v20+ features

  cluster_name    = local.cluster_name
  cluster_version = "1.36" # Upgraded to a supported version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # REQUIRED FOR V20+: Enables the modern AWS EKS Access API 
  enable_cluster_creator_admin_permissions = true 

  eks_managed_node_group_defaults = {
    ami_type = "AL2023_x86_64_STANDARD" # Upgraded to Amazon Linux 2023
  }

  eks_managed_node_groups = {
    general = {
      name           = "node-group-1"
      instance_types = ["m7i-flex.large"] 

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}
