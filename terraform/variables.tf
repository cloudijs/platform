# Hetzner secrets
variable "hcloud_token" {
  sensitive = true
}

# Terraform state
variable "state_bucket_name" {
  sensitive = true
}
variable "state_bucket_access_key" {
  sensitive = true
}
variable "state_bucket_secret_key" {
  sensitive = true
}