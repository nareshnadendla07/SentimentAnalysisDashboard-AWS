######################
# VPC Flow Logs
######################

# CloudWatch Log Group for VPC Flow Logs
resource "aws_cloudwatch_log_group" "vpcflowlog_group" {
  name              = "${var.name}-vpcflowlogs"
  retention_in_days = var.log_retention_in_days

  tags = merge(
    {
      "Name" = "${var.name}-vpcflowlogs"
    },
    var.tags
  )
}

# IAM Role for VPC Flow Logs
resource "aws_iam_role" "vpcflowlog_role" {
  name = "${var.name}-VpcFlowlogsRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = merge(
    {
      "Name" = "${var.name}-VpcFlowlogsRole"
    },
    var.tags
  )
}

# IAM Role Policy for VPC Flow Logs
resource "aws_iam_role_policy" "vpcflowlog_policy" {
  name = "${var.name}-vpcflowlog-policy"
  role = aws_iam_role.vpcflowlog_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "${aws_cloudwatch_log_group.vpcflowlog_group.arn}"
    }
  ]
}
EOF
}

# VPC Flow Log Configuration
resource "aws_flow_log" "cloudwatch_logs" {
  iam_role_arn    = aws_iam_role.vpcflowlog_role.arn
  log_destination = aws_cloudwatch_log_group.vpcflowlog_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.this[0].id
  log_format      = <<EOT
$${pkt-srcaddr} $${srcaddr} $${srcport} $${pkt-dstaddr} $${dstaddr} $${dstport} $${protocol} $${interface-id} $${action} $${log-status} $${type} $${account-id}
EOT

  tags = merge(
    {
      "Name" = "${var.name}-flowlogs"
    },
    var.tags
  )
}
