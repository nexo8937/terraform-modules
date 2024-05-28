resource "helm_release" "my_application" {
  name       = "my-release-name"
  chart      = "../helm"  # Path to your local Helm chart
  namespace  = "default"  # Kubernetes namespace to deploy to

values = [
  file("../helm/values_dev.yaml")
]

set {
  name  = "replicaCount"
  value = "3"
 }
}
