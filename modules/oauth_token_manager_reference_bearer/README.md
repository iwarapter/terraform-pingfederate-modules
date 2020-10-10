This is a module for oauth token manager with the `org.sourceid.oauth20.token.plugin.impl.ReferenceBearerAccessTokenManagementPlugin` implementation.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| pingfederate | ~> 0.0.5 |

## Providers

| Name | Version |
|------|---------|
| pingfederate | ~> 0.0.5 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| expand\_scope\_groups | Expand scope groups into their corresponding scopes in the Access Token contents and introspection response. By default this is disabled. | `string` | `"false"` | no |
| extended\_attributes | The extended attributes for the oauth token manager | `list(string)` | `[]` | no |
| instance\_id | The unique ID for the oauth token manager | `any` | `null` | no |
| lifetime\_extension\_policy | Dictates which tokens are eligible for lifetime extension. Similar to a session inactivity timeout, the lifetime period of an access token can be reset each time the token is validated at the AS (subject to the values defined for the Lifetime Extension Threshold Percentage and the Maximum Token Lifetime). | `string` | `"NONE"` | no |
| lifetime\_extension\_threshold\_percentage | Defines the percentage of a token's lifetime remaining before the lifetime is actually extended, which can improve cluster performance. | `string` | `"30"` | no |
| maximum\_token\_lifetime | (Optional) Defines an absolute maximum token lifetime, in minutes, for use with the Lifetime Extension Policy. An access token's lifetime cannot be extended beyond this setting. | `string` | `""` | no |
| mode\_for\_synchronous\_rpc | For clustered deployments, indicates how many responses to wait for when making synchronous RPC calls. When 'Majority of Nodes' is selected, the server waits for the majority of recipients to respond. When 'All Nodes' is selected, it waits for all recipients to respond. | `string` | `"3"` | no |
| name | The name for the oauth token manager | `any` | n/a | yes |
| rpc\_timeout | For clustered deployments, indicates how long, in milliseconds, the server waits before timing out unresponsive RPC invocations. | `string` | `"500"` | no |
| token\_length | Defines how many alphanumeric characters make up an access token. Note that the first 4 characters are reserved and don't count towards the randomness of the token. | `string` | `"28"` | no |
| token\_lifetime | Defines how long, in minutes, an access token is valid. | `string` | `"120"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the oauth token manager resource |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
