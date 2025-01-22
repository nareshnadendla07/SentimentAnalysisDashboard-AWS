###############
## Outputs
###############

# Output for the default network ACL ID
output "default_network_acl_id" {
  value       = aws_default_network_acl.this[0].id
  description = "The ID of the default network ACL"
  #condition   = var.manage_default_network_acl
}

# Output for the default network ACL ingress rules
output "default_network_acl_ingress_rules" {
  value = [
    for ingress_rule in var.default_network_acl_ingress : {
      rule_no    = ingress_rule.rule_no
      action     = ingress_rule.action
      cidr_block = lookup(ingress_rule, "cidr_block", null)
      from_port  = ingress_rule.from_port
      to_port    = ingress_rule.to_port
      protocol   = ingress_rule.protocol
    }
  ]
  description = "The list of ingress rules for the default network ACL"
}

# Output for the default network ACL egress rules
output "default_network_acl_egress_rules" {
  value = [
    for egress_rule in var.default_network_acl_egress : {
      rule_no    = egress_rule.rule_no
      action     = egress_rule.action
      cidr_block = lookup(egress_rule, "cidr_block", null)
      from_port  = egress_rule.from_port
      to_port    = egress_rule.to_port
      protocol   = egress_rule.protocol
    }
  ]
  description = "The list of egress rules for the default network ACL"
}

# Output for default network ACL tags
output "default_network_acl_tags" {
  value       = aws_default_network_acl.this[0].tags
  description = "The tags applied to the default network ACL"
}

