terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.47.0"
    }
  }

  backend "s3" {
    bucket = "sravan-regularpython"
    key    = "my_lambda/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "sravan-regularpython-123"

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_role" "ts_lambda_role" {
  name = "ts_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# resource "aws_lambda_function" "ts_lambda" {
#   filename         = "src/lambda_function_${var.lambdasVersion}.zip"
#   function_name    = "ts_lambda"
#   role             = aws_iam_role.ts_lambda_role.arn
#   handler          = "index.handler"
#   runtime          = "nodejs18.x"
#   memory_size      = 1024
#   timeout          = 300
# }


