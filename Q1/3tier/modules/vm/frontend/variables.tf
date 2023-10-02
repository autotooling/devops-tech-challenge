variable "devops_challenge_rg" {}
variable "location" {}
variable "devops_challenge_frontend_ni_name" {
    type = string
    default = "DevOpsChallengeFrontendNetworkInterface"
}
variable "frontend_ip_configuration_name" {
    type = string
    description = "Frontend ip_configuration name"
    default = "FrontendIpConfiguration"
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
variable "devops_challenge_frontend_linuxvm_name" {
    type = string
    description = "devops_challenge_linuxvm name"
    default = "DevOpsChallengeFrontendVirtualMachine"
}