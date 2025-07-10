provider "helm" {
  kubernetes {
    host                   = var.kubeconfig_endpoint
    cluster_ca_certificate = base64decode(var.kubeconfig_ca)
    token                  = var.kubeconfig_token
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "monitoring"
  create_namespace = true

  set {
    name  = "adminPassword"
    value = var.admin_password
  }
}
