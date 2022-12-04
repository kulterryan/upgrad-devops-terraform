# EC2 Instance Variables

# Instance Type
variable "instance_type" {
  type = string
  default = "t2.micro"  
}

# Instance Key Pair
variable "instance_keypair" {
  type = string
  default = "Upgrad_NEW"
}

# AWS EC2 Private Instance Count
variable "private_instance_count" {
  description = "Private Instances Count"
  type = number
  default = 1  
}