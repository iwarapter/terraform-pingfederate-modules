terraform {
  required_version = ">= 0.14"
  required_providers {
    pingfederate = {
      source  = "iwarapter/pingfederate"
      version = "~> 0.1.1"
    }
  }
}

resource "pingfederate_custom_data_store" "rest_api_data_source" {
  name = var.name
  plugin_descriptor_ref {
    id = "com.pingidentity.pf.datastore.other.RestDataSourceDriver"
  }
  configuration {
    fields {
      name  = "Authentication Method"
      value = var.authentication_method
    }
    fields {
      name  = "Enable HTTPS Hostname Verification"
      value = var.enable_https_hostname_verification
    }
    fields {
      name  = "Read Timeout (ms)"
      value = var.read_timeout
    }
    fields {
      name  = "Connection Timeout (ms)"
      value = var.connection_timeout
    }
    fields {
      name  = "Max Payload Size (KB)"
      value = var.max_payload_size
    }
    fields {
      name  = "Retry Request"
      value = var.retry_request
    }
    fields {
      name  = "Maximum Retries Limit"
      value = var.maximum_retries_limit
    }
    fields {
      name  = "Retry Error Codes"
      value = var.retry_error_codes
    }
    fields {
      name  = "Client ID"
      value = var.client_id
    }
    fields {
      name  = "Client Secret"
      value = var.client_secret
    }
    fields {
      name  = "OAuth Scope"
      value = var.oauth_scope
    }
    fields {
      name  = "OAuth Token Endpoint"
      value = var.oauth_token_endpoint
    }
    fields {
      name  = "Username"
      value = var.username
    }
    fields {
      name  = "Password"
      value = var.password
    }
    fields {
      name  = "Test Connection URL"
      value = var.test_connection_url
    }
    tables {
      name = "Base URLs and Tags"
      rows {
        default_row = true
        fields {
          name  = "Base URL"
          value = var.base_url
        }
        fields {
          name  = "Tags"
          value = ""
        }
      }
    }
    tables {
      name = "Attributes"
      dynamic "rows" {
        for_each = var.attributes
        content {
          fields {
            name  = "Local Attribute"
            value = rows.key
          }
          fields {
            name  = "JSON Response Attribute Path"
            value = rows.value
          }
        }

      }
    }
    tables {
      name = "HTTP Request Headers"
      dynamic "rows" {
        for_each = var.http_request_headers
        content {
          fields {
            name  = "Header Name"
            value = rows.key
          }
          fields {
            name  = "Header Value"
            value = rows.value
          }
        }

      }
    }
  }
}
