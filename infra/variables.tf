# =========
# Variables
# =========

# =========================================================== #
# ========================= general ========================= #
# =========================================================== #
variable "folder_id" {
  description = "ID каталога в Yandex Cloud"
  type        = string
}

variable "cloud_id" {
  description = "ID облака в Yandex Cloud"
  type        = string
}

# ======================================================== #
# ========================= vm`s ========================= #
# ======================================================== #
variable "image_family" {
  description = "семейство дистрибутива образа Ubuntu 24.04 LTS"
  type        = string
}

variable "platform_id" {
  description = "ID платформы процессора в Yandex Cloud"
  type        = string
}

variable "cores" {
  description = "Количество ядер"
  type        = number
}

variable "memory" {
  description = "ID образа Ubuntu 24.04 LTS"
  type        = number
}

variable "core_fraction" {
  description = "Процент выделяемого ресурса на ВМ"
  type        = number
}

variable "disk_type" {
  description = "ID образа Ubuntu 24.04 LTS"
  type        = string
}

variable "disk_size" {
  description = "ID образа Ubuntu 24.04 LTS"
  type        = number
}

variable "ssh_public_key" {
  description = "Публичный ключ ssh"
  type        = string
}

variable "zone" {
  description = "Зона для бд_1 в Yandex Cloud"
  type        = string
}

# ========================= vm: db_1 ========================= #
variable "vm_db_1_name" {
  description = "Название виртуальной машины с бд_1 в Yandex Cloud"
  type        = string
}

# ========================= vm: db_2 ========================= #
variable "vm_db_2_name" {
  description = "Название виртуальной машины с бд_2 в Yandex Cloud"
  type        = string
}

# ========================= vm: app_1 ========================= #
variable "vm_app_1_name" {
  description = "Название виртуальной машины с бд_2 в Yandex Cloud"
  type        = string
}

# ======================================================= #
# ========================= vps ========================= #
# ======================================================= #
variable "vpc_name" {
  description = "Название виртуальной сети"
  type        = string
}

variable "sg_db_name" {
  description = "Название группы безопасности для баз данных"
  type        = string
}

variable "sg_app_name" {
  description = "Название группы безопасности для приложений"
  type        = string
}


variable "net_cidr" {
  description = "Структура подсети"
  type = list(object({
    name   = string,
    zone   = string,
    prefix = string
  }))

  default = [
    { name = "infra-subnet-a", zone = "ru-central1-a", prefix = "10.129.1.0/24" },
    { name = "infra-subnet-b", zone = "ru-central1-b", prefix = "10.130.1.0/24" },
    { name = "infra-subnet-d", zone = "ru-central1-d", prefix = "10.131.1.0/24" },
  ]
}