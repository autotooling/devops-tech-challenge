module "application_server" {
    source = "../modules/vm/application"
    rg_name = "DevOpsChallengeResourceGroup"
    location = "Central India"
}