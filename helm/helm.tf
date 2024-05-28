resource "helm_release" "application" {
  name       = var.name
  chart      = var.chart
  namespace  = "var.namespace

values = [
  var.values
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
