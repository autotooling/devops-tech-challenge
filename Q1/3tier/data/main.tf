module "database_server" {
    source = "../modules/vm/database"
    rg_name = "DevOpsChallengeResourceGroup"
    location = "Central India"
}