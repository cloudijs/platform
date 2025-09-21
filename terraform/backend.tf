terraform {
  backend "s3" {
    bucket                     = var.state_bucket_name
    key                        = "platform/terraform.tfstate"
    region                     = "us-east-1" # required but not used by Hetzner
    endpoint                   = "https://fsn1.your-objectstorage.com"  # change to your region endpoint (e.g., fsn1, nbx1, hel1)
    use_path_style             = true
    skip_credentials_validation = true
    skip_region_validation     = true
    skip_metadata_api_check    = true
    access_key                 = var.state_bucket_access_key
    secret_key                 = var.state_bucket_secret_key
  }
}