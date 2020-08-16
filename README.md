## aws-vault
Terraform deployment of HashiCorp Vault. 

Requirements

 - Terraform v0.12.26
 - SSH KeyPair creation *(public key stored in compute\ec2\keypair.tf)*
 - AWS Profile with ample IAM permissions, with access key and secret access key stored in ~\.aws\credentials and labeled as:

> hcvault
- AWS VPC deployment to 10.10.0.0/21 *(set in network\terraform.tfvars)*

Includes the following components:

 - VPC

    aws_eip.nat
    aws_internet_gateway.main-igw
    aws_nat_gateway.main-natgw
    aws_route_table.PrivateRouteTable
    aws_route_table.PublicRouteTable
    aws_route_table_association.route_hcvault_Privatesubnet[0]
    aws_route_table_association.route_hcvault_Privatesubnet[1]
    aws_route_table_association.route_hcvault_Publicsubnet[0]
    aws_route_table_association.route_hcvault_Publicsubnet[1]
    aws_subnet.private_subnet[0]
    aws_subnet.private_subnet[1]
    aws_subnet.public_subnet[0]
    aws_subnet.public_subnet[1]
    aws_vpc.hcvault_vpc
- EC2

**In-Progress**

 - Auto Scaling Group
 - Route 53 integration
 - Secrets Manager for HC Vault unlock key
 - Bastion host for EC2 instance in public subnet
 - Application Load Balancer for proper routing
