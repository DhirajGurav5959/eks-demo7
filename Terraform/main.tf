terraform {
  backend "s3" {
    bucket = "shiviiii"
    key    = "eks-demo/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.17.0"

  cluster_name    = var.clusterName
  cluster_version = "1.27"

  # NOTE: You must provide valid subnet IDs and VPC ID here
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]   # ✅ moved inside node group
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }
}
