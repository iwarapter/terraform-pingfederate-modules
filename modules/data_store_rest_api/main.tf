terraform {
  required_providers {
    pingfederate = {
      source  = "iwarapter/pingfederate"
      version = "~> 0.0.16"
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
      value = var.auth_method
    }
    fields {
      name  = "Enable HTTPS Hostname Verification"
      value = var.https_hostname_verification
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
      value = var.max_payload
    }
    fields {
      name  = "Retry Request"
      value = var.retry_request
    }
    fields {
      name  = "Maximum Retries Limit"
      value = var.max_retry_request
    }
    fields {
      name  = "Retry Error Codes"
      value = var.retry_error_code
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
      value = var.oauth_scopes
    }
    fields {
      name  = "OAuth Token Endpoint"
      value = var.token_endpoint
    }
    fields {
      name  = "Username"
      value = var.basic_username
    }
    fields {
      name  = "Password"
      value = var.basic_password
    }
    fields {
      name  = "Test Connection URL"
      value = var.test_url
    }
    tables {
      name = "Base URLs and Tags"
      rows {
        default_row = true
        fields {
          name  = "Base URL"
          value = var.baseURL
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
        for_each = var.api_attributes
        content {
          fields {
            name  = "Local Attribute"
            value = var.api_attributes[rows.key].local
          }
          fields {
            name  = "JSON Response Attribute Path"
            value = var.api_attributes[rows.key].json
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
            value = var.http_request_headers[rows.key].header_name
          }
          fields {
            name  = "Header Value"
            value = var.http_request_headers[rows.key].header_value
          }
        }

      }
    }
  }
}
