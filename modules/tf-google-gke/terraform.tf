terraform {
  required_providers {
    google = {
      source                = "hashicorp/google"
      version               = "5.27.0"
      configuration_aliases = [google.alias]
    }
  }
}
