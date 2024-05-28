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

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace to deploy to"
  type        = string
  default     = "default"
}
