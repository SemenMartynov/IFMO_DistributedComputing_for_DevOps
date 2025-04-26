variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "infra-network"
}

variable "net_cidr" {
  description = "Subnet structure"
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

variable "vm_1_name" {
  type    = string
  default = "vm-kittygram"
}

variable "ssh_key" {
  description = "SSH Public Key"
  type        = string
}

variable "cloud_id" {
  description = "Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2
}

variable "disk_size" {
  type    = number
  default = 10
}

variable "core_fraction" {
  type    = number
  default = 20
}

variable "image_family" {
  description = "Image family name to use for the VM"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "platform_id" {
  type    = string
  default = "standard-v1"
}

variable "disk_type" {
  type    = string
  default = "network-hdd"
}

variable "nat" {
  type    = bool
  default = true
}
