output "loadbalancerdns" {
  value = aws_lb.ApplicationLB.dns_name
}