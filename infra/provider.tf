# ==================================
# Terraform & Provider Configuration
# ==================================

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "local" {
    path = "secrets/terraform.tfstate"
  }
}

provider "yandex" {
  service_account_key_file = "./secrets/key.json"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

data "yandex_compute_image" "image" {
  family = var.image_family
}