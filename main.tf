terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = ""
    key = ""
    region = ""
    encrypt = true
    dynamodb_table = ""
  }
}

provider "aws" {
  region = ""
  access_key = ""
  secret_key = ""
}


module "s3_upload" {
  source = "./modules"
  # s3 connection
  AWS_BUCKET = ""
  AWS_ACCESS_KEY_ID = ""
  AWS_SECRET_ACCESS_KEY = ""
  REGION_NAME = ""

  # connection to the ec2 instance
  connection_private_key = ""
 }