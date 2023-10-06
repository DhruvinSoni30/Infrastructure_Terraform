# Environment
variable "env" {
  type    = string
  default = "Production"
}

# Region
variable "region" {
  type = string
}

# Type
variable "type" {
  type    = string
  default = "Prod"
}

# Customer name
variable "projectName" {
  type = string
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
