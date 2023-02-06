variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "Private Subnet CIDR values"
  default     = "10.0.4.0/24"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone"
  default     = "ap-south-1a"
}
