#
# Provider Configuration
#

provider "aws" {
  region  = "ap-southeast-2"
  version = ">= 2.8"
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}