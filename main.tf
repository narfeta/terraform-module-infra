# CREATE VPC
resource "aws_vpc" "vpc" {
    cidr_block           = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"
    tags = {
        Name = "${var.tag_name}"
    }
}
# CREATE SUBNETS
resource "aws_subnet" "subnet" {
    count                   = "${length(split(",", var.zones))}"
    vpc_id                  = "${aws_vpc.vpc.id}"
    cidr_block              = "${cidrsubnet(var.vpc_cidr, 4, count.index)}"
    availability_zone       = "${var.region}${element(split(",", var.zones), count.index)}"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.tag_name}" 
    }
}
# CREATE INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags =  {
        Name = "${var.tag_name}" 
    }
}
# ADOPT CREATED DEFAULT ROUTING TABLE
resource "aws_default_route_table" "rt" {
    default_route_table_id  = "${aws_vpc.vpc.default_route_table_id}"
    tags = {
        Name = "${var.tag_name}" 
    }
}
# ASSOCIATE SUBNET WITH ROUTING TABLE
resource "aws_route_table_association" "add_subnets_to_routing_table" {
    count                   = "${length(aws_subnet.subnet.*.id)}"
    route_table_id          = "${aws_default_route_table.rt.id}"
    subnet_id               = "${element(aws_subnet.subnet.*.id, count.index)}"
}
# ASSOCIATE INTERNET GATEWAY WITH ROUTING TABLE
resource "aws_route" "create_route_internet_gateway_association" {
    route_table_id          = "${aws_default_route_table.rt.id}"
    gateway_id              = "${aws_internet_gateway.igw.id}"
    destination_cidr_block  = "0.0.0.0/0"
}
