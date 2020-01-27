#
# DO NOT DELETE THESE LINES UNTIL INSTRUCTED TO!
#
# Your AMI ID is:
#
#     ami-0b508e9b54730f606
#
# Your subnet ID is:
#
#     subnet-088d4079d6dcc7741
#
# Your VPC security group ID is:
#
#     sg-025bab05d0c0b46cf
#
# Your Identity is:
#
#     hashi-training-public-bear
#

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "keypair" {
  source  = "mitchellh/dynamic-keys/aws"
  version = "2.0.0"
  path    = "${path.root}/keys"
  name    = "${var.identity}-key"
}


module "server" {
  source = "./server"

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  identity               = var.identity
  key_name               = module.keypair.key_name
  private_key            = module.keypair.private_key_pem
}
