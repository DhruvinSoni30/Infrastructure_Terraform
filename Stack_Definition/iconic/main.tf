# Creating VPC
module "vpc" {
  source              = "../../Network_Definition/VPC"
  env                 = var.env
  type                = var.type
  projectName         = var.vpcName
  vpcCIDR             = var.vpcCIDR
  publicSubnetAz1CIDR = var.publicSubnetAz1CIDR
  publicSubnetAz2CIDR = var.publicSubnetAz2CIDR
  publicSubnetAz3CIDR = var.publicSubnetAz3CIDR
}

# Creating IAM resources
module "iam" {
  source = "../../Infrastructure_Definition/modules/IAM"
}

# Creating Security Groups
module "security-group" {
  source      = "../../Infrastructure_Definition/modules/Security-Groups"
  vpcID       = module.vpc.vpcID
  env         = var.env
  type        = var.type
  projectName = var.projectName
  sshAccess   = var.sshAccess
  uiAccess    = var.uiAccess
}

# Creating ALB
module "alb" {
  source            = "../../Infrastructure_Definition/modules/ALB"
  env               = var.env
  type              = var.type
  projectName       = var.projectName
  nodeSecurityGroup = module.security-group.nodeSecurityGroupID
  publicSubnetAz1ID = module.vpc.publicSubnetAz1
  publicSubnetAz2ID = module.vpc.publicSubnetAz2
  publicSubnetAz3ID = module.vpc.publicSubnetAz3
  vpcID             = module.vpc.vpcID
}

# Creating ASG
module "asg" {
  source              = "../../Infrastructure_Definition/modules/Auto-Scaling"
  env                 = var.env
  type                = var.type
  projectName         = var.projectName
  keyName             = var.keyName
  nodeInstanceType    = var.nodeInstanceType
  publicSubnetAz1ID   = module.vpc.publicSubnetAz1
  publicSubnetAz2ID   = module.vpc.publicSubnetAz2
  publicSubnetAz3ID   = module.vpc.publicSubnetAz3
  nodeDesiredCapacity = var.nodeDesiredCapacity
  targetGroupARN      = module.alb.targetGroupARN
  nodeSecurityGroup   = module.security-group.nodeSecurityGroupID
  nodeVolumeSize      = var.nodeVolumeSize
  instanceProfile     = module.iam.instanceProfile
}

# Creating Key Pair
module "key_pair" {
  source  = "../../Infrastructure_Definition/modules/Key-Pair"
  keyName = var.keyName
}


