variable "pingfederate_version" {
  description = "Target PingFederate Version"
  default     = "10.0"
  type        = string

  validation {
    condition     = length(regexall("10.[0-2]", var.pingfederate_version)) > 0
    error_message = "The pingfederate_version must be either '10.0', '10.1', '10.2'."
  }
}

variable "name" {
  description = "The name for the oauth token manager"
}

variable "instance_id" {
  description = "The unique ID for the oauth token manager"
  default     = null
}

variable "extended_attributes" {
  description = "The extended attributes for the oauth token manager"
  type        = list(string)
  default     = []
}

variable "token_lifetime" {
  description = "Defines how long, in minutes, an access token is valid"
  default     = 120
  type        = number
}

variable "use_centralized_signing_key" {
  description = "Select this option to use a centralized key when signing JWTs using an RSA-based or EC-based algorithm"
  default     = false
  type        = bool
}

variable "jws_algorithm" {
  description = "The HMAC or signing algorithm used to protect the integrity of the token"
  default     = null
  type        = string
}

variable "active_symmetric_key_id" {
  description = "The Key ID of the key to use when producing JWTs using an HMAC-based algorithm"
  default     = null
  type        = string
}

variable "active_signing_certificate_key_id" {
  description = "The Key ID of the key pair and certificate to use when producing JWTs using an RSA-based or EC-based algorithm"
  default     = null
  type        = string
}

variable "jwe_algorithm" {
  description = "The algorithm used to encrypt or otherwise determine the value of the content encryption key"
  default     = null
  type        = string
}

variable "jwe_content_encryption_algorithm" {
  description = "The content encryption algorithm used to perform authenticated encryption on the plaintext payload of the token"
  default     = null
  type        = string
}

variable "active_symmetric_encryption_key_id" {
  description = "The Key ID of the key to use when using a symmetric encryption algorithm"
  default     = null
  type        = string
}

variable "asymmetric_encryption_key" {
  description = "An asymmetric encryption public key, which can be in either JWK format or a certificate"
  default     = null
  type        = string
}

variable "asymmetric_encryption_jwks_url" {
  description = "The HTTPS URL of a JSON Web Key Set endpoint that has public key(s) for encryption"
  default     = null
  type        = string
}

variable "include_key_id_header_parameter" {
  description = "Indicates whether the Key ID (kid) header parameter will be included in the signature header of the token, which can help identify the appropriate key during verification"
  default     = true
  type        = bool
}

variable "include_x509_thumbprint_header_parameter" {
  description = "Indicates whether the X"
  default     = false
  type        = bool
}

variable "default_jwks_url_cache_duration" {
  description = "The default time in minutes to cache the content of the Asymmetric Encryption JWKS URL, which will be used when no cache directives are included or they indicate that the content has already expired"
  default     = 720
  type        = number
}

variable "include_jwe_key_id_header_parameter" {
  description = "Indicates whether the Key ID (kid) header parameter will be included in the encryption header of the token, which can help identify the appropriate key during decryption"
  default     = true
  type        = bool
}

variable "include_jwe_x509_thumbprint_header_parameter" {
  description = "Indicates whether the X"
  default     = "false"
  type        = string
}

variable "client_id_claim_name" {
  description = "The name of the JWT claim used to represent the OAuth Client ID (omitted, if blank)"
  default     = "client_id"
  type        = string
}

variable "scope_claim_name" {
  description = "The name of the JWT claim used to represent the scope of the grant (omitted, if blank)"
  default     = "scope"
  type        = string
}

variable "space_delimit_scope_values" {
  description = "Select checkbox to indicate that multiple scope strings will be delimited by spaces rather than represented as a JSON array"
  default     = true
  type        = bool
}

variable "issuer_claim_value" {
  description = "Indicates the value of the Issuer (iss) claim in the JWT (omitted, if blank)"
  default     = null
  type        = string
}

variable "audience_claim_value" {
  description = "Indicates the value of the Audience (aud) claim in the JWT (omitted, if blank)"
  default     = null
  type        = string
}

variable "jwt_id_claim_length" {
  description = "Indicates the number of characters of the JWT ID (jti) claim in the JWT (omitted, if zero)"
  default     = 0
  type        = number
}

variable "access_grant_guid_claim_name" {
  description = "The name of the JWT claim used to carry the persistent access grant GUID (omitted, if blank)"
  default     = null
  type        = string
}

variable "jwks_endpoint_path" {
  description = "Path on the PingFederate server to publish a JSON Web Key Set with the keys/certificates that can be used for signature verification"
  default     = null
  type        = string
}

variable "jwks_endpoint_cache_duration" {
  description = "How long, in minutes, to tell clients that they can cache the content from the JWKS Endpoint Path"
  default     = 720
  type        = number
}

variable "publish_key_id_x509_url" {
  description = "Indicates whether the certificates will be made accessible by Key ID at https://<pf_host>:<port>/ext/oauth/x509/kid?v=<id>"
  default     = "false"
  type        = string
}

variable "publish_thumbprint_x509_url" {
  description = "Indicates whether the certificates will be made accessible by certificate thumbprint at https://<pf_host>:<port>/ext/oauth/x509/x5t?v=<base64url encoded SHA-1 thumbprint>"
  default     = false
  type        = bool
}

variable "expand_scope_groups" {
  description = "Expand scope groups into their corresponding scopes in the Access Token contents and introspection response"
  default     = false
  type        = bool
}

variable "type_header_value" {
  description = "Indicates the value of the Type (typ) header  in the JWT (omitted, if blank)"
  default     = null
  type        = string
}

variable "symmetric_keys" {
  description = "A group of keys for use with symmetric encryption and MAC algorithms."
  type = list(object({
    key_id   = string
    key      = string
    encoding = string
  }))
  default = []
}

variable "certificates" {
  description = "A group of certificates and their corresponding public/private key pairs for use with signatures"
  type = list(object({
    key_id      = string
    certificate = string
  }))
}
