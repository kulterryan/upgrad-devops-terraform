# Security Group for Private Instances
module "sgprivate" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"

  name = "sgprivate"
  description = "Allow all incoming traffic from within VPC and all egress"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["all-all"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}
