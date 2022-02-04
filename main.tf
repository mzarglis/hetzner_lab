resource "hcloud_server" "carbon" {
  name         = var.name
  image        = var.image
  server_type  = var.server_type
  location     = var.location
  ssh_keys     = [hcloud_ssh_key.main.name]
  firewall_ids = [hcloud_firewall.myfirewall.id]
}
resource "hcloud_rdns" "carbon" {
  server_id  = hcloud_server.carbon.id
  ip_address = hcloud_server.carbon.ipv4_address
  dns_ptr    = var.name
}
resource "hcloud_ssh_key" "main" {
  name       = "terraform"
  public_key = var.id_rsa_pub
}

resource "hcloud_firewall" "main" {
  name = "main"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}