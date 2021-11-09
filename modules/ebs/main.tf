resource "aws_ebs_volume" "example" {
  availability_zone = var.zone
  size              = var.size

  tags = var.ebs_tag
}
