#!/bin/bash
mount /dev/xvdb/ /opt
echo "/dev/xvdb       /opt   xfs    defaults,nofail 0       2" >> /etc/fstab
mount -a
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum -y install vault
