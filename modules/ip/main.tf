resource "aws_eip" "lb" {
  vpc  = true
  tags = var.lb_tag
}
