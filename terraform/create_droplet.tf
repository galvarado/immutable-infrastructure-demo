variable "do_token" {}
variable "droplet_ssh_key_id" {}
variable "droplet_name" {}
variable "droplet_size" {}
variable "droplet_region" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}


# Get snapshot name
data "digitalocean_droplet_snapshot" "ubuntu2004-packer-image" {
  name_regex  = "^ubuntu2004-packer"
  region      = "nyc1"
  most_recent = true
}

# Create a web server
resource "digitalocean_droplet" "server-by-terrraform" {
  image      = "${data.digitalocean_droplet_snapshot.ubuntu2004-packer-image.id}"
  name       = var.droplet_name
  region     = var.droplet_region
  size       = var.droplet_size
  monitoring = "true"
  ssh_keys   = [var.droplet_ssh_key_id]
}

