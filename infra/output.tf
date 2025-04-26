output "external_ip" {
  description = "External IP"
  value       = yandex_compute_instance.vm_1.network_interface[0].nat_ip_address
}

output "vm_name" {
  description = "VM name"
  value       = yandex_compute_instance.vm_1.name
}
