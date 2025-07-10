provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "dev-vpc"
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "dev-eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "eks_node_role" {
  name = "dev-eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

module "eks" {
  source               = "../../modules/eks"
  cluster_name         = "dev-eks-cluster"
  cluster_role_arn     = aws_iam_role.eks_cluster_role.arn
  subnet_ids           = [module.vpc.vpc_id] # normally you'd use public/private subnet ids
  kubernetes_version   = "1.28"
  tags                 = { env = "dev" }
}

module "node_group" {
  source            = "../../modules/node_groups"
  cluster_name      = module.eks.cluster_id
  node_group_name   = "dev-node-group"
  node_role_arn     = aws_iam_role.eks_node_role.arn
  subnet_ids        = [module.vpc.vpc_id]
  desired_size      = 2
  max_size          = 3
  min_size          = 1
  instance_types    = ["t3.medium"]
  tags              = { env = "dev" }
}
