resource "random_password" "this" {
  length  = 16
  special = false
}

resource "azurerm_mysql_flexible_server" "this" {
  provider               = azurerm
  name                   = var.name
  resource_group_name    = var.rg.name
  location               = var.rg.location
  administrator_login    = var.admin_username
  administrator_password = random_password.this.result
  backup_retention_days  = var.backup_retention_days
  sku_name               = var.sku_name
  version                = var.mysql_version
  zone                   = var.zone
  storage {
    auto_grow_enabled = var.auto_grow_enable
    iops              = var.storage_iops
    size_gb           = var.storage_size_gb
  }
  delegated_subnet_id = var.subnet_id
  private_dns_zone_id = try(var.private_dns_zone.id, null)
  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["product"],
      tags["subscription_type"]
    ]
  }
}

data "azurerm_private_dns_a_record" "this" {
  provider            = azurerm
  count               = var.private_dns_zone == null ? 0 : 1
  name                = azurerm_mysql_flexible_server.this.name
  zone_name           = var.private_dns_zone.name
  resource_group_name = var.rg.name
}