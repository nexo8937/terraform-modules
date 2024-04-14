variable "app" {
    description = "Application Name"
    default = "application"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_ciders" {
   default = [
      "10.0.11.0/24"
  ]
}

variable "private_subnet_ciders" {
   default = [
      "10.0.21.0/24"
  ]
}
