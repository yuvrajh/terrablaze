## Launch configuration
 
resource "aws_launch_configuration" "lc_api" {
    name                 = "${var.project}-${var.environment}-web"
    image_id             = "${lookup(var.ami, "${var.aws_region}_amz_hvm")}"
    instance_type        = "${lookup(var.instance_type, "api")}"
    key_name             = "${var.key_name}"
    iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile.name}"
    security_groups      = ["${aws_security_group.sg_api.id}"]
    user_data            = "${data.template_file.api_launch_config.rendered}"

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = true
    }

#    depends_on = ["aws_s3_bucket.ecs"]
}

data "template_file" "api_launch_config" {
    template = "${file("${path.module}/resources/launch-configs/lc-api.sh")}"
}
### ASGs

resource "aws_autoscaling_group" "asg_api" {
    enabled_metrics = [
        "GroupMinSize",
        "GroupMaxSize",
        "GroupDesiredCapacity",
        "GroupInServiceInstances",
        "GroupPendingInstances",
        "GroupStandbyInstances",
        "GroupTerminatingInstances",
        "GroupTotalInstances"
    ]
    desired_capacity =                  "${var.desired_cluster_size_api}"
    health_check_grace_period =         "${var.health_check_grace_period}"
    health_check_type =                 "${var.health_check_type}"
    launch_configuration =              "${aws_launch_configuration.lc_api.name}"
#    load_balancers =                    ["${aws_elb.elb_elasticsearch.id}"]
	target_group_arns =                 ["${aws_alb_target_group.webapi.arn}"]
    max_size =                          "${var.max_cluster_size_api}"
    min_size =                          "${var.min_cluster_size_api}"
    name =                              "${var.environment}_asg_api"
#    protect_from_scale_in =             "${var.scale_in_protection}"

    vpc_zone_identifier = [
        "${aws_subnet.subnet_private_1.id}"
    ]

    tag = {
        key =                   "Environment"
        propagate_at_launch =   true
        value =                 "${var.environment}"
    }
    tag = {
        key =                   "Name"
        propagate_at_launch =   true
        value =                 "${var.environment}_asg_api"
    }
    tag = {
        key =                   "Version"
        propagate_at_launch =   true
        value =                 "${var.version}"
    }
}
