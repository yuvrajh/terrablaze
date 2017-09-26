
variable "version" {
    default = "1.0.0"
    description = "The version of TF"
}

variable "environment"      { default = "PROD"   description = "ENV" }

#VPC
variable "vpc"              { default = "10.0.0.0/16"   description = "Main VPC" }
variable "blaze_dmz"           { default = "10.0.10.0/24"  description = "DMZ Subnet" }
variable "blaze_a"           { default = "10.0.11.0/24"  description = "Blaze api Subnet A" }
variable "blaze_b"           { default = "10.0.12.0/24"  description = "Blaze elasticsearch Subnet B" }
variable "blaze_c"           { default = "10.0.13.0/24"  description = "Blaze worker Subnet C" }
variable "blaze_d"           { default = "10.0.14.0/24"  description = "Blaze rds Subnet D" }
variable "blaze_e"           { default = "10.0.15.0/24"  description = "Blaze rdsreplica Subnet E" }

#Availability Zones
variable "az_1"           { default = "us-east-1a"  description = "PROD az 1" }
variable "az_2"           { default = "us-east-1b"  description = "PROD az 2" }


