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

  cluster_name    = var.cluster_name     # ✅ match declared name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id                # ✅ must declare below
  subnet_ids = var.subnet_ids            # ✅ must declare below

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      instance_types = var.instance_types
      min_size       = var.cluster_min_size
      max_size       = var.cluster_max_size
      desired_size   = var.cluster_desired_size
    }
  }
}
