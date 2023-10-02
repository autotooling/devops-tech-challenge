variable "rg_name" {
    type = string
    description = "resource group name"
    default = "DevOpsChallengeResourceGroup"
}
variable "location" {
    type = string
    description = "azure resources location"
    default = "Central India"
}
variable "devops_challenge_storage_name" {
    type = string
    description = "staorage account name"
    default = "DevOpsChallengeStorage"
}
variable "account_tier" {
    type = string
    description = "accpunt tier name"
    default = "Standard"
}
variable "account_replication_type" {
    type = string
    description = "account_replication_type"
    default = "GRS"
}
variable "devops_challenge_vnet_name" {
    type = string
    description = "vnet name"
    default = "DevOpsChallengeVirtualNetwork"
}
variable "address_space" {
    type = string
    description = "address_space"
    default = ["10.0.0.0/16"]
}
variable "devops_challenge_frontend_subnet" {
    type = string
    description = "subnet name"
    default = "DevOpsChallengeFrontendSubnet"
}
variable "devops_challenge_application_subnet" {
    type = string
    description = "subnet name"
    default = "DevOpsChallengeApplicationSubnet"
}
variable "devops_challenge_database_subnet" {
    type = string
    description = "subnet name"
    default = "DevOpsChallengeDatabaseSubnet"
}
variable "frontend_address_prefixes" {
    type = string
    description = "address_prefixes"
    default = "10.0.1.0/24"
}
variable "application_address_prefixes" {
    type = string
    description = "address_prefixes"
    default = "10.0.2.0/24"
}
variable "database_address_prefixes" {
    type = string
    description = "address_prefixes"
    default = "10.0.2.0/24"
}
variable "devops_challenge_frontend_pip_name" {
    type = string
    default = "DevOpsChallengeFrontendPip"
    description = "devops_challenge_frontend_pip name"
}
variable "devops_challenge_application_pip_name" {
    type = string
    default = "DevOpsChallengeApplicationPip"
    description = "devops_challenge_application_pip name"
}
variable "security_rule_name_80" {
    type = string
    description = "security_rule name"
    default = "SecurityRuleInbound1"
}
variable "security_rule_name_22" {
    type = string
    description = "security_rule name_22"
    default = "SecurityRuleInbound2"
}
variable "devops_challenge_frontend_nsg_name" {
    type = string
    default = "FrontendSecurityGroup"
}
variable "devops_challenge_application_nsg_name" {
    type = string
    default = "ApplicationSecurityGroup"
}
variable "devops_challenge_database_nsg_name" {
    type = string
    default = "DatabaseSecurityGroup"
}
module "name" {
  
}