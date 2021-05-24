# OAuth Token Manager - Reference Bearer

This is a module for oauth token manager with the `org.sourceid.oauth20.token.plugin.impl.ReferenceBearerAccessTokenManagementPlugin` implementation.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| pingfederate | ~> 0.0.16 |

## Providers

| Name | Version |
|------|---------|
| pingfederate | ~> 0.0.16 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_grant\_guid\_claim\_name | The name of the JWT claim used to carry the persistent access grant GUID (omitted, if blank) | `string` | `null` | no |
| active\_signing\_certificate\_key\_id | The Key ID of the key pair and certificate to use when producing JWTs using an RSA-based or EC-based algorithm | `string` | `null` | no |
| active\_symmetric\_encryption\_key\_id | The Key ID of the key to use when using a symmetric encryption algorithm | `string` | `null` | no |
| active\_symmetric\_key\_id | The Key ID of the key to use when producing JWTs using an HMAC-based algorithm | `string` | `null` | no |
| asymmetric\_encryption\_jwks\_url | The HTTPS URL of a JSON Web Key Set endpoint that has public key(s) for encryption | `string` | `null` | no |
| asymmetric\_encryption\_key | An asymmetric encryption public key, which can be in either JWK format or a certificate | `string` | `null` | no |
| audience\_claim\_value | Indicates the value of the Audience (aud) claim in the JWT (omitted, if blank) | `string` | `null` | no |
| certificates | A group of certificates and their corresponding public/private key pairs for use with signatures | <pre>list(object({<br>    key_id      = string<br>    certificate = string<br>  }))</pre> | n/a | yes |
| client\_id\_claim\_name | The name of the JWT claim used to represent the OAuth Client ID (omitted, if blank) | `string` | `"client_id"` | no |
| default\_jwks\_url\_cache\_duration | The default time in minutes to cache the content of the Asymmetric Encryption JWKS URL, which will be used when no cache directives are included or they indicate that the content has already expired | `number` | `720` | no |
| expand\_scope\_groups | Expand scope groups into their corresponding scopes in the Access Token contents and introspection response | `bool` | `false` | no |
| extended\_attributes | The extended attributes for the oauth token manager | `list(string)` | `[]` | no |
| include\_jwe\_key\_id\_header\_parameter | Indicates whether the Key ID (kid) header parameter will be included in the encryption header of the token, which can help identify the appropriate key during decryption | `bool` | `true` | no |
| include\_jwe\_x509\_thumbprint\_header\_parameter | Indicates whether the X | `string` | `"false"` | no |
| include\_key\_id\_header\_parameter | Indicates whether the Key ID (kid) header parameter will be included in the signature header of the token, which can help identify the appropriate key during verification | `bool` | `true` | no |
| include\_x509\_thumbprint\_header\_parameter | Indicates whether the X | `bool` | `false` | no |
| instance\_id | The unique ID for the oauth token manager | `any` | `null` | no |
| issuer\_claim\_value | Indicates the value of the Issuer (iss) claim in the JWT (omitted, if blank) | `string` | `null` | no |
| jwe\_algorithm | The algorithm used to encrypt or otherwise determine the value of the content encryption key | `string` | `null` | no |
| jwe\_content\_encryption\_algorithm | The content encryption algorithm used to perform authenticated encryption on the plaintext payload of the token | `string` | `null` | no |
| jwks\_endpoint\_cache\_duration | How long, in minutes, to tell clients that they can cache the content from the JWKS Endpoint Path | `number` | `720` | no |
| jwks\_endpoint\_path | Path on the PingFederate server to publish a JSON Web Key Set with the keys/certificates that can be used for signature verification | `string` | `null` | no |
| jws\_algorithm | The HMAC or signing algorithm used to protect the integrity of the token | `string` | `null` | no |
| jwt\_id\_claim\_length | Indicates the number of characters of the JWT ID (jti) claim in the JWT (omitted, if zero) | `number` | `0` | no |
| name | The name for the oauth token manager | `any` | n/a | yes |
| pingfederate\_version | Target PingFederate Version | `string` | `"10.0"` | no |
| publish\_key\_id\_x509\_url | Indicates whether the certificates will be made accessible by Key ID at https://<pf\_host>:<port>/ext/oauth/x509/kid?v=<id> | `string` | `"false"` | no |
| publish\_thumbprint\_x509\_url | Indicates whether the certificates will be made accessible by certificate thumbprint at https://<pf\_host>:<port>/ext/oauth/x509/x5t?v=<base64url encoded SHA-1 thumbprint> | `bool` | `false` | no |
| scope\_claim\_name | The name of the JWT claim used to represent the scope of the grant (omitted, if blank) | `string` | `"scope"` | no |
| space\_delimit\_scope\_values | Select checkbox to indicate that multiple scope strings will be delimited by spaces rather than represented as a JSON array | `bool` | `true` | no |
| symmetric\_keys | A group of keys for use with symmetric encryption and MAC algorithms. | <pre>list(object({<br>    key_id   = string<br>    key      = string<br>    encoding = string<br>  }))</pre> | `[]` | no |
| token\_lifetime | Defines how long, in minutes, an access token is valid | `number` | `120` | no |
| type\_header\_value | Indicates the value of the Type (typ) header  in the JWT (omitted, if blank) | `string` | `null` | no |
| use\_centralized\_signing\_key | Select this option to use a centralized key when signing JWTs using an RSA-based or EC-based algorithm | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the oauth token manager resource |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
