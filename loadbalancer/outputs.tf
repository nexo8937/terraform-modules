output "load-balancer-dns-name" {
  description = "DNS name of the load balancer"
  value = aws_lb.load-balancer.dns_name
}

output "load-balancer-target-group" {
  description = "target group of the load balancer"
  value = aws_lb_target_group.target-group.arn
}
