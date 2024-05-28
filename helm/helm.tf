resource "helm_release" "my_application" {
  name       = var.release_name
  chart      = var.helm_chart_path
  values     = [file(var.values_file_path)] 

#values = [
#  file("../../helm/values_dev.yaml")
#]

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

