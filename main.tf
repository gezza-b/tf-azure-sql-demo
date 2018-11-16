

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.rg_tags}"
}

resource "azurerm_sql_database" "db" {
  name                             = "${var.db_name}"
  resource_group_name              = "${azurerm_resource_group.rg.name}"
  location                         = "${var.location}"
  edition                          = "${var.db_edition}"
  collation                        = "${var.collation}"
  server_name                      = "${azurerm_sql_server.server.name}"
  create_mode                      = "Default"
  requested_service_objective_name = "${var.service_objective_name}"
  tags                             = "${var.db_tags}"
}

resource "azurerm_sql_server" "server" {
  name                         = "${var.db_name}-sqlsvr"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  location                     = "${var.location}"
  version                      = "${var.server_version}"
  administrator_login          = "${var.sql_admin_username}"
  administrator_login_password = "${var.dbadmin_password}"
  tags                         = "${var.db_tags}"
}

resource "azurerm_sql_firewall_rule" "fw" {
  name                = "${var.db_name}-fwrules"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_sql_server.server.name}"
  start_ip_address    = "${var.start_ip_address}"
  end_ip_address      = "${var.end_ip_address}"
}