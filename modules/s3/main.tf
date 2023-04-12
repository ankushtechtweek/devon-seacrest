##env-secret##

resource "aws_s3_bucket" "backend" {
  bucket        = "backend-s3"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "backend" {
  bucket = aws_s3_bucket.backend.id
  acl    = "private"
}

