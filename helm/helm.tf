resource "helm_release" "my_application" {
  name       = "my-release-name"
  chart      = "../../helm"  # Path to your local Helm chart
  namespace  = "default"  # Kubernetes namespace to deploy to

  # Optionally, specify values
values = [
  file("../../helm/values_dev.yaml")
]
  # Or directly set values
  set {
    name  = "replicaCount"
    value = "3"
  }




  set {
    name  = "container.name"
    value = var.container_name
  }

  set {
    name  = "container.image"
    value = var.container_image
  }


}
