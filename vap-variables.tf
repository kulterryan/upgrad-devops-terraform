# VPC Name
variable "vpc_name" {
  description = "VPC Name"
  type = string 
  default = "upgrad-assignment"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "CIDR subnet for VPC"
  type = string 
  default = "10.0.0.0/16"
}

# VPC Availability Zones
variable "vpc_availability_zones" {
  description = "Availability Zones for VPC"
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}


# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "Seting up Public Subnets"
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "Seting up VPC Private Subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}


# VPC Enable NAT Gateway (True or False)
variable "vpc_enable_nat_gateway" {
  description = "Enabling NAT GW for private subnets"
  type = bool
  default = true
}

# VPC Single NAT Gateway (True or False)
variable "vpc_single_nat_gateway" {
  description = "Enabling nat gateway in single zone only"
  type = bool
  default = true
}