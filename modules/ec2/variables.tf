variable "key_path" {
  type        = string
  description = "path to private key for ssh connection"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "ec2_tag" {
  type = map
}
