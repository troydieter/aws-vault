data "terraform_remote_state" "hcvault-vpc" {
    backend = "s3"
    config = {
		bucket     = "aws-vault-tfstate"
		key = "vpc.tfstate"
		region     = "us-east-1"
		profile	= "hcvault"
		workspace_key_prefix = "tfstate"
    }
}

terraform {
  backend "s3" {
    bucket     = "aws-vault-tfstate"
    key        = "ec2.tfstate"
    workspace_key_prefix = "tfstate"
    region     = "us-east-1"
	profile	= "hcvault"
  }
}
