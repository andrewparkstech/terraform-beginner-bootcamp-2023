terraform {
#   cloud {
#     organization = "diggyblock"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "random" {
  # Configuration options
}