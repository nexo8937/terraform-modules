resource "helm_release" "application" {
  name       = var.name
  chart      = var.chart
  namespace  = "var.namespace

values = [
  file("../helm/values_dev.yaml")
]

set {
  name  = "replicaCount"
  value = var.replicaCount
 }
}

set {
  name  = "replicaCount"
  value = var.replicaCount
 }
}
