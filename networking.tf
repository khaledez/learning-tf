data "aws_availability_zones" "available" {}

module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  version                      = "5.15.0"
  name                         = "main-vpc"
  cidr                         = "10.0.0.0/16"
  azs                          = data.aws_availability_zones.available.names
  private_subnets              = ["10.0.1.0/24"]
  public_subnets               = ["10.0.101.0/24"]
  create_database_subnet_group = true
  enable_nat_gateway           = true
  single_nat_gateway           = true
}

module "public_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"
  vpc_id  = module.vpc.vpc_id
  name    = "public_sg"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_rules = ["all-all"]
}
