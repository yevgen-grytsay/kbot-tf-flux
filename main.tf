module "kbot-tf-flux-bootstrap" {
  source            = "./modules/tf-flux-bootstrap"
  github_org        = var.github_org
  github_repository = var.github_repository
  github_token      = var.github_token
}
