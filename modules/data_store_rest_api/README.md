# Data Source - REST API Adapter

This is a module for Data Source - REST API Adapter using the plugin `com.pingidentity.pf.datastore.other.RestDataSourceDriver` implementation.

## Usage

```hcl
module "example" {
  source                           = "git@github.com:iwarapter/pingfederate-terraform-modules//modules/idp_html_form_idp_adapter"
  password_credential_validator_id = "example"
  name                             = "example"
}
