output "data_server" {
  value = azurerm_mssql_server.data_server.name
}
output "db_name" {
  value = azurerm_mssql_database.db_name.name
}