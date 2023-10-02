#Network Interface - Frontend
resource "azurerm_network_interface" "devops_challenge_frontend_ni" {
    name = var.devops_challenge_frontend_ni_name
    resource_group_name = var.rg_name
    location = var.location
    ip_configuration {
        name = var.frontend_ip_configuration_name
        subnet_id = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = var.public_ip
    }
}
#Virtual Machine - Frontend Web Server
resource "azurerm_linux_virtual_machine" "devops_challenge_frontend_linuxvm" {
    name = var.devops_challenge_frontend_linuxvm_name
    resource_group_name = var.rg_name
    location = var.location
    size = "Standard_F2"
    admin_username = "admin"
    network_interface_ids = [
        azurerm_network_interface.devops_challenge_frontend_ni.id
    ]
    os_disk {
        storage_account_type = "Standard_LRS"
        caching = "ReadWrite"
    }
    source_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "16.04-LTS"
        version = "latest"
    }
    admin_ssh_key {
        username = "admin"
        public_key = file("~/.ssh/id_rsa.pub")
    }
}