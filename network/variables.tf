variable "app" {
    description = "Application Name"
    default = ""
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = ""
}

variable "public_subnet_ciders" {
   default = [
      ""
  ]
}

variable "private_subnet_ciders" {
   default = [
      ""
  ]
}
