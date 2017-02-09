resourse "aws_instance" "jobsub" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  tags {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "jobsub" {
  name = "${var.environment_name}-jobsub"
}

resource "aws_security_group_rule" "allow_ssh_its" {
  type              = "ingress"
  security_group_id = "${aws_security_group.jobsub.id}"

  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["216.146.171.0/24"]
}

resource "aws_security_group_rule" "allow_datacenter_inbound" {
  type              = "ingress"
  security_group_id = "${aws_security_group.jobsub.id}"

  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["198.187.211.0/24, 198.187.214.0/24"]
}

resource "aws_security_group_rule" "allow_aws_inbound" {
  type              = "ingress"
  security_group_id = "${aws_security_group.jobsub.id}"

  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = "${aws_security_group.jobsub.id}"

  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
