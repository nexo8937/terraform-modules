variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "Image of the container"
  type        = string
}

variable "replica_count" {
  description = "Number of replicas"
  type        = number
}
