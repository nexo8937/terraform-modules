###################
##  Autoscaling  ##
###################

#Launch Tamplate
resource "aws_launch_template" "launch-template" {
  name                   = "${var.app}-launch-template"
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.autoscaling-sg.id]
  user_data              = base64encode(file("user_data.sh"))

  iam_instance_profile {
    name = var.aws_iam_instance_profile
  }

  lifecycle {
    create_before_destroy = true
  }
}

#Autoscaling Group
resource "aws_autoscaling_group" "autoscaling-group" {
  name                      = "${var.app}-autoscaling-group-${aws_launch_template.launch-template.latest_version}"
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_type         = var.healthy_check_type
  vpc_zone_identifier       = [var.private_subnets]
#  target_group_arns         = [aws_lb_target_group.target-group.arn]
  launch_template {
    id      = aws_launch_template.launch-template.id
    version = aws_launch_template.launch-template.latest_version
  }
  lifecycle {
    create_before_destroy = true
  }
}

#Autoscaling SECURITY GROUP
resource "aws_security_group" "autoscaling-sg" {
  name        = "${var.app}-autoscaling-security-group"
  vpc_id      = var.vpc
  description = "Allow http"

  dynamic "ingress" {
    for_each = var.app_port_sg
    content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app} Autoscaling Security Group"
  }
}


#Autoscaling Policie up
resource "aws_autoscaling_policy" "atoscaling-policy-up" {
  name                   = "${var.app}-policy-up"
  autoscaling_group_name = aws_autoscaling_group.autoscaling-group.name
  adjustment_type        = var.policy_adjustment_type
  scaling_adjustment     = var.policy_scaling_adjustment
  cooldown               = var.policy_cooldown
  policy_type            = "SimpleScaling"
}

#Scale UP Alarm
resource "aws_cloudwatch_metric_alarm" "scale-up-alarm" {
  alarm_name          = "${var.app}-scale-up-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.scale_up_period
  statistic           = "Average"
  threshold           = var.scale_up_threshold
  dimensions = {
    "autoscalinggroupname" = aws_autoscaling_group.autoscaling-group.name
  }
  alarm_actions     = [aws_autoscaling_policy.atoscaling-policy-up.arn]
}


#Autoscaling Policie down
resource "aws_autoscaling_policy" "atoscaling-policy-down" {
  name                   = "${var.app}-policy-down"
  scaling_adjustment     = -1
  adjustment_type        = var.policy_adjustment_type
  cooldown               = var.policy_cooldown
  autoscaling_group_name = aws_autoscaling_group.autoscaling-group.name
  policy_type            = "SimpleScaling"
}

#Scale DOWN Alarm
resource "aws_cloudwatch_metric_alarm" "scale-down-alarm" {
  alarm_name          = "scale-down-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.scale_down_period
  statistic           = "Average"
  threshold           = var.scale_down_threshold
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling-group.name
  }
  alarm_actions     = [aws_autoscaling_policy.atoscaling-policy-down.arn]
}

