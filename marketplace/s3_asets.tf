resource "aws_s3_bucket" "slackernews_public_media" {
  bucket = var.bucket_name

}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.slackernews_public_media.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.slackernews_public_media.bucket

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::${var.bucket_name}/*"
  }]
}
POLICY
}

resource "aws_s3_object" "image" {
  bucket       = aws_s3_bucket.slackernews_public_media.bucket
  key          = "slackernews-logo.png"   # Your image file name
  source       = "./slackernews-logo.png" # Path to your PNG image file
  content_type = "image/png"
}

resource "aws_s3_object" "terms" {
  bucket       = aws_s3_bucket.slackernews_public_media.bucket
  key          = "slackernews-terms.pdf"   # Your image file name
  source       = "./slackernews-terms.pdf" # Path to your PNG image file
  content_type = "application/pdf"
}
