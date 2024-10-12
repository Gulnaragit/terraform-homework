# Create buckets
resource "aws_s3_bucket" "bucket1" {
  bucket = "kaizen-gulnara"
  #force_destroy = true
}

resource "aws_s3_bucket" "bucket2" {
  bucket_prefix = "kaizen-"
  #force_destroy = true
}

# To import buckets from aws
resource "aws_s3_bucket" "bucket3" {
  bucket = "gulnara-bucket1"
  #force_destroy = true
}

resource "aws_s3_bucket" "bucket4" {
  bucket = "gulnara-bucket2"
  #force_destroy = true
}
# terraform import aws_s3_bucket.bucket3 gulnara-bucket1
# terraform import aws_s3_bucket.bucket4 gulnara-bucket2

# Create users
resource "aws_iam_user" "teammates" {
  for_each = toset(["jenny","rose","lisa","jisoo"])  
  name = each.value
  }

# Create group
  resource "aws_iam_group" "bandname" {
  name = "blackpink"
  }

# Add users to the group
  resource "aws_iam_group_membership" "band" {
  name = "popgroup"

  users = [
    for i in aws_iam_user.teammates : i.name
  ]

  group = aws_iam_group.bandname.name
}