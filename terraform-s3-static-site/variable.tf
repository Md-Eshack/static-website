variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-north-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
  default     = "my-bucket-unique-eshack"
}
