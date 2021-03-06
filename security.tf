### Security Groups

# Alphabetical order, please...


# ALB
resource "aws_security_group" "sg_alb" {
    description =       "Allows HTTP/HTTPS traffic to the alb from ANYWHERE to ANYWHERE"
    name =              "${var.environment}_sg_alb"
    vpc_id =            "${aws_vpc.vpc_blaze.id}"
	
	#HTTP
    ingress {
        from_port =     80
        to_port =       80
        protocol =      "tcp"
        cidr_blocks =   ["0.0.0.0/0"]
    }
	
	#HTTPS
	ingress {
        from_port =     443
        to_port =       443
        protocol =      "tcp"
        cidr_blocks =   ["0.0.0.0/0"]
    }

    egress {
        from_port =     0
        to_port =       0
        protocol =      "-1"
        cidr_blocks =   ["0.0.0.0/0"]
    }

    tags {
        Name =          "${var.environment}_sg_alb"
        Environment =   "${var.environment}"
        Version =       "${var.version}"
    }
}


# API SERVER SG
resource "aws_security_group" "sg_api" {
    description =       "Allows HTTP/HTTPS traffic to the API from ALB and within VPC"
    name =              "${var.environment}_sg_api"
    vpc_id =            "${aws_vpc.vpc_blaze.id}"
	
	#HTTP
    ingress {
        from_port =     80
        to_port =       80
        protocol =      "tcp"
	security_groups = ["${aws_security_group.sg_alb.id}"]
    }
	
	#HTTPS
	ingress {
        from_port =     443
        to_port =       443
        protocol =      "tcp"
	security_groups = ["${aws_security_group.sg_alb.id}"]
    }


    egress {
        from_port =     0
        to_port =       0
        protocol =      "-1"
        cidr_blocks =   ["0.0.0.0/0"]
    }

    tags {
        Name =          "${var.environment}_sg_api"
        Environment =   "${var.environment}"
        Version =       "${var.version}"
    }
}

# BASE (for all instances)

resource "aws_security_group" "vsg_base" {
    description =       "Base Security Group for all instances"
    name =              "${var.environment}_sg_base"
    vpc_id =            "${aws_vpc.vpc_blaze.id}"


    # Ping
    ingress {
        from_port =     8
        to_port =       8
        protocol =      "icmp"
        cidr_blocks =   ["${var.vpc}"]
        self =          true
    }
    #communication within VPC
    ingress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["${var.vpc}"]
    }
	
	# SSH
    ingress {
        from_port =     0
        to_port =       0
        protocol =      "tcp"
        cidr_blocks =   ["${var.vpc}"]
    }

    egress {
        from_port =     0
        to_port =       0
        protocol =      "-1"
        cidr_blocks =   ["0.0.0.0/0"]
    }

    tags {
        Name =          "${var.environment}_sg_base"
        Environment =   "${var.environment}"
        Version =       "${var.version}"
    }
}

# Bastion
resource "aws_security_group" "sg_bastion" {
    description =       "Allows SSH traffic to the Bastion from ANYWHERE to ANYWHERE"
    name =              "${var.environment}_sg_bastion"
    vpc_id =            "${aws_vpc.vpc_blaze.id}"

    ingress {
        from_port =     22
        to_port =       22
        protocol =      "tcp"
        cidr_blocks =   ["0.0.0.0/0"]
    }

    egress {
        from_port =     0
        to_port =       0
        protocol =      "-1"
        cidr_blocks =   ["0.0.0.0/0"]
    }

    tags {
        Name =          "${var.environment}_sg_bastion"
        Environment =   "${var.environment}"
        Version =       "${var.version}"
    }
}


