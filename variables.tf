variable "name" {}

variable "rg" {}

variable "auto_grow_enable" {
  type    = bool
  default = true
}

variable "storage_size_gb" {
  type    = number
  default = 32
}

variable "storage_iops" {
  default = 396
}

variable "backup_retention_days" {
  type    = number
  default = 30
}

variable "admin_username" {
  type    = string
  default = "mysql_admin"
}

variable "mysql_version" {
  default = "8.0.21"
}

variable "sku_name" {
  default = "B_Standard_B1ms"
}

variable "subnet_id" {
  default = null
}

variable "private_dns_zone" {
  default = null
  type = object({
    id   = string
    name = string
  })
}

variable "zone" {
  default = null
}