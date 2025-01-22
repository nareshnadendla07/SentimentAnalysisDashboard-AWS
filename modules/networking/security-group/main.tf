resource "aws_security_group" "this" {
  count        = var.create ? 1 : 0
  name_prefix  = "${var.name}-"
  description  = var.description
  vpc_id       = var.vpc_id

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

###########################
# Ingress and Egress Rules
###########################
resource "aws_security_group_rule" "ingress_rules" {
  count             = var.create ? length(var.ingress_rules) : 0
  security_group_id = aws_security_group.this[0].id
  type              = "ingress"

  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = lookup(var.ingress_rules[count.index], "cidr_blocks", null)
  ipv6_cidr_blocks  = lookup(var.ingress_rules[count.index], "ipv6_cidr_blocks", null)
  source_security_group_id = lookup(var.ingress_rules[count.index], "source_security_group_id", null)
  self              = lookup(var.ingress_rules[count.index], "self", false)
  description       = lookup(var.ingress_rules[count.index], "description", "Ingress Rule")
}

resource "aws_security_group_rule" "egress_rules" {
  count             = var.create ? length(var.egress_rules) : 0
  security_group_id = aws_security_group.this[0].id
  type              = "egress"

  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = lookup(var.egress_rules[count.index], "cidr_blocks", null)
  ipv6_cidr_blocks  = lookup(var.egress_rules[count.index], "ipv6_cidr_blocks", null)
  source_security_group_id = lookup(var.egress_rules[count.index], "source_security_group_id", null)
  self              = lookup(var.egress_rules[count.index], "self", false)
  description       = lookup(var.egress_rules[count.index], "description", "Egress Rule")
}
