#######################
## API Gateway REST API
#######################
resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = var.api_description

  tags = merge(
    {
      "Name" = var.api_name
    },
    var.tags
  )
}

#######################
# API Gateway Resources
#######################

resource "aws_api_gateway_resource" "resources" {
  count = length(var.api_resources)

  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = var.api_resources[count.index].parent_id != null ? var.api_resources[count.index].parent_id : aws_api_gateway_rest_api.this.root_resource_id
  path_part   = var.api_resources[count.index].path_part
}

#####################
# API Gateway Methods
#####################

resource "aws_api_gateway_method" "methods" {
  for_each = var.api_methods

  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = lookup(each.value, "resource_id", aws_api_gateway_rest_api.this.root_resource_id)
  http_method   = each.value.http_method
  authorization = each.value.authorization
  api_key_required = lookup(each.value, "api_key_required", false)
}

################################
# API Gateway Method Integration
################################

resource "aws_api_gateway_integration" "integrations" {
  for_each = var.api_methods

  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = lookup(each.value, "resource_id", aws_api_gateway_rest_api.this.root_resource_id)
  http_method             = each.value.http_method
  integration_http_method = lookup(each.value, "integration_http_method", each.value.http_method)
  type                    = lookup(each.value, "integration_type", "MOCK")
  uri                     = lookup(each.value, "uri", null)
}

########################
# API Gateway Deployment
########################
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_method.methods]

  rest_api_id = aws_api_gateway_rest_api.this.id
  #stage_name  = var.stage_name

  lifecycle {
    create_before_destroy = true
  }

  
}

###################
# API Gateway Stage
###################

resource "aws_api_gateway_stage" "stage" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = var.stage_name

  deployment_id = aws_api_gateway_deployment.deployment.id

  tags = merge(
    {
      "Name" = "${var.api_name}-${var.stage_name}"
    },
    var.tags
  )
}
