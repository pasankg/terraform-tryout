# Before using variable

//provider "aws" {
//  profile                 = "default"
//  region                  = "us-east-1"
//  shared_credentials_file = "/Users/pasgamag/.aws"
//}
//
//resource "aws_instance" "example" {
//  ami           = "ami-b374d5a5"
//  instance_type = "t2.micro"
//
//  // To do some initial setup on your instances,
//  // then provisioners let you upload files, run shell scripts, or
//  // install and trigger other software like configuration management tools, etc.
//  provisioner "local-exec" {
//    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
//  }
//}
//
//resource "aws_eip" "ip" {
//  vpc = true
//  instance = aws_instance.example.id  //Implicit Dependencies
//}

# After using variables

// Run this command on console: terraform apply -var region=us-east-1
provider "aws" {
  profile                 = "default"
  region                  = var.region
  shared_credentials_file = "/Users/pasgamag/.aws" // Path to AWS credential file
}

resource "aws_instance" "example" {
  ami           = var.amis[var.region]
  instance_type = "t2.micro"

  // To do some initial setup on your instances,
  // then provisioners let you upload files, run shell scripts, or
  // install and trigger other software like configuration management tools, etc.
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id //Implicit Dependencies
}

// Output this value to the console
output "ami" {
  value = aws_instance.example.ami
}
output "ip" {
  value = aws_eip.ip.public_ip
}

