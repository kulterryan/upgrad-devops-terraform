# Security Group for Bastion Instances
module "sgbastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"

  name = "sgbastion"
  description = "Allow self ip to ssh to bastion instance and allow all egress."
  vpc_id = module.vpc.vpc_id
  # Ingress Rules with Self IP
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}