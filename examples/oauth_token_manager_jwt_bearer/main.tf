
module "jwt_bearer" {
  source                            = "../../modules/oauth_token_manager_jwt_bearer"
  name                              = "example"
  instance_id                       = "example"
  jws_algorithm                     = "PS256"
  active_signing_certificate_key_id = "example"

  extended_attributes = ["foo"]
  symmetric_keys = [{
    key_id   = "foo"
    key      = random_password.jwt_key.result
    encoding = null
  }]
  certificates = [{
    key_id      = "example"
    certificate = pingfederate_keypair_signing.signer.id
  }]
}

resource "random_password" "jwt_key" {
  length  = 256
  special = false
  lower   = false
  upper   = false
}

resource "pingfederate_keypair_signing" "signer" {
  city              = "Test"
  common_name       = "Test"
  country           = "GB"
  key_algorithm     = "RSA"
  key_size          = 2048
  organization      = "Test"
  organization_unit = "Test"
  state             = "Test"
  valid_days        = 365
}
