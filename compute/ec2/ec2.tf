
resource "aws_security_group" "hcvault-cluster-sg" {
  name        = "hcvault-cluster-sg"
  description = "Allow inbound traffic from anywhere over SSH"
    vpc_id      = data.terraform_remote_state.hcvault-vpc.outputs.hcvault_vpc-id

  ingress {
    description = "SSHLocation"
    from_port = 22
    to_port = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/8"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "hcvault-ec2-01" {
  ami           = "${var.ami-id}"
  instance_type = "${var.hcvault-ec2-instance-type}"
  subnet_id = data.terraform_remote_state.hcvault-vpc.outputs.hcvault_priv_subnet0-id

  vpc_security_group_ids = ["${aws_security_group.hcvault-cluster-sg.id}"]
  key_name               = "${var.key_name}"
  user_data = "${file("userdata.sh")}"
  
  # iam_instance_profile  = "${var.hcvault-ec2-instance-profile}"

  root_block_device {
  volume_type = "gp2"

  volume_size = "${var.hcvault-ec2-root-volume-size}"
  encrypted = true
  kms_key_id = "${aws_kms_key.hcvault-kms.arn}"
}

ebs_block_device{
  volume_type = "gp2"
  volume_size =  "${var.hcvault-ec2-ebs-volume-size}"
  encrypted = true
  kms_key_id = "${aws_kms_key.hcvault-kms.arn}"
  device_name= "/dev/sdb"
}


  tags = "${merge(
     local.common-tags,
     map(
       "Name", "hcvault-ec2",
       "Description", "HCVault Cluster Ec2 instance"

     )
   )}"
}
