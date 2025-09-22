terraform {
  backend "s3" {
    bucket = "platform-state"
    key    = "platform/terraform.tfstate"
    region = "us-east-1" # required but not used by Hetzner
    endpoints = { s3 = "https://fsn1.your-objectstorage.com" } # Falkenstein region
    use_path_style              = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
  }
}