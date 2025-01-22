#################
## Dynamodb Table
#################

resource "aws_dynamodb_table" "this" {
  name             = var.table_name
  billing_mode     = var.billing_mode
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  hash_key         = var.hash_key
  range_key        = var.range_key
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  dynamic "attribute" {
    for_each = var.range_key != null ? [var.range_key] : []
    content {
      name = attribute.value
      type = var.range_key_type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name            = global_secondary_index.value.name
      hash_key        = global_secondary_index.value.hash_key
      range_key       = lookup(global_secondary_index.value, "range_key", null)
      projection_type = global_secondary_index.value.projection_type

      dynamic "non_key_attributes" {
        for_each = contains(keys(global_secondary_index.value), "non_key_attributes") ? [global_secondary_index.value.non_key_attributes] : []
        content  = non_key_attributes.value
      }

      read_capacity  = global_secondary_index.value.read_capacity
      write_capacity = global_secondary_index.value.write_capacity
    }
  }

  dynamic "ttl" {
    for_each = var.enable_ttl ? [var.ttl_attribute] : []
    content {
      attribute_name = ttl.value
      enabled        = true
    }
  }

  tags = merge(
    {
      "Name" = var.table_name
    },
    var.tags
  )
}

###############################
## App Autoscalling Read Target
###############################


resource "aws_appautoscaling_target" "read_target" {
  count = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? 1 : 0

  max_capacity       = var.read_autoscaling_max_capacity
  min_capacity       = var.read_autoscaling_min_capacity
  resource_id        = "table/${aws_dynamodb_table.this.name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

################################
## App Autoscalling Write Target
################################

resource "aws_appautoscaling_target" "write_target" {
  count = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? 1 : 0

  max_capacity       = var.write_autoscaling_max_capacity
  min_capacity       = var.write_autoscaling_min_capacity
  resource_id        = "table/${aws_dynamodb_table.this.name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

###############################
## App Autoscalling Read Policy
###############################

resource "aws_appautoscaling_policy" "read_policy" {
  count = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? 1 : 0

  name               = "${aws_dynamodb_table.this.name}-ReadScalingPolicy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.read_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.read_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.read_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.read_autoscaling_target_value
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }
    scale_in_cooldown  = var.read_autoscaling_scale_in_cooldown
    scale_out_cooldown = var.read_autoscaling_scale_out_cooldown
  }
}

###############################
## App Autoscalling Write Policy
###############################

resource "aws_appautoscaling_policy" "write_policy" {
  count = var.billing_mode == "PROVISIONED" && var.enable_autoscaling ? 1 : 0

  name               = "${aws_dynamodb_table.this.name}-WriteScalingPolicy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.write_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.write_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.write_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.write_autoscaling_target_value
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }
    scale_in_cooldown  = var.write_autoscaling_scale_in_cooldown
    scale_out_cooldown = var.write_autoscaling_scale_out_cooldown
  }
}
