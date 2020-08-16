resource "aws_vpc" "hcvault_vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags = "${merge(
     local.common-tags,
     map(
       "Name", "${var.aws_account}-${var.environment}-vpc",
       "Description",  "VPC for creating ${var.aws_account}-${var.environment} resources"
     )
   )}"
}
