module "network" {
  source   = "./modules/01_network"
  vpc_cidr = "10.0.0.0/16"
}

module "ec2" {
  source      = "./modules/02_ec2"
  vpc_id      = module.network.vpc_id
  pub_subnets = module.network.pub_subnet_1a_id
}

module "rds" {
  source         = "./modules/03_rds"
  vpc_id         = module.network.vpc_id
  pri_subnets_1a = module.network.pri_subnet_1a_id
  pri_subnets_1c = module.network.pri_subnet_1c_id
  db_password    = "password"
}

module "alb" {
  source         = "./modules/04_alb"
  vpc_id         = module.network.vpc_id
  pub_subnets_1a = module.network.pub_subnet_1a_id
  pub_subnets_1c = module.network.pub_subnet_1c_id
  ec2_1a         = module.ec2.ec2_1a_id
  sg_ec2         = module.ec2.sg_ec2_id
}

module "s3" {
  source      = "./modules/05_s3"
}
