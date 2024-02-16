output "bucket_name" {
  value = aws_s3_bucket.slackernews_public_media.bucket
}

output "terms_url" {
  value = "https://${aws_s3_bucket.slackernews_public_media.bucket}.s3.${var.region}.amazonaws.com/${aws_s3_object.terms.key}"
}

output "image_url" {
  value = "https://${aws_s3_bucket.slackernews_public_media.bucket}.s3.${var.region}.amazonaws.com/${aws_s3_object.image.key}"
}