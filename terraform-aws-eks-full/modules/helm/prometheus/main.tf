provider "helm" {
  kubernetes {
    host                   = var.kubeconfig_endpoint
    cluster_ca_certificate = base64decode(var.kubeconfig_ca)
    token                  = var.kubeconfig_token
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true
}
