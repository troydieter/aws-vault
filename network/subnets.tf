

data "aws_availability_zones" "available" {}

resource "aws_subnet" "private_subnet" {
  count 		    = length(var.private_subnet_cidrs)
  vpc_id            = "${aws_vpc.hcvault_vpc.id}"
  cidr_block        = "${element(split(",", join(",", var.private_subnet_cidrs)), count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = "${merge(
     local.common-tags,
     map(
       "Name", "${var.aws_account}-${var.environment}-private-subnet-${count.index+1}",
       "Description",  "${var.aws_account}-${var.environment} private subnet - ${count.index+1}"
     )
   )}"

}



resource "aws_subnet" "public_subnet" {
  count 		    = length(var.public_subnet_cidrs)
  vpc_id            = "${aws_vpc.hcvault_vpc.id}"
  cidr_block        = "${element(split(",", join(",", var.public_subnet_cidrs)), count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = "${merge(
     local.common-tags,
     map(
       "Name", "${var.aws_account}-${var.environment}-public-subnet-${count.index+1}",
       "Description",  "${var.aws_account}-${var.environment} private subnet - ${count.index+1}"
     )
   )}"

}


