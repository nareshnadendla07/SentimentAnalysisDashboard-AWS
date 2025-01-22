###################
## Internet Gateway
###################
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s Internet Gateway", var.client_prefix)
    },
    var.tags
  )
}

###############
## Route Tables
###############
resource "aws_route_table" "route_tables" {
  count = length(var.subnets)

  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s Route Table %s", var.client_prefix, tostring(count.index + 1))
    },
    var.tags
  )
}

############################
## Routes for Public Subnets
############################
resource "aws_route" "routes" {
  count = length(var.subnets)

  route_table_id         = aws_route_table.route_tables[count.index].id
  destination_cidr_block = "0.0.0.0/0"

  # Associate the route with the Internet Gateway only for public subnets
  gateway_id = var.subnets[count.index].public ? aws_internet_gateway.this.id : null

  # Prevent error when no gateway is assigned
  lifecycle {
    ignore_changes = [gateway_id]
  }
}

###########################
## Route Table Associations
###########################
resource "aws_route_table_association" "associations" {
  count = length(var.subnets)

  subnet_id      = var.subnets[count.index].id
  route_table_id = aws_route_table.route_tables[count.index].id
}