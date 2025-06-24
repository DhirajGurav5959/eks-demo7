terraform {
  backend "s3" {
    bucket = "shiviiii"  # Replace with your actual bucket
    key    = "eks-demo/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.17.0"

  cluster_name         = var.clusterName
  cluster_version      = "1.27"
  subnet_ids           = []
  vpc_id               = ""
  instance_types       = ["t3.small"]
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}
