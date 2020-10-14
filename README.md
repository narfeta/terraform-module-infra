terraform-module-vpc
====

## Module that creates the base infrastructure


Variables |  Optional | Default Value |
---|---|---
cidr | no | - |
zones | no | - | 
region | no | - |

### cidr
The cidr that will be used to create the vpc `ex. 10.10.0.0/16`

### zones
the zones where the vpc will be deployed `ex. a,b,c`

### region
aws region where our infrastructure will be builded `ex. us-east-1`


## Outputs

### vpc_id
the vpc id 

### vpc_subnets
array with the subnets ids
