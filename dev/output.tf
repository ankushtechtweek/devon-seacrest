output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "app_route_table" {
  value = module.vpc.app_route_table
}

output "public_route_table" {
  value = module.vpc.public_route_table
}

output "database_route_table" {
  value = module.vpc.database_route_table
}



  
