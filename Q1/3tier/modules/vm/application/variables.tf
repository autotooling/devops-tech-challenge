variable "devops_challenge_rg" {}
variable "location" {}
variable "devops_challenge_application_ni_name" {
    type = string
    default = "DevOpsChallengeApplicationNetworkInterface"
}
variable "application_ip_configuration_name" {
    type = string
    description = "Applciation ip_configuration name"
    default = "ApplicationIpConfiguration"
}
variable "devops_challenge_application_linuxvm_name" {
    type = string
    description = "devops_challenge_linuxvm name"
    default = "DevOpsChallengeApplicationVirtualMachine"
}