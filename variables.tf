# Default AWS Region
variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"  
}

# Environment Variable
variable "environment" {
  description = "Environment Variable"
  type = string
  default = "dev-terraform"
}


# Owner Variable
variable "owner" {
  type = string
  default = "Aryan Chaurasia"
}
