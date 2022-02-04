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
  location    = "ash"
  ssh_keys    = [hcloud_ssh_key.default.name]
} 
resource "hcloud_ssh_key" "default" {
  name       = "terraform"
  public_key =  var.id_rsa_pub
}

variable id_rsa_pub { default = ""}

output ipv4 {
    value = hcloud_server.main.ipv4_address
}

output ipv6 {
    value = hcloud_server.main.ipv6_address
}