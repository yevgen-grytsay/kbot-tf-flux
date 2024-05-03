terraform {
  backend "gcs" {
    bucket = "kbot-tf"
    prefix = "terraform/state"
  }
}
