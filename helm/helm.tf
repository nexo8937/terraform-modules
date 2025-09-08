resource "helm_release" "my_application" {
  name   = var.release_name
  chart  = var.helm_chart_path
  values = [file(var.values_file_path)]

  set = [
    {
      name  = "replicacount"
      value = var.replica_count
    },
    {
      name  = "container.name"
      value = var.container_name
    },
    {
      name  = "container.image"
      value = var.container_image
    }
  ]
}
