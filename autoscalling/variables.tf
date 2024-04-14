variable "app" {
    description = "Application Name"
    default = ""
}

variable "image_id" {
    default = ""
}

variable "instance_type" {
    default = ""
}

variable "aws_iam_instance_profile" {
    default = ""
}

variable "private_subnets" {
  description = "Private Subnets for autoscalling group"
  default = ""
}

variable "vpc" {
  description = "vpc"
  default = ""
}

###############################################################
variable "desired_capacity" {
    description = "Desired capacity of the autoscaling group"
    default = 1
}

variable "max_size" {
    description = "Maximum size of the autoscaling group"
    default = 2
}

variable "min_size" {
    description = "Minimum size of the autoscaling group"
    default = 1
}

variable "healthy_check_type" {
  description = "The type of healty check"
  default = "ELB"
}

variable "app_port_sg" {
    description = "Autoscaling security group ports"
    type = list
    default = ["3000"]
}

#Autoscaling Policie
variable "policy_adjustment_type" {
  description = "The adjustment type for the autoscaling policy"
  default     = "ChangeInCapacity"
}

variable "policy_scaling_adjustment" {
  description = "The scaling adjustment for the autoscaling policy when scaling up"
  default     = "1"
}

variable "policy_cooldown" {
  description = "The cooldown period for the autoscaling policy "
  default     = "300"
}

variable "down_scaling_adjustment" {
  description = "The scaling adjustment for the autoscaling policy when scaling down"
  default     = -1
}

#CloudWatch Metrics
variable "scale_up_threshold" {
  description = "CPU utilization threshold for triggering scale-up actions"
  default = "80"
}

variable "scale_down_threshold" {
  description = "CPU utilization threshold for triggering scale-down actions"
  default = "20"
}

variable "scale_up_period" {
  description = "The period (in seconds) for evaluating CPU utilization during scale-up"
  default = "120"
}

variable "scale_down_period" {
  description = "The period (in seconds) for evaluating CPU utilization during scale-down"
  default = "120"
}

variable "evaluation_periods" {
  description = "The number of periods for applying the alarm's statistic"
  default = "2"
}
