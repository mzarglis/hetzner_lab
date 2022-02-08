terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~>1.32"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}
provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}