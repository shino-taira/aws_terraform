#------------------------
# S3
#------------------------
resource "aws_s3_bucket" "main_s3_backet" {
  bucket = "terraform-s3-lalala"

  tags = {
    Name = "terraform-s3"
  }
}

resource "aws_s3_bucket_public_access_block" "main_s3_public_access_block" {
  bucket                  = aws_s3_bucket.main_s3_backet.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
