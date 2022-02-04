# Configure the Hetzner Cloud Provider
provider "hcloud" { 
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
  public_key = file("~/.ssh/id_rsa.pub")
}
