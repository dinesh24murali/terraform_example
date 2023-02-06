# Terraform

This repo contains everthing I learnt about [terraform](https://registry.terraform.io/). [This](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) is the AWS section of terraform. This page gives you a quick tutorial to get started with terraform. The points mentioned here `might not be accurate`, at the time of creating this repo I was still learning.

- You can name your files how ever you want in terraform. There is no convention

- Remember that when you setup terraform in your local machine, it will be in sync with what ever infra you create in AWS. There can be only one system that can be in sync with the infra that is created. Meaning it is not like a github repo where multiple people can run the same project. Multiple people cannot sync the same infra with the same terraform configuration.

- I created an EC2 instances manually through AWS console because I couldn't find a way to assign the pem file to the EC2 instance through terraform. In the EC2 instance I installed nginx and tested it. Link will be at the end

## How to setup:

If you have just started using this repo from stratch you need the following

- Specify the location of your AWS credentials, or you can follow [this link](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build#prerequisites) to add the credentials.
- To initialize terraform run the following
```
terraform init
```
- To format the terraform files
```
terraform fmt
```
- To validate the terraform configurations
```
terraform validate
```
- To create the infrastructure
```
terraform apply
```
- To show the current status of the infra
```
terraform show
```
- List all the services in your project's state
```
terraform state list
```
- You can run `terraform apply` after making changes in your configuration to apply those changes
- Destroy the infrastructure
```
terraform destroy
```

## What we have did in this repo:

We have created the following in this repo:
- [VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) 
- [subnet](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html)
- [security group](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-security-groups.html)
- [EC2 instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)
- [Internet gateway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html) 
- [Routing table](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) 

## VPC:

All the AWS infrastructures is built into a VPC. The outside world can connect to a VPC through a internet gateway

- When we create a VPC it will automatically create & assign a routing table to it

```
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```

## Subnets:

You can think of Subnets as subdivisions inside a VPC where EC2 and other infrastructures can be put into. There are two types of subnets

- `Public subnets` can be accessed by the outside world. We can put our web servers into a public subnet.
- `Private subnets` cannot be accessed from outside the VPC. We can put our DB into a private subnet.
- A public subnet can access a private subnet using a few rules
- We can specify the VPC that this subnet is associated to as shown below.

```
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id <------------------------- here
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}
```

## Security group:

Secruity groups is where we configure the firewall for our servers. It can be assigned to a EC2 and other services.

- With security groups it is easier to control the inbound traffic and the outbound traffic with rules.
- In terraform the outbound traffic is specified in [egress](https://github.com/dinesh24murali/terraform_learn/blob/main/main.tf#L61) and the inbound traffic is specified in [ingress](https://github.com/dinesh24murali/terraform_learn/blob/main/main.tf#L37) sections.

Examples:

```
ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
}
```

- This rule tells the security group to allow incomming traffic through port 22. This port is primarily used for connecting to our EC2 over ssh.

```
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
```
- This rule tells the security group to allow an service that runs inside the EC2 (which uses this security group) to make request to any IP/domain outside the security group.

## Internet gateway

- Only one internet gateway can be assigned to one VPC

## Routing table

- Routing tables are rules through which the traffic to subnets, gatways, and other resources are controlled

- When creating a VPC a default routing table will get created

- Here we are creating a second routing table to handle public traffic. We assign it to the public subnet

### Aws_route_table_association

- we are creating a aws_route_table_association to assign the public routing table to the public subnet

### Output

The output section in terraform is using to extract details regarding the services that are deployed.

Example:
```
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}
```
here we are extracting the the ID of the VPC that is deployed



## Reference

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

https://spacelift.io/blog/terraform-aws-vpc

https://www.nginx.com/blog/setting-up-nginx/#terminal

https://spacelift.io/blog/terraform-commands-cheat-sheet
