# terraform {

#   required_version = ">= 1.5"

#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~>3.71.0"
#     }
#   }
# }
provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}
# mock_provider "azurerm" {}

run "test" {
  command = plan
  variables {
    resource_group_name         = "Sandbox-RD"
    location                    = "japanwest"
    vnet_name                   = "vnet-test"
    subnet_name                 = "subnet-test"
  }
  module {
    source = "../network"
  }
}

run "vm" {
  command = plan
  variables {
    resource_group_name = "Sandbox-RD"
    location            = "japanwest"
    vm_size             = "Standard_DC16ds_v3"
    ssh_user            = "ubuntu"
    key_data            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjBnwsOtmhhIV32nuBRdOy8DhOyBdhA4U481l9krgMTjSov+KCI7scSb3EzuwJn+O2xcU6wiJvYpV6Alq6PnLJkIdLjlFx9GqpQOWRLO4rqGYObZN57xVVkwJWPVz3/XtvTT37A0APoiXIbooh9s6nXqJhQiPbck4hRGoW8j8m/Z2y7107RE9ZHWUEfPJzagYbXPakf2B/p6xT0SEYJXy2qmjOY3O68A5VbJAI67/IGsHtMKP9wmiHpzSfJMrIdNACEmpBlMjU9n42r1Kmwh1KMcBXk+9EHU7HpUybcHUTvELQuuqKEbnktwgNixDKchpjOu2HNk6IlHFt+iAkK5MYixPMSTKL3TkX2NcI4++7NbUQ1/1zEET2hWjU6e71DTmdGypXaSdI5LjtqOtpHnT+hkNHs/8IHd0QLTURxN0MwbtEj/18pZHp00Wy4xLcwJMUgoOYpgWHjJ3j4ZQHU2flxoiB5AtdOi+xVrVtBv5wlRYGbEON3VOFEbxpa90YVrau9Whsi8cqj77K2zr+zWtv6hpcKSP9bjk0LtjwOB5GcrWH672u1j2GjxwSwkTCuWW6FyeY2CmjYS9K2toiW38pyNS6T2O+BqNp0DIdg6dvyzCUwwEb6FORR7FcXx0phtE0WgiOgWDJYbDJAhkGxKsifr2zlVMMi+IaM2Q6WH+Pfw=="
    vm_name             = "hoge"
    storage_name        = "hoge"
    network_interface_id = "hoge"
  }

  assert {
    condition     = length([for rule in azurerm_network_security_group.nsg.security_rule : true if contains(rule.source_address_prefixes, var.client_ip)]) == 2
    error_message = "ip is not"
  }
}
