variable "app" {
    description = "Application Name"
    default = ""
}

# network
variable "vpc" {
  description = "vpc"
  default = ""
}

variable "public_subnets" {
  description = "Private Subnets for autoscalling group"
  default = ""
}

# load-balancer
variable "app_lb_port_sg" {
    description = "Loadbalancer security group ports"
    type = list
    default = [""]
}

variable "lb_listner_port" {
    description = "The port for the load balancer listener"
    default = ""
}

variable "load_balancer_type" {
  description = "Type of the load balancer"
  default     = ""
}

# target-group
variable "target_port" {
  description = "The port for the target group"
  default = ""
}

variable "protocol" {
  description = "Protocol used for health checks"
  default     = ""
}

variable "health_check_path" {
  description = "Endpoint path for health checks"
  default     = ""
}

variable "health_check_port" {
  description = "Port on which health checks are performed"
  default     = ""
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive successful health checks to consider an instance healthy"
  default     = ""
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive failed health checks to consider an instance unhealthy"
  default     = ""
}

variable "health_check_timeout" {
  description = "Time, in seconds, that the health check waits for a response"
  default     = ""
}

variable "health_check_interval" {
  description = "Interval, in seconds, between health checks"
  default     = ""
}

variable "health_check_matcher" {
  description = "String to match against the response to determine if the health check is successful"
  default     = ""
}

