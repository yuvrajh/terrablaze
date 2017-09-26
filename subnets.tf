# DMZ

resource "aws_subnet" "subnet_public_dmz" {
    vpc_id = "${aws_vpc.vpc_blaze.id}"
    cidr_block = "${var.blaze_dmz}"
    availability_zone = "${var.az_1}"
    map_public_ip_on_launch = true

    tags {
        Name = "${var.environment}.subnet.dmz"
        Environment = "${var.environment}"
        Version = "${var.version}"
    }
}

# Private Subnets

resource "aws_subnet" "subnet_private_1" {
    vpc_id = "${aws_vpc.vpc_blaze.id}"
    cidr_block = "${var.blaze_a}"
    availability_zone = "${var.az_1}"

    tags {
        Name = "${var.environment}.subnet.applicationapi"
        Environment = "${var.environment}"
        Version = "${var.version}"
    }
}

resource "aws_subnet" "subnet_private_2" {
    vpc_id = "${aws_vpc.vpc_blaze.id}"
    cidr_block = "${var.blaze_b}"
    availability_zone = "${var.az_1}"

    tags {
        Name = "${var.environment}.subnet.elasticsearch"
        Environment = "${var.environment}"
        Version = "${var.version}"
    }
}

resource "aws_subnet" "subnet_private_3" {
    vpc_id = "${aws_vpc.vpc_blaze.id}"
    cidr_block = "${var.blaze_c}"
    availability_zone = "${var.az_1}"

    tags {
        Name = "${var.environment}.subnet.worker"
        Environment = "${var.environment}"
        Version = "${var.version}"
    }
}

resource "aws_subnet" "subnet_private_4" {
    vpc_id = "${aws_vpc.vpc_blaze.id}"
    cidr_block = "${var.blaze_d}"
    availability_zone = "${var.az_1}"

    tags {
        Name = "${var.environment}.subnet.rds"
        Environment = "${var.environment}"
        Version = "${var.version}"
    }
}

resource "aws_subnet" "subnet_private_5" {
    vpc_id = "${aws_vpc.vpc_blaze.id}"
    cidr_block = "${var.blaze_e}"
    availability_zone = "${var.az_2}"

    tags {
        Name = "${var.environment}.subnet.rdsreplica"
        Environment = "${var.environment}"
        Version = "${var.version}"
    }
}
