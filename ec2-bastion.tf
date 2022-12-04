# EC2 bastion Instance in VPC Public Subnet
module "ec2_bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.1"

  # Variables
  name = "bastion"
  ami = "ami-0a6b2839d44d781b2"
  instance_type = var.instance_type
  key_name = var.instance_keypair
  subnet_id  = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.sgpublic.security_group_id]
  tags = local.common_tags
}