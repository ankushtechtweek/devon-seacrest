module "vpc" {
  source        = "./../modules/vpc"
  environment   = var.environment
  name          = var.name
  vpc           = var.vpc
  region        = var.region
  account_id    = var.account_id
}

module "alb" {
  source      = "./../modules/alb"
  environment = var.environment
  name        = var.name
  alb         = var.alb
  vpc_id      = module.vpc.vpc_id
  public-subnets  = module.vpc.public-subnets
  certificate_arn = module.acm.acm_arn
}

module "rds" {
  source      = "./../modules/rds"
  environment = var.environment
  name        = var.name
  rds         = var.rds
  vpc_id      = module.vpc.vpc_id
  database-subnets = module.vpc.database-subnets
  vpc           = var.vpc
}

module "ecr" {
  source      = "./../modules/ecr"
  environment = var.environment
  name        = var.name
  ecr         = var.ecr
}

module "ecs" {
  source      = "./../modules/ecs"
  environment = var.environment
  name        = var.name
  vpc_id      = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  region         = var.region 
  ecr_repo_url   = module.ecr.ecr_repo_url
  ecs_task_def   = var.ecs_task_def
  vpc            = var.vpc
  tg_arn         = module.alb.tg_arn
}


module "acm" {
  source      = "./../modules/acm"
  acm            = var.acm
  route53_fqdn   = module.route53.route53_fqdn

}

module "route53" {
  source           = "./../modules/route53"
  acm              = var.acm
  acm_record_name  = module.acm.acm_record_name 
  acm_record_type  = module.acm.acm_record_type 
  acm_record_value = module.acm.acm_record_value
  alb_dns          = module.alb.alb_dns
}
