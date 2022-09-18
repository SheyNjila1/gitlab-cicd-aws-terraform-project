# configure aws provider
provider "aws" {
  region  = var.region
  profile = "default"
}

# Create vpc
module "vpc" {
  #source                       = "../modules/vpc"
  source                       = "./vpc"
  region                       = var.region
  vpc_cidr                     = var.vpc_cidr
  project_name                 = var.project_name
  public_web_subnet_az1_cidr   = var.public_web_subnet_az1_cidr
  public_web_subnet_az2_cidr   = var.public_web_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr

}

# Create Nat Gateways
module "nat_gateway" {
  #source                     = "../modules/nat-gateway"
  source                     = "./nat-gateway"
  public_web_subnet_az1_id   = module.vpc.public_web_subnet_az1_id
  internet_gateway           = module.vpc.internet_gateway
  public_web_subnet_az2_id   = module.vpc.public_web_subnet_az2_id
  vpc_id                     = module.vpc.vpc_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
}

# # Create Security Groups
# module "security-groups" {
#   # source = "../modules/security-groups"
#   source = "./security-groups"
#   vpc_id = vpc.vpc_id

# }

# Create Autoscaling
#module "autoscaling" {
  # source = "../modules/autoscaling"
  #source = "./autoscaling"
  # source = 
  #vpc_id = vpc.vpc_id

#}

