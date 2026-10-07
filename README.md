# terraform-aws-secure-s3

A small Terraform module for an S3 bucket with secure defaults, so every bucket starts from a safe baseline instead of
from the AWS console defaults.

## What you get

- **No public access:** all four public-access-block settings on.
- **No ACLs:** `BucketOwnerEnforced` object ownership, access is controlled by policy only.
- **Encryption at rest:** SSE-S3 by default, or your own KMS key with S3 Bucket Keys.
- **TLS only:** a bucket policy denies any request that is not HTTPS.
- **Versioning:** on by default, with old versions expiring after 90 days (configurable).
- **Housekeeping:** incomplete multipart uploads are cleaned up after 7 days.

## Usage

```hcl
module "secure_bucket" {
  source = "github.com/pakeerubasha-mekala/terraform-aws-secure-s3"

  bucket_name = "my-unique-bucket-name"
  tags        = { environment = "prod" }
}
```

With a customer-managed key:

```hcl
module "secure_bucket" {
  source = "github.com/pakeerubasha-mekala/terraform-aws-secure-s3"

  bucket_name = "my-unique-bucket-name"
  kms_key_arn = aws_kms_key.data.arn
}
```

See [`examples/basic`](./examples/basic).

## Inputs

| Name | Description | Default |
|---|---|---|
| `bucket_name` | Globally unique bucket name | required |
| `force_destroy` | Allow deleting a non-empty bucket | `false` |
| `versioning_enabled` | Keep previous object versions | `true` |
| `kms_key_arn` | KMS key for encryption (`null` uses SSE-S3) | `null` |
| `noncurrent_version_expiration_days` | Delete old versions after N days (`0` keeps them) | `90` |
| `abort_incomplete_multipart_days` | Clean up incomplete uploads after N days | `7` |
| `tags` | Tags for every resource | `{}` |

## Outputs

`bucket_id`, `bucket_arn`, `bucket_regional_domain_name`.

## Status

`terraform fmt` and `terraform validate` pass for the module and the example. It has not been applied to a live AWS
account, so run `terraform plan` and review it before you apply.

## License

MIT
