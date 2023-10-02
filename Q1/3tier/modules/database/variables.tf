variable "devops_challenge_database_ni_name" {
    type = string
    default = "DevOpsChallengeDatabaseNetworkInterface"
}
variable "database_ip_configuration_name" {
    type = string
    description = "Database ip_configuration name"
    default = "DatabaseIpConfiguration"
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
variable "devops_challenge_database_windowsvm_name" {
    type = string
    description = "devops_challenge_database_windowsvm name"
    default = "DevOpsChallengeDatabaseVirtualMachine"
}
variable "name" {
    type = string
    description = "sql server name"
    default = "mssqlserver"
}
variable "version" {
    type = string
    default = "16.0"
    description = "version"
}
variable "db_name" {
    type = string
    default = "DevOpsChallengeDB"
    description = "database name"
}