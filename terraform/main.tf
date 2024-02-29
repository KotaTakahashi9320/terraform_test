resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "http" "ifconfig" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  client_ip = chomp(data.http.ifconfig.response_body)
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = "vnet-${var.post_fix}"
  subnet_name         = "snet-${var.post_fix}"
}

module "vm" {
  source                      = "./modules/vm"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  vm_size                     = var.vm_size
  ssh_user                    = var.ssh_user
  client_ip                   = local.client_ip
  key_data                    = tls_private_key.keygen.public_key_openssh
  public_ip_name              = "ip-${var.post_fix}"
  network_interface_name      = "nic-${var.post_fix}"
  network_security_group_name = "nsg-${var.post_fix}"
  vm_name                     = "vm-${var.post_fix}"
  storage_name                = "osdisk-${var.post_fix}"
  subnet_id                   = module.network.subnet.id
}

resource "terraform_data" "deploy" {
  provisioner "remote-exec" {
    connection {
      host        = module.vm.public_ip.ip_address
      type        = "ssh"
      user        = var.ssh_user
      private_key = tls_private_key.keygen.private_key_pem
    }

    inline = [
      "mkdir test && cd test && echo \"Hello, World!\" > hello",
      "nohup sudo python3 -m http.server 80 &",
      "sleep 5",
    ]
  }
  depends_on = [module.vm]
}
