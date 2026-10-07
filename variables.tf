variable "bucket_name" {
  description = "Globally unique name of the bucket."
  type        = string
}

variable "force_destroy" {
  description = "Allow Terraform to delete the bucket even when it contains objects. Keep false for real data."
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Keep previous versions of objects (protects against accidental overwrite and deletion)."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "KMS key for server-side encryption. When null, S3-managed keys (SSE-S3, AES256) are used."
  type        = string
  default     = null
}

variable "noncurrent_version_expiration_days" {
  description = "Delete old object versions after this many days. Set to 0 to keep them forever."
  type        = number
  default     = 90

  validation {
    condition     = var.noncurrent_version_expiration_days >= 0
    error_message = "noncurrent_version_expiration_days must be 0 or greater."
  }
}

variable "abort_incomplete_multipart_days" {
  description = "Clean up incomplete multipart uploads after this many days."
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}
