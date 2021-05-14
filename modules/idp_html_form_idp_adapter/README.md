# IDP Adapter - Html Form Adapter

This is a module for idp HTML Form IDP Adapter with the `com.pingidentity.adapters.htmlform.idp.HtmlFormIdpAuthnAdapter` implementation.

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
| allow\_password\_changes | Allows users to change their password using this adapter. | `bool` | `false` | no |
| attribute\_contract\_fulfillment | Attribute contract fulfillment mapping for the IDP adapter | <pre>map(object({<br>    source_type = string<br>    value       = string<br>  }))</pre> | <pre>{<br>  "policy.action": {<br>    "source_type": "ADAPTER",<br>    "value": "policy.action"<br>  },<br>  "username": {<br>    "source_type": "ADAPTER",<br>    "value": "username"<br>  }<br>}</pre> | no |
| bypass\_external\_validation | Whether to bypass validation on creation/update (PF 10+) | `bool` | `false` | no |
| challenge\_retries | Number of failed user authentications after which the PingFederate account locking service blocks future attempts. | `number` | `3` | no |
| change\_password\_email\_notification | Send users a notification upon a password change. | `bool` | `false` | no |
| core\_attributes | A list of IdP adapter attributes that correspond to the attributes exposed by the IdP adapter type. | <pre>list(object({<br>    name      = string<br>    pseudonym = bool<br>    masked    = bool<br>  }))</pre> | <pre>[<br>  {<br>    "masked": false,<br>    "name": "policy.action",<br>    "pseudonym": false<br>  },<br>  {<br>    "masked": false,<br>    "name": "username",<br>    "pseudonym": true<br>  }<br>]</pre> | no |
| enable\_remember\_my\_username | Allows users to store their username as a cookie when authenticating with this adapter. | `bool` | `false` | no |
| enable\_this\_is\_my\_device | Allows users to indicate whether their device is shared or private. | `bool` | `false` | no |
| extended\_attributes | A list of additional attributes that can be returned by the IdP adapter. The extended attributes are only used if the adapter supports them. | <pre>list(object({<br>    name      = string<br>    pseudonym = bool<br>    masked    = bool<br>  }))</pre> | `[]` | no |
| name | The name for the idp adapter | `string` | n/a | yes |
| notification\_publisher | Optionally associate this instance with a notification delivery mechanism. | `string` | `null` | no |
| password\_credential\_validator\_id | The ID for the password credential validator | `string` | n/a | yes |
| password\_reset\_type | Select the method to use for self-service password reset. | `string` | `"NONE"` | no |
| session\_max\_timeout | Session Max Timeout (in minutes). Leave blank for indefinite sessions. Ignored if 'None' is selected for Session State. | `number` | `480` | no |
| session\_state | Determines how state is maintained within one adapter or between different adapter instances. | `string` | `"None"` | no |
| session\_timeout | Session Idle Timeout (in minutes). If left blank the timeout will be the Session Max Timeout. Ignored if 'None' is selected for Session State. | `number` | `60` | no |
| show\_password\_expiring\_warning | Show a warning message to the user on login about an approaching password expiration. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the idp adapter resource |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
