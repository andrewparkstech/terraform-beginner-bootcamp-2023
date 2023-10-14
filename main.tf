terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "diggyblock"

    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  # endpoint = "http://localhost:4567/api"
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_game_hosting" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    public_path = var.game.public_path
    content_version = var.game.content_version
}

resource "terratowns_home" "home_game" {
  name = "Lego Island PC Game"
  description = <<DESCRIPTION
Lego Island is a game where you can explore different areas of the island and complete tasks, all in a Lego world!
DESCRIPTION
  domain_name = module.home_game_hosting.domain_name
  # town = "gamers-grotto"
  town = "missingo"
  content_version = var.game.content_version
}

module "home_music_hosting" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    public_path = var.music.public_path
    content_version = var.music.content_version
}

resource "terratowns_home" "home_music" {
  name = "I love Music!"
  description = <<DESCRIPTION
I love all kinds of music, but my favorite is classic rock. The first Pink Floyd song I heard
was Comfortably Numb, which I listened to while programming Visual Basic 6.
DESCRIPTION
  domain_name = module.home_music_hosting.domain_name
  # town = "melomaniac-mansion"
  town = "missingo"
  content_version = var.music.content_version
}