#!/bin/bash
mount /dev/xvdb/ /opt
echo "/dev/xvdb       /opt   xfs    defaults,nofail 0       2" >> /etc/fstab
mount -a
yum -y install python3
yum -y install wget
adduser dal-user
passwd -d dal-user
usermod -aG wheel dal-user
mkdir /home/dal-user/.ssh/
usermod -aG wheel ec2-user
whoami >> /var/log/infaagent.log
sudo su - dal-user >> /var/log/infaagent.log
aws s3 cp s3://dal-bi-dev-access-keys/keys/dal-user.pub /home/dal-user/.ssh/authorized_keys
aws s3 cp s3://dal-bi-dev-access-keys/packages/agent64_install_ng_ext.bin /opt/
aws s3 cp s3://dal-bi-dev-access-keys/packages/token.txt /opt/
chmod -R 777 /opt
cd /opt
value=$(<token.txt)
whoami >> /var/log/infaagent.log
sudo su - dal-user >> /var/log/infaagent.log

mkdir /opt/infaagent
./agent64_install_ng_ext.bin -i silent -DUSER_INSTALL_DIR=/opt/infaagent
sleep 3m
sudo chown -R dal-user /opt/infaagent/
ls -al >> /var/log/infaagent.log
cd /opt/infaagent/apps/agentcore/
 sudo -u  dal-user ./infaagent startup
sleep 7m
echo $value >> /var/log/infaagent.log
 sudo -u  dal-user ./consoleAgentManager.sh configureToken Hemanthkumar.Bangalore@bcbsma.com.dev $value >> /var/log/infaagent.log
 echo "Check if the consoleAgentManager is configured "
 sudo -u  dal-user ./consoleAgentManager.sh isconfigured  >> /var/log/infaagent.log
 whoami >> /var/log/infaagent.log
 sudo -u  dal-user whoami >> /var/log/infaagent.log
 ls -al >> /var/log/infaagent.log
 pwd >> >> /var/log/infaagent.log
cd /opt
 sudo -u  dal-user yum -y install unixODBC.x86_64
wget https://downloads.mysql.com/archives/get/p/10/file/mysql-connector-odbc-8.0.12-linux-glibc2.12-x86-64bit.tar.gz
 sudo -u  dal-user tar -xf mysql-connector-odbc-8.0.12-linux-glibc2.12-x86-64bit.tar.gz
cd /opt/mysql-connector-odbc-8.0.12-linux-glibc2.12-x86-64bit/bin
sudo -u  dal-user ./myodbc-installer -a -d -n "MySQL ODBC 8.0 Driver" -t "Driver=/opt/mysql-connector-odbc-8.0.12-linux-glibc2.12-x86-64bit/lib/libmyodbc8w.so"
echo -e '[MySQL ODBC 8.0 Unicode Driver]\nDescription = ODBC for MySQL\nDriver = /opt/mysql-connector-odbc-8.0.12-linux-glibc2.12-x86-64bit/lib/libmyodbc8w.so\nSetup = /opt/mysql-connector-odbc-8.0.12-linux-glibc2.12-x86-64bit/lib/libmyodbc8w.so\nFileUsage = 1' > /opt/infaagent/odbcinst.ini
cd /opt
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.12.tar.gz
sudo -u  dal-user tar -xf mysql-connector-java-8.0.12.tar.gz
cp /opt/mysql-connector-java-8.0.12/mysql-connector-java-8.0.12.jar /opt/infaagent/apps/Data_Integration_Server/ext/drivers/
aws s3 cp s3://dal-bi-dev-access-keys/packages/odbc.ini /opt/infaagent/
cd /opt/infaagent/apps/agentcore/
sudo -u  dal-user  ./infaagent shutdown
sudo -u  dal-user  ./infaagent startup
cd /opt
curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo
yum remove unixODBC-utf16 unixODBC-utf16-devel
ACCEPT_EULA=Y yum -y install msodbcsql
ACCEPT_EULA=Y yum -y install mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc source ~/.bashrc
yum -y install unixODBC-devel
cd /opt
aws s3 cp s3://dal-bi-dev-access-keys/packages/sqljdbc_7.4.1.0_enu.tar.gz /opt
sudo -u  dal-user tar -xf sqljdbc_7.4.1.0_enu.tar.gz
sudo -u  dal-user  cp /opt/mysql-connector-java-8.0.12/mysql-connector-java-8.0.12.jar /opt/infaagent/apps/Data_Integration_Server/ext/drivers/
echo $'[Global]\n$$env=DEV' >> /opt/infaagent/apps/Data_Integration_Server/data/userparameters/params.txt
rpm -Uvh https://s3.amazonaws.com/amazoncloudwatch-agent//amd64/latest/amazon-cloudwatch-agent.rpm
yum update -y
easy_install --script-dir /opt/aws/bin https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
/opt/aws/bin/cfn-init -v --stack ${AWS::StackId} --resource awsDevBiIics --region ${AWS::Region} --configsets default
/opt/aws/bin/cfn-signal -e $? --stack ${AWS::StackId} --resource awsDevBiIics --region ${AWS::Region}
