## This Terraform configuration creates the following resources in AWS:

1. A Virtual Private Cloud (VPC)
2. An Application Load Balancer (ALB) with an ECS Cluster and two ECS Services
3. An Amazon RDS instance for database storage
4. An Amazon Elastic Container Registry (ECR) for storing Docker images
5. An AWS Certificate Manager (ACM) certificate for the ALB
6. An AWS Lambda function to interact with the RDS database


## Prerequisites

Before using this Terraform configuration, ensure you have the following:

1. An AWS account with sufficient permissions to create the required resources
2. Terraform 0.14 or later installed on your local machine
3. Terraform Cloud account with your access and secret key

## Deployment Steps

1. Clone this repository to your local machine
2. Set up your Terraform Cloud account and organization
3. Create a new workspace in Terraform Cloud
4. Connect the workspace to this repository by linking it to your GitHub account
5. Set the following environment variables in Terraform Cloud workspace:

AWS_ACCESS_KEY_ID=<your_access_key>
AWS_SECRET_ACCESS_KEY=<your_secret_key>

You can obtain your AWS access keys by creating a new IAM user in your AWS account and assigning it the necessary permissions.

6. Queue a new Terraform plan in your Terraform Cloud workspace.
7. Review the plan and confirm the deployment.
8. Once the deployment is completed, verify that all the resources have been provisioned correctly by checking the AWS console.

## Commands to push Terrafrom code to Github:

git add *

git commit -m “message”

git push




