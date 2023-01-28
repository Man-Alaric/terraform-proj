provider "aws" { 
}

variable "cidr_blocks" {
  description = "subnet cidr block"
  type = list(object({
    cidr_block = string
    name = string
  }))

}

variable "environment" {
  description = "deployment environment"
}
resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_blocks[1].cidr_block
  tags = {
      Name = var.cidr_blocks[1].name
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id =aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[0].cidr_block
    availability_zone = "eu-west-3a"
    tags = {
      "Name" = var.cidr_blocks[0].name
    }
 }

 data "aws_vpc" "existing-vpc" {
    default = true
 }

 #resource "aws_subnet" "dev-subnet-2" {
    #cidr_block = var.cidr_block[1]
    #availability_zone = "eu-west-3a"
    #tags = {
      #"Name" = "subnet-2-dev"
    #}
 #}

 output "dev-vpc-id" {
  value = "aws_vpc.development-vpc.id"
 }

 output "dev-subnet-id" {
  value = "aws_subnet.dev-subnet-2.id"
 }