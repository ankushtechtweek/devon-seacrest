locals {

name_database   = format("%s-%s-%s", var.name, var.environment, "rds")
}


resource "aws_db_subnet_group" "subnet_group" {
  name        = "${local.name_database}-subnet-gp"
  description = "Subnet group for ${local.name_database}"
  subnet_ids  = var.database-subnets
         
  tags = {
   Name = "${local.name_database}-subnet-group"
}
}

resource "aws_db_instance" "database" {
  identifier                            = "${local.name_database}-server"
  engine                                = var.rds.engine
  engine_version                        = var.rds.engine_version
  instance_class                        = var.rds.instance_class
  allocated_storage                     = var.rds.allocated_storage
  max_allocated_storage                 = var.rds.max_allocated_storage
  storage_encrypted                     = var.rds.storage_encrypted
  username                              = var.rds.username
  port                                  = var.rds.port
  password                              = var.rds.password
  multi_az                              = var.rds.multi_az
  vpc_security_group_ids                = [aws_security_group.database-sg.id]
  db_subnet_group_name                  = aws_db_subnet_group.subnet_group.name
  maintenance_window                    = var.rds.maintenance_window
  backup_window                         = var.rds.backup_window
  enabled_cloudwatch_logs_exports       = var.rds.enabled_cloudwatch_logs_exports
  backup_retention_period               = var.rds.backup_retention_period
  skip_final_snapshot                   = var.rds.skip_final_snapshot
  deletion_protection                   = var.rds.deletion_protection 
  performance_insights_enabled          = var.rds.performance_insights_enabled 
  performance_insights_retention_period = var.rds.performance_insights_retention_period 
  monitoring_interval                   = var.rds.monitoring_interval 

     
  tags = {
   Name = "${local.name_database}"
}
}

resource "aws_security_group" "database-sg" {

  name        = "${local.name_database}-sg"
  description = "RDS security group"
  vpc_id      =  var.vpc_id

  # ingress
  ingress {
      from_port   = "5432"
      to_port     = "5432"
      protocol    = "tcp"
      description = "vpc cidr block"
      cidr_blocks = [var.vpc.vpc_cidr]
    }
    
    egress {

    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
     
  tags = {
   Name = "${local.name_database}-sg"
}
}

