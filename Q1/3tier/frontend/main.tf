module "frontend_server" {
    source = "../modules/vm/frontend"
    rg_name = "DevOpsChallengeResourceGroup"
    location = "Central India"
}