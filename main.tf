locals {
  hostname = "${var.name}.${data.cloudflare_zone.name}"
}

data "cloudflare_zone" "main" {
  zone_id = var.cloudflare_zone_id
}

data "cloudflare_zone" "main" {
  zone_id = var.cloudflare_zone_id
}

resource "hcloud_server" "main" {
  name         = var.name
  image        = var.image
  server_type  = var.server_type
  location     = var.location
  ssh_keys     = [hcloud_ssh_key.main.name]
  firewall_ids = [hcloud_firewall.myfirewall.id]
}
resource "hcloud_rdns" "ipv4" {
  server_id  = hcloud_server.main.id
  ip_address = hcloud_server.main.ipv4_address
  dns_ptr    = local.hostname
}
resource "hcloud_rdns" "ipv6" {
  server_id  = hcloud_server.main.id
  ip_address = hcloud_server.main.ipv6_address
  dns_ptr    = local.hostname
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
resource "cloudflare_record" "ipv4" {
  zone_id = var.cloudflare_zone_id
  name    = var.name
  value   = hcloud_server.carbon.ipv4_address
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "ipv6" {
  zone_id = var.cloudflare_zone_id
  name    = var.name
  value   = hcloud_server.carbon.ipv6_address
  type    = "AAAA"
  ttl     = 3600
}