resource "aws_s3_bucket" "s3_backet" {
  bucket = var.AWS_BUCKET
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  bucket = aws_s3_bucket.s3_backet.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.s3_backet.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership_controls,
    aws_s3_bucket_public_access_block.public_access,
  ]

  bucket = aws_s3_bucket.s3_backet.id
  acl    = "public-read"
}

# add new policy
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "PublicReadGetObject"
    actions   = [
          "s3:GetObject" ]
    resources = ["${aws_s3_bucket.s3_backet.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    effect = "Allow"
  }
}

# Attach the policy to the bucket
resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.s3_backet.bucket
  policy = data.aws_iam_policy_document.bucket_policy.json

  depends_on = [ aws_s3_bucket_public_access_block.public_access]
}