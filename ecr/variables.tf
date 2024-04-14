variable "ecr_repo_name" {
  description = "The name of ecr repository"
  default     = [
    "application"
    ]
}

variable "app" {
    description = "Application Name"
    default = "application"
}
