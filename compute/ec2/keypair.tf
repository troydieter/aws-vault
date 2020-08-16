resource "aws_key_pair" "hcvault-cluster-key" {
  key_name   = "${var.key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoMZ915Ruww9vvNnMmZg6Qc8eIhtDjXRc8D+ewiUuOGporJbZZiZf9pOBpjV4nvluDUw3pnax4H2Mq0sc9uHP/F+21Vt1bcA32fywoqaQCbFmyxLcfbAK7kY/QgQhAk8rtLlfS0vLTOXCQmWExdMYqCuZEz0cdGbg8CEumaGa0ZzDKGY93ehdWrGk0n79RNILNtmmPwKZT9ryTP8+HLVue7CzOd7SUyEbSbhWh5IUbj6Kb6qb4ZTeEl9Avwvv/+yk+KYBPpNcOY1ceX/WUUbp9/PrPm3ltvxMd+gkzxU7W/OqRXA+Aq5Qhg+WdTCNfJYIXlLbaxu6e6j5D1+HGZWkR"
}