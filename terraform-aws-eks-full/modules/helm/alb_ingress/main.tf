provider "helm" {
  kubernetes {
    host                   = var.kubeconfig_endpoint
    cluster_ca_certificate = base64decode(var.kubeconfig_ca)
    token                  = var.kubeconfig_token
  }
}

resource "helm_release" "alb_ingress" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
  set {
    name  = "region"
    value = var.aws_region
  }
  set {
    name  = "vpcId"
    value = var.vpc_id
  }
}
