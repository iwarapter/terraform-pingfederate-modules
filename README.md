# PingFederate Terraform Modules

This is a collection of module for PingFederate designed to wrap the specific class implementations for various resources.

## Usage
```hcl
module "example" {
  source              = "git@github.com:iwarapter/pingfederate-terraform-modules//modules/oauth_token_manager_reference_bearer"
  instance_id         = "example"
  name                = "example"
  extended_attributes = ["sub"]
}
```

## Available Modules

- IDP Adapters
    - HTML Form IdP Adapter

 - OAuth Access Token Managers
    - Internally Managed Reference Tokens
