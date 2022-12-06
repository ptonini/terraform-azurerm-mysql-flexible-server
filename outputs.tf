locals {
  host = var.private_dns_zone == null ? azurerm_mysql_flexible_server.this.fqdn : tolist(data.azurerm_private_dns_a_record.this[0].records)[0]
  port = "3306"
}

output "this" {
  value = azurerm_mysql_flexible_server.this
}

output "credentials" {
  value = {
    port     = local.port
    host     = local.host
    endpoint = "${local.host}:${local.port}"
    username = var.admin_username
    password = random_password.this.result
  }
}

