# Creating VPC
module "vpc" {
  source      = "../../Infrastructure_Definition/modules/VPC"
}

# Creating IAM resources
module "iam" {
  source = "../../Infrastructure_Definition/modules/IAM"
}

# Creating Security Groups
module "security-group" {
  source      = "../../Infrastructure_Definition/modules/Security-Groups"
  vpcID       = module.vpc.default_vpc_id
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
  publicSubnetAz1ID = module.vpc.default_subnet_ids[0]
  publicSubnetAz2ID = module.vpc.default_subnet_ids[1]
  publicSubnetAz3ID = module.vpc.default_subnet_ids[2]
  vpcID             = module.vpc.default_vpc_id
}

# Creating ASG
module "asg" {
  source              = "../../Infrastructure_Definition/modules/Auto-Scaling"
  env                 = var.env
  type                = var.type
  projectName         = var.projectName
  keyName             = var.keyName
  nodeInstanceType    = var.nodeInstanceType
  publicSubnetAz1ID   = module.vpc.default_subnet_ids[0]
  publicSubnetAz2ID   = module.vpc.default_subnet_ids[1]
  publicSubnetAz3ID   = module.vpc.default_subnet_ids[2]
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


