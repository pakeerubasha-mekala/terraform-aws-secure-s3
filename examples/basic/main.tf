provider "aws" {
  region = "eu-west-1"
}

module "secure_bucket" {
  source = "../.."

  bucket_name = "example-secure-bucket-change-me"

  tags = {
    environment = "dev"
    owner       = "platform-team"
  }
}

output "bucket_arn" {
  value = module.secure_bucket.bucket_arn
}
