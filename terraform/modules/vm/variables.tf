variable "resource_group_name" {
  type     = string
  nullable = false
}

variable "location" {
  type     = string
  nullable = false
}

variable "vm_size" {
  type     = string
  nullable = false
}

variable "ssh_user" {
  type     = string
  nullable = false
}

variable "client_ip" {
  type     = string
  nullable = false
}

variable "key_data" {
  type     = string
  nullable = false
}

variable "public_ip_name" {
  type     = string
  nullable = false
}

variable "network_interface_name" {
  type     = string
  nullable = false
}

variable "network_security_group_name" {
  type     = string
  nullable = false
}

variable "vm_name" {
  type     = string
  nullable = false
}

variable "storage_name" {
  type     = string
  nullable = false
}

variable "subnet_id" {
  type     = string
  nullable = false
}
