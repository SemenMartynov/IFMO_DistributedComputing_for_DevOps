# ===============
# VPC Resources
# ===============

resource "yandex_vpc_network" "infra_network" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "infra_subnet" {
  count          = length(var.net_cidr)
  name           = var.net_cidr[count.index].name
  zone           = var.net_cidr[count.index].zone
  v4_cidr_blocks = [var.net_cidr[count.index].prefix]
  network_id     = yandex_vpc_network.infra_network.id
}

resource "yandex_vpc_security_group" "infra_db_sg" {
  name       = var.sg_db_name
  network_id = yandex_vpc_network.infra_network.id

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = "22"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = 5432
    # v4_cidr_blocks = ["${data.yandex_compute_instance.vm_app_1_ip.network_interface.0.nat_ip_address}/32"]
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "infra_app_sg" {
  name       = var.sg_app_name
  network_id = yandex_vpc_network.infra_network.id

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = "22"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = "80"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}