resource "aws_ecs_cluster" "cluster" {
  name = "${var.name}-${var.environment}-ecs-cluster"
}

#cloudwatch log group

resource "aws_cloudwatch_log_group" "log-group" {
  name              = "${var.name}-${var.environment}-logs"
  retention_in_days = var.retention_in_days

}

##service ##
resource "aws_ecs_task_definition" "task-def" {
  family                   = "${var.name}-${var.environment}-task-def"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.ecs_task_def.task_cpu_limit}"
  memory                   = "${var.ecs_task_def.task_memory_limit}"
  execution_role_arn       = "${aws_iam_role.ecs_task_execution_role.arn}"
  task_role_arn            = "${aws_iam_role.ecs_task_role.arn}"
   container_definitions    = <<TASK_DEFINITION
  [
   {
    "name": "${var.name}-${var.environment}-container",
    "image": "${var.ecr_repo_url}:latest",
    "cpu": ${tonumber(var.ecs_task_def.container_cpu)},
    "memory": ${tonumber(var.ecs_task_def.container_memory)},
    "networkMode": "awsvpc",
    "essential": true,
    "logConfiguration": {
            "logDriver": "awslogs",
            "secretOptions": null,
            "options": {
                "awslogs-group": "${var.name}-${var.environment}-logs",
                "awslogs-region": "${var.region}",
                "awslogs-stream-prefix": "ecs"
            }
        }
      },
    "portMappings": [
      {
        "containerPort": ${tonumber(var.ecs_task_def.container_port)},
        "hostPort": ${tonumber(var.ecs_task_def.container_port)}
      }
    ]
  ]
TASK_DEFINITION

}


##security group##

resource "aws_security_group" "ecs-sg" {
  name        = "${var.name}-${var.environment}-ecs-sg"
  vpc_id      = var.vpc_id

  ingress {
      from_port   = "0"
      to_port     = "0"
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
}

####

resource "aws_ecs_service" "service" {
  name            = "${var.name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task-def.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs-sg.id]
    subnets         = var.public_subnets
  }

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = "${var.name}-${var.environment}-container"
    container_port   = "${var.ecs_task_def.container_port}"
  }

}