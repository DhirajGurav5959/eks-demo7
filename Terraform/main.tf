module "vpc" {
  source     = "./modules/vpc"
  vpc_name   = var.vpc_name
  vpc_cidr   = var.vpc_cidr
  region     = var.region
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = var.cluster_name
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
  eks_version     = var.eks_version
}

module "node_group" {
  source              = "./modules/node-group"
  cluster_name        = module.eks.cluster_name
  node_group_name     = "${var.cluster_name}-node-group"
  subnet_ids          = module.vpc.public_subnets
  instance_types      = [var.node_instance_type]
  desired_size        = var.desired_size
  max_size            = var.max_size
  min_size            = var.min_size
}