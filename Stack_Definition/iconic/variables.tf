# Environment
variable "env" {
  type    = string
  default = "Production"
}

# Type
variable "type" {
  type    = string
  default = "Prod"
}

# Region 
variable "region" {
  type = string
}

# Customer name
variable "projectName" {
  type = string
}

# VPC name 1
variable "vpcName" {
  type = string
}

# VPC cidr
variable "vpcCIDR" {
  type    = string
  default = "10.0.0.0/16"
}

# CIDR of public subet in AZ1 
variable "publicSubnetAz1CIDR" {
  type    = string
  default = "10.0.1.0/16"
}

# CIDR of public subet in AZ2
variable "publicSubnetAz2CIDR" {
  type    = string
  default = "10.0.2.0/16"
}

# CIDR of public subet in AZ3
variable "publicSubnetAz3CIDR" {
  type    = string
  default = "10.0.3.0/16"
}

# Key 
variable "keyName" {
  type    = string
  default = "Demo-key"
}

# Instance type for Indexers
variable "nodeInstanceType" {
  type = string
}

# Desire capacity for Indexers
variable "nodeDesiredCapacity" {
  type = number
}

# Indexers Volume Size
variable "nodeVolumeSize" {
  type = string
}

# SSH Access
variable "sshAccess" {
  type = list(string)
}

# UI Access
variable "uiAccess" {
  type = list(string)
}
