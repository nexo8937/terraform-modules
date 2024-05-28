resource "helm_release" "my_application" {
  name       = var.release_name
  chart      = "../../helm"  # Path to your local Helm chart
  namespace  = "dev"

values = [
  file("../../helm/values_dev.yaml")
]
  set {
    name  = "replicacount"
    value = var.replica_count
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


resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespcae
  }
}
