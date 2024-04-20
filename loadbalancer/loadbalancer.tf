###################
## Load Balancer ##
###################

resource "aws_lb" "load-balancer" {
  name                 = "${var.app}-load-balancer"
  load_balancer_type   = var.load_balancer_type
  security_groups      = [aws_security_group.lb-sg.id]
  subnets              = var.public_subnets
}

resource "aws_lb_target_group" "target-group" {
 name             =  "${var.app}-target-group"
 vpc_id           =  var.vpc
 port             =  var.target_port
 protocol         =  var.protocol

health_check {
    protocol              = var.protocol
    path                  = var.health_check_path
    port                  = var.health_check_port
    healthy_threshold     = var.health_check_healthy_threshold
    unhealthy_threshold   = var.health_check_unhealthy_threshold
    timeout               = var.health_check_timeout
    interval              = var.health_check_interval
    matcher               = var.health_check_matcher
 }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn   =  aws_lb.load-balancer.arn
  port                =  var.lb_listner_port
  protocol            =  var.protocol

  default_action {
    type             =   "forward"
    target_group_arn =   aws_lb_target_group.target-group.arn
  }
}


#Load Balancer security group
resource "aws_security_group" "lb-sg" {
  name        = "load balancer security group"
  vpc_id      = var.vpc
  description = "Allow HTTP Traffic"

  dynamic "ingress" {
    for_each = var.app_lb_port_sg
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
    Name = "${var.app} Load Balancer Security Group"
  }
}
