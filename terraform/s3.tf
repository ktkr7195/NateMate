resource "aws_s3_bucket" "natemate-bucket" {
  acl           = var.null
  bucket        = "natemate-bucket"
  force_destroy = var.null
  lifecycle {
    prevent_destroy = true
  }

}
variable "null" {
  type    = string
  default = null
}

