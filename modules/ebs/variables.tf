variable "zone" {
  type = string
}

variable "size" {
  type    = number
  default = 2
}

variable "ebs_tag" {
  type = map
}
