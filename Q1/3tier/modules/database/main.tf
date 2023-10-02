#resource "azurerm_network_interface" "devops_challenge_database_ni" {
#    name = var.devops_challenge_database_ni_name
#    resource_group_name = var.rg_name
#    location = var.location
#    ip_configuration {
#        name = var.database_ip_configuration_name
#        subnet_id = var.subnet_id
#        private_ip_address_allocation = "Dynamic"
#    }
#}
#resource "azurerm_windows_virtual_machine" "devops_challenge_database_windowsvm_name" {
#    name = var.azurerm_windows_virtual_database_machine_name
#    resource_group_name = var.rg_name
#    location = var.location
#    size = "Standard_F2"
#    admin_username = "admin"
#    admin_password = "machine"
#    network_interface_ids = [ azurerm_network_interface.devops_challenge_database_ni.id ]
#    os_disk {
#        caching              = "ReadWrite"
#        storage_account_type = "Standard_LRS"
#    }

#    source_image_reference {
#        publisher = "MicrosoftWindowsServer"
#        offer     = "WindowsServer"
#        sku       = "2016-Datacenter"
#        version   = "latest"
#    }
#}
resource "azurerm_mssql_server" "data_server" {
    name = var.name
    resource_group_name = var.rg_name
    location = var.location
    version = var.version
    administrator_login = "admin"
    administrator_login_password = "machine"
    minimum_tls_version = "1.2"
    tags = {
        environment = "development"
    }
}
resource "azurerm_mssql_database" "db" {
    name = var.db_name
    server_id = azurerm_mssql_server.data_server.id
}