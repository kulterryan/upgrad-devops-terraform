# Security Group for Public Instances
module "sgpublic" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"

  name = "sgpublic"
  description = "Allow incoming to port 80 from self IP and all egress."
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}