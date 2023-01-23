terraform {
  required_providers {
    pingfederate = {
      source  = "iwarapter/pingfederate"
      version = "~> 0.1.1"
    }
  }
}

locals {
  isPF10_2 = length(regexall("10.[2]", var.pingfederate_version)) > 0
}
resource "pingfederate_oauth_access_token_manager" "manager" {
  name        = var.name
  instance_id = var.instance_id
  plugin_descriptor_ref {
    id = "com.pingidentity.pf.access.token.management.plugins.JwtBearerAccessTokenManagementPlugin"
  }

  configuration {
    tables {
      name = "Symmetric Keys"
      dynamic "rows" {
        for_each = toset(var.symmetric_keys)
        content {
          fields {
            name  = "Key ID"
            value = rows.value.key_id
          }
          sensitive_fields {
            name  = "Key"
            value = rows.value.key
          }
          fields {
            name  = "Encoding"
            value = rows.value.encoding
          }
        }
      }
    }
    tables {
      name = "Certificates"
      dynamic "rows" {
        for_each = toset(var.certificates)
        content {
          fields {
            name  = "Key ID"
            value = rows.value.key_id
          }
          fields {
            name  = "Certificate"
            value = rows.value.certificate
          }
        }
      }
    }
    fields {
      name  = "Token Lifetime"
      value = var.token_lifetime
    }

    dynamic "fields" {
      for_each = local.isPF10_2 ? [1] : []
      content {
        name  = "Use Centralized Signing Key"
        value = var.use_centralized_signing_key
      }
    }
    fields {
      name  = "JWS Algorithm"
      value = var.jws_algorithm
    }
    fields {
      name  = "Active Symmetric Key ID"
      value = var.active_symmetric_key_id
    }
    fields {
      name  = "Active Signing Certificate Key ID"
      value = var.active_signing_certificate_key_id
    }
    fields {
      name  = "JWE Algorithm"
      value = var.jwe_algorithm
    }
    fields {
      name  = "JWE Content Encryption Algorithm"
      value = var.jwe_content_encryption_algorithm
    }
    fields {
      name  = "Active Symmetric Encryption Key ID"
      value = var.active_symmetric_encryption_key_id
    }
    fields {
      name  = "Asymmetric Encryption Key"
      value = var.asymmetric_encryption_key
    }
    fields {
      name  = "Asymmetric Encryption JWKS URL"
      value = var.asymmetric_encryption_jwks_url
    }
    fields {
      name  = "Include Key ID Header Parameter"
      value = var.include_key_id_header_parameter
    }
    fields {
      name  = "Include X.509 Thumbprint Header Parameter"
      value = var.include_x509_thumbprint_header_parameter
    }
    fields {
      name  = "Default JWKS URL Cache Duration"
      value = var.default_jwks_url_cache_duration
    }
    fields {
      name  = "Include JWE Key ID Header Parameter"
      value = var.include_jwe_key_id_header_parameter
    }
    fields {
      name  = "Include JWE X.509 Thumbprint Header Parameter"
      value = var.include_jwe_x509_thumbprint_header_parameter
    }
    fields {
      name  = "Client ID Claim Name"
      value = var.client_id_claim_name
    }
    fields {
      name  = "Scope Claim Name"
      value = var.scope_claim_name
    }
    fields {
      name  = "Space Delimit Scope Values"
      value = var.space_delimit_scope_values
    }
    fields {
      name  = "Issuer Claim Value"
      value = var.issuer_claim_value
    }
    fields {
      name  = "Audience Claim Value"
      value = var.audience_claim_value
    }
    fields {
      name  = "JWT ID Claim Length"
      value = var.jwt_id_claim_length
    }
    fields {
      name  = "Access Grant GUID Claim Name"
      value = var.access_grant_guid_claim_name
    }
    fields {
      name  = "JWKS Endpoint Path"
      value = var.jwks_endpoint_path
    }
    fields {
      name  = "JWKS Endpoint Cache Duration"
      value = var.jwks_endpoint_cache_duration
    }
    fields {
      name  = "Publish Key ID X.509 URL"
      value = var.publish_key_id_x509_url
    }
    fields {
      name  = "Publish Thumbprint X.509 URL"
      value = var.publish_thumbprint_x509_url
    }
    fields {
      name  = "Expand Scope Groups"
      value = var.expand_scope_groups
    }

    dynamic "fields" {
      for_each = local.isPF10_2 ? [1] : []
      content {
        name  = "Type Header Value"
        value = var.type_header_value
      }
    }
  }

  attribute_contract {
    extended_attributes = var.extended_attributes
  }
}
