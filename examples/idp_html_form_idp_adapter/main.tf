
module "html_form_adapter" {
  source                            = "../../modules/idp_html_form_idp_adapter"
  name                              = "example"
  password_credential_validator_ids = [pingfederate_password_credential_validator.example.id]
}

resource "pingfederate_password_credential_validator" "example" {
  name = "htmlFormAdapterExample"
  plugin_descriptor_ref {
    id = "org.sourceid.saml20.domain.SimpleUsernamePasswordCredentialValidator"
  }

  configuration {
    tables {
      name = "Users"
      rows {
        fields {
          name  = "Username"
          value = "bob"
        }

        sensitive_fields {
          name  = "Password"
          value = "demo2"
        }

        sensitive_fields {
          name  = "Confirm Password"
          value = "demo2"
        }

        fields {
          name  = "Relax Password Requirements"
          value = "true"
        }
      }
    }
  }
}
