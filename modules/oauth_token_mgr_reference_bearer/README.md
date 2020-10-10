This is a module for oauth token manager with the `org.sourceid.oauth20.token.plugin.impl.ReferenceBearerAccessTokenManagementPlugin` implementation.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| pingfederate | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| expanded\_scopes | Expand Scope Groups | `string` | `"false"` | no |
| extended\_attributes | The extended attributes for the oauth token manager | `list(string)` | n/a | yes |
| instance\_id | The unique ID for the oauth token manager | `any` | n/a | yes |
| lifetime\_extention\_threshold | Lifetime Extension Threshold Percentage | `string` | `"30"` | no |
| lifetime\_policy | Lifetime Extension Policy | `string` | `"ALL"` | no |
| maximum\_token\_lifetime | Maximum Token Lifetime | `string` | `""` | no |
| mode\_sync | Mode for Synchronous RPC | `string` | `"3"` | no |
| name | The name for the oauth token manager | `any` | n/a | yes |
| rpc\_timeout | RPC Timeout | `string` | `"500"` | no |
| token\_length | The Token Length | `string` | `"28"` | no |
| token\_lifetime | The Token Lifetime | `string` | `"120"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
