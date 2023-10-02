# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
  }
}

provider "azurerm" {
  features {}
}
# Resource Group
resource "azurerm_resource_group" "devops_challenge_rg" {
    name = var.rg_name
    location = var.location
    lifecycle {
        prevent_destroy = true
    }
}
# Storage account
resource "azurerm_storage_account" "devops_challenge_storage" {
    name = var.devops_challenge_storage_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    location = var.location
    account_tier = var.account_tier
    account_replication_type = var.account_replication_type 
}
#VNet
resource "azurerm_virtual_network" "devops_challenge_vnet" {
    name = var.devops_challenge_vnet_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    location = var.location
    address_space = var.address_space
}
#Subnet - Frontend
resource "azurerm_subnet" "devops_challenge_frontend_subnet" {
    name = var.devops_challenge_frontend_subnet_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    virtual_network_name = azurerm_virtual_network.devops_challenge_vnet.id
    address_prefixes = var.frontend_address_prefixes
}
#Subnet - Applciation
resource "azurerm_subnet" "devops_challenge_application_subnet" {
    name = var.devops_challenge_application_subnet_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    virtual_network_name = azurerm_virtual_network.devops_challenge_vnet.id
    address_prefixes = var.application_address_prefixes
}
#Subnet - Database
resource "azurerm_subnet" "devops_challenge_database_subnet" {
    name = var.devops_challenge_database_subnet_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    virtual_network_name = azurerm_virtual_network.devops_challenge_vnet.id
    address_prefixes = var.database_address_prefixes
}
#PIP Frontend
resource "azurerm_public_ip" "devops_challenge_frontend_pip" {
    name = var.devops_challenge_frontend_pip_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    location = var.location
    allocation_method = "Dynamic"
}
#PIP Application
resource "azurerm_public_ip" "devops_challenge_application_pip" {
    name = var.devops_challenge_application_pip_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    location = var.location
    allocation_method = "Dynamic"
}
#Network Security Group Frontend
resource "azurerm_network_security_group" "devops_challenge_frontend_nsg" {
    name = var.devops_challenge_frontend_nsg_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    location = var.location
    security_rule {
        name = var.security_rule_name_80
        direction = "Inbound"
        protocol = "Tcp"
        access = "allow"
        prority = "100"
        destination_port_range = "80"
    }
    security_rule {
        name = var.security_rule_name_22
        direction = "Inbound"
        protocol = "Tcp"
        access = "allow"
        prority = "100"
        destination_port_range = "22"
    }
}
resource "azurerm_subnet_network_security_group_association" "frontend_nsg" {
  subnet_id = azurerm_subnet.devops_challenge_frontend_subnet.id
  network_security_group_id = azurerm_network_security_group.devops_challenge_frontend_nsg.id
}
#Network Security Group Application
resource "azurerm_network_security_group" "devops_challenge_application_nsg" {
    name = var.devops_challenge_application_nsg_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    location = var.location
    security_rule {
        name = var.security_rule_name_80
        direction = "Inbound"
        protocol = "Tcp"
        access = "allow"
        prority = "100"
        destination_port_range = "80"
    }
    security_rule {
        name = var.security_rule_name_22
        direction = "Inbound"
        protocol = "Tcp"
        access = "allow"
        prority = "100"
        destination_port_range = "22"
    }
}
resource "azurerm_subnet_network_security_group_association" "application_nsg" {
  subnet_id = azurerm_subnet.devops_challenge_application_subnet.id
  network_security_group_id = azurerm_network_security_group.devops_challenge_application_nsg.id
}
#Network Security Group Database
resource "azurerm_network_security_group" "devops_challenge_database_nsg" {
    name = var.devops_challenge_database_nsg_name
    resource_group_name = azurerm_resource_group.devops_challenge_rg.name
    location = var.location
    security_rule {
        name = var.security_rule_name_1433
        direction = "Inbound"
        protocol = "Tcp"
        access = "allow"
        prority = "100"
        destination_port_range = "1433"
    }
}
resource "azurerm_subnet_network_security_group_association" "database_nsg" {
  subnet_id = azurerm_subnet.devops_challenge_database_subnet.id
  network_security_group_id = azurerm_network_security_group.devops_challenge_database_nsg.id
}

module "database_server" {
    source = "../modules/vm/database"
    rg_name = azurerm_resource_group.devops_challenge_rg.name
    location = "Central India"
    subnet_id = azurerm_subnet.devops_challenge_database_subnet.id
}

module "frontend_server" {
    source = "../modules/vm/frontend"
    rg_name = azurerm_resource_group.devops_challenge_rg.name
    location = "Central India"
    subnet_id = azurerm_subnet.devops_challenge_frontend_subnet.id
    public_ip = azurerm_public_ip.devops_challenge_frontend_pip.id
}

module "application_server" {
    source = "../modules/vm/application"
    rg_name = azurerm_resource_group.devops_challenge_rg.name
    location = "Central India"
    subnet_id = azurerm_subnet.devops_challenge_application_subnet.id
    public_ip = azurerm_public_ip.devops_challenge_application_pip.id
    depends_on = [ module.database_server, module.frontend_server ]

}