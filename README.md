terraform-module-infra
====

# Module that creates the base infrastructure

This module creates the basic infrastructure needed to deploy an application.


It will create:
- vpc
- subnets
- routing tables
- internet gateway


## Inputs
Variables |  Optional | Default Value | Example | Description
---|---|---|---|---|
cidr | no | - | 10.10.0.0/16 | The cidr that will be used to create the vpc
zones | no | - | a,b,c | the zones where the vpc will be deployed
region | no | - | us-east-1 | aws region where our infrastructure will be builded


## Outputs
Variables | Example | Description
---|---|---|
vpc id | vpc-xxx | the aws vpc id that was assigned to the created vpc
vpc_subnet | [ "subnet-xxx, "subnet-xxx"] | array result with the aws ids for the created vpc
region | us-east-1 | the region where this infrastructure was created

