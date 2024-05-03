terraform {
  backend "gcs" {
    bucket = "kbot-tf"
    prefix = "terraform/state"
  }
  required_providers {
    flux = {
      source = "fluxcd/flux"
    }
  }
}
