terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
#   cloud {
#     organization = "diggyblock"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
}

provider "terratowns" {
  # endpoint = "http://localhost:4567/api"
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.teacherseat_user_uuid
    # bucket_name = var.bucket_name
    index_html_filepath = var.index_html_filepath
    error_html_filepath = var.error_html_filepath
    content_version = var.content_version
    assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Lego Island PC Game"
  description = <<DESCRIPTION
Lego Island is a game where you can explore different areas of the island and complete tasks, all in a Lego world!
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  # town = "gamers-grotto"
  town = "missingo"
  content_version = 1
}