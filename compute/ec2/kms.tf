resource "aws_kms_key" "hcvault-kms" {
  description             = "KMS Key for encrypting the EBS volumes"
  enable_key_rotation     = "true"
}

resource "aws_kms_alias" "hcvault-kms-alias" {
  name          = "alias/hcvault-kms-alias"
  target_key_id = "${aws_kms_key.hcvault-kms.key_id}"
}
