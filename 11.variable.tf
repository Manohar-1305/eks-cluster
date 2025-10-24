variable "cluster_service_ipv4_cidr" {
  description = "CIDR Block for kubernetes services"
  default     = "172.20.0.0/16"

}
variable "ami_type" {
  description = "The image to be used"
  type        = string
  default     = "ami-03bb6d83c60fc5f7c"
}
variable "instance_type" {
  description = "Instance Type Used"
  type        = string
  default     = "t2.medium"

}

variable "region" {
  description = "The regions used"
  type        = string
  default     = "ap-south-1"

}
