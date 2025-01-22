#######################
# Default Network ACLs
#######################
resource "aws_default_network_acl" "this" {
  count = var.manage_default_network_acl ? 1 : 0

  # Use input variable for default network ACL ID
  default_network_acl_id = var.default_network_acl_id

  # Dynamically configure ingress rules
  dynamic "ingress" {
    for_each = var.default_network_acl_ingress
    content {
      action          = ingress.value.action
      cidr_block      = lookup(ingress.value, "cidr_block", null)
      from_port       = ingress.value.from_port
      icmp_code       = lookup(ingress.value, "icmp_code", null)
      icmp_type       = lookup(ingress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
      protocol        = ingress.value.protocol
      rule_no         = ingress.value.rule_no
      to_port         = ingress.value.to_port
    }
  }

  # Dynamically configure egress rules
  dynamic "egress" {
    for_each = var.default_network_acl_egress
    content {
      action          = egress.value.action
      cidr_block      = lookup(egress.value, "cidr_block", null)
      from_port       = egress.value.from_port
      icmp_code       = lookup(egress.value, "icmp_code", null)
      icmp_type       = lookup(egress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
      protocol        = egress.value.protocol
      rule_no         = egress.value.rule_no
      to_port         = egress.value.to_port
    }
  }

  # Tags for Default Network ACL
  tags = merge(
    {
      "Name" = var.default_network_acl_name
    },
    var.tags,
    var.default_network_acl_tags
  )

  # Ignore subnet associations to prevent unnecessary updates
  lifecycle {
    ignore_changes = [subnet_ids]
  }
}

