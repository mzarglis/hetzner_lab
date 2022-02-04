terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.32.2"
    }
  }
}

provider "hcloud" {
  # Configuration options
}

resource "hcloud_server" "main" {
  name        = "node1"
  image       = "ubuntu-20.04"
  server_type = "cpx11"
  location    = "us-east"
  ssh_keys    = hcloud_ssh_key.default.id
}
resource "hcloud_ssh_key" "default" {
  name       = "terraform"
  public_key =  var.id_rsa_pub
}

variable id_rsa_pub { default = ""}
