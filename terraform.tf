terraform {
  backend "gcs" {
    bucket = "kbot-bucket"
    prefix = "terraform/state"
  }
  required_providers {
    flux = {
      source = "fluxcd/flux"
    }
  }
}
