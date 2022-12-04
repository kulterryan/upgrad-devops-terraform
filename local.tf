# Local Declarations
locals {
  owners = var.owner
  environment = var.environment
  name = var.vpc_name
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 
