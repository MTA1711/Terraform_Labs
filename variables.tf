variable "taille_ec2" {
  default = "t2.nano"
}

variable "ec2_tag" {
  type = map(any)
  default = {
    Name = "ec2_amandine"
  }
}

