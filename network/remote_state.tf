terraform {
  backend "s3" {
    bucket     = "aws-vault-tfstate"
    key        = "vpc.tfstate"
    workspace_key_prefix = "tfstate"
    region     = "us-east-1"
	profile	= "hcvault"
  }
}
