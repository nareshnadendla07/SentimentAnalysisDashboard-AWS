#########
# Subnets
#########

resource "aws_subnet" "subnets" {
  count = length(var.subnets)

  vpc_id               = var.vpc_id
  cidr_block           = var.subnets[count.index].cidr_block
  availability_zone    = var.subnets[count.index].az
  map_public_ip_on_launch = lookup(var.subnets[count.index], "map_public_ip", false)

  tags = merge(
    {
      "Name" = lookup(var.subnets[count.index], "name", format("Subnet-%d", count.index))
    },
    var.tags
  )
}