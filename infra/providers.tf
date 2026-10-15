provider "aws" {
  default_tags {
    tags = local.tags
  }
}

# provider "aws" {
#   alias  = "us"
#   region = "us-east-1"
# }