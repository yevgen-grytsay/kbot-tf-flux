# provider "flux" {
#   kubernetes = {
#     config_path = var.kubeconfig_path
#   }

#   git = {
#     url = "https://github.com/${var.github_org}/${var.github_repository}"
#     http = {
#       username = var.github_org
#       password = var.github_token
#     }
#   }
# }

resource "flux_bootstrap_git" "this" {
  path = "clusters/kbot"
}
