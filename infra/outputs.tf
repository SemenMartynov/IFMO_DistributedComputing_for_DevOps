output "vm_ips" {
  description = "Внутренние и внешние ip адреса виртуальных машин"
  value = {
    vm_app_1 = {
      name        = yandex_compute_instance.vm_app_1.name
      internal_ip = yandex_compute_instance.vm_app_1.network_interface.0.ip_address
      external_ip = yandex_compute_instance.vm_app_1.network_interface.0.nat_ip_address
    }
    vm_db_1 = {
      name        = yandex_compute_instance.vm_db_1.name
      internal_ip = yandex_compute_instance.vm_db_1.network_interface.0.ip_address
      external_ip = yandex_compute_instance.vm_db_1.network_interface.0.nat_ip_address
    }
    vm_db_2 = {
      name        = yandex_compute_instance.vm_db_2.name
      internal_ip = yandex_compute_instance.vm_db_2.network_interface.0.ip_address
      external_ip = yandex_compute_instance.vm_db_2.network_interface.0.nat_ip_address
    }
  }
}

resource "local_file" "vm_ips" {
  filename = "secrets/vm_ips.json"
  content  = jsonencode({
    vm_app_1 = {
      name        = yandex_compute_instance.vm_app_1.name
      internal_ip = yandex_compute_instance.vm_app_1.network_interface.0.ip_address
      external_ip = yandex_compute_instance.vm_app_1.network_interface.0.nat_ip_address
    }
    vm_db_1 = {
      name        = yandex_compute_instance.vm_db_1.name
      internal_ip = yandex_compute_instance.vm_db_1.network_interface.0.ip_address
      external_ip = yandex_compute_instance.vm_db_1.network_interface.0.nat_ip_address
    }
    vm_db_2 = {
      name        = yandex_compute_instance.vm_db_2.name
      internal_ip = yandex_compute_instance.vm_db_2.network_interface.0.ip_address
      external_ip = yandex_compute_instance.vm_db_2.network_interface.0.nat_ip_address
    }
  })
}