module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "17.23.0"
  cluster_name    = local.cluster_name
  subnets         = module.vpc.private_subnets

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  node_groups_defaults = {
    ami_type = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {
    example = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 2

      instance_types = ["t2.small"]
    }
  }
}

data "aws_eks_cluster" "this" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_id
}
