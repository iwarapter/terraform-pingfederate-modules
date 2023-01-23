terraform {
  required_providers {
    pingfederate = {
      source  = "iwarapter/pingfederate"
      version = "~> 0.1.1"
    }
  }
}


resource "pingfederate_oauth_access_token_manager" "manager" {
  instance_id = var.instance_id
  name        = var.name

  plugin_descriptor_ref {
    id = "org.sourceid.oauth20.token.plugin.impl.ReferenceBearerAccessTokenManagementPlugin"
  }

  configuration {
    fields {
      name  = "Token Length"
      value = var.token_length
    }

    fields {
      name  = "Token Lifetime"
      value = var.token_lifetime
    }

    fields {
      name  = "Lifetime Extension Policy"
      value = var.lifetime_extension_policy
    }

    fields {
      name  = "Maximum Token Lifetime"
      value = var.maximum_token_lifetime
    }

    fields {
      name  = "Lifetime Extension Threshold Percentage"
      value = var.lifetime_extension_threshold_percentage
    }

    fields {
      name  = "Mode for Synchronous RPC"
      value = var.mode_for_synchronous_rpc
    }

    fields {
      name  = "RPC Timeout"
      value = var.rpc_timeout
    }

    fields {
      name  = "Expand Scope Groups"
      value = var.expand_scope_groups
    }
  }

  attribute_contract {
    extended_attributes = var.extended_attributes
  }
}
