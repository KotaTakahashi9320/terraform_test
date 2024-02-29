output "server_url" {
    value = "http://${module.vm.public_ip.ip_address}:80/hello"
}
