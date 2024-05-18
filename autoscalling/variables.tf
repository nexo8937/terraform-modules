variable "app" {
    description = "Application Name"
    default = ""
}

# launch-template
variable "image_id" {
    default = ""
}

variable "instance_type" {
    default = ""
}

variable "aws_iam_instance_profile" {
    default = ""
}

variable "database_sg" {
    default = ""
}


variable "user-data-file" {
    default = ""
}

# network
variable "private_subnets" {
  description = "Private Subnets for autoscalling group"
  default = ""
}

variable "vpc" {
  description = "vpc"
  default = ""
}

# autoscalling-group
variable "desired_capacity" {
    description = "Desired capacity of the autoscaling group"
    default = ""
}

variable "max_size" {
    description = "Maximum size of the autoscaling group"
    default = ""
}

variable "min_size" {
    description = "Minimum size of the autoscaling group"
    default = ""
}

variable "healthy_check_type" {
  description = "The type of healty check"
  default = ""
}

variable "app_port_sg" {
    description = "Autoscaling security group ports"
    type = list
    default = [""]
}

variable "target_group" {
    description = "load balancer target group"
    default = ""
}

# Autoscaling Policie
variable "policy_adjustment_type" {
  description = "The adjustment type for the autoscaling policy"
  default     = ""
}

variable "policy_scaling_adjustment" {
  description = "The scaling adjustment for the autoscaling policy when scaling up"
  default     = "1"
}

variable "policy_cooldown" {
  description = "The cooldown period for the autoscaling policy "
  default     = ""
}

variable "down_scaling_adjustment" {
  description = "The scaling adjustment for the autoscaling policy when scaling down"
  default     = ""
}

# CloudWatch Metrics
variable "scale_up_threshold" {
  description = "CPU utilization threshold for triggering scale-up actions"
  default = ""
}

variable "scale_down_threshold" {
  description = "CPU utilization threshold for triggering scale-down actions"
  default = ""
}

variable "scale_up_period" {
  description = "The period (in seconds) for evaluating CPU utilization during scale-up"
  default = ""
}

variable "scale_down_period" {
  description = "The period (in seconds) for evaluating CPU utilization during scale-down"
  default = ""
}

variable "evaluation_periods" {
  description = "The number of periods for applying the alarm's statistic"
  default = ""
}
