# IDP Adapter - Html Form Adapter

This is a module for idp HTML Form IDP Adapter with the `com.pingidentity.adapters.htmlform.idp.HtmlFormIdpAuthnAdapter` implementation.

## Usage

```hcl
module "example" {
  source                           = "git@github.com:iwarapter/pingfederate-terraform-modules//modules/idp_html_form_idp_adapter"
  password_credential_validator_id = "example"
  name                             = "example"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| pingfederate | 0.0.19 |

## Providers

| Name | Version |
|------|---------|
| pingfederate | 0.0.19 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_unlock | Allows users with a locked account to unlock it using the self-service password reset type | `bool` | `false` | no |
| account\_unlock\_template | HTML template (in <pf\_home>/server/default/conf/template) rendered when a user's account is sucessfully unlocked | `string` | `"account-unlock.html"` | no |
| allow\_password\_changes | Allows users to change their password using this adapter. | `bool` | `false` | no |
| allow\_username\_edits\_during\_chaining | Allow users to edit the pre-populated username field in the login form | `bool` | `false` | no |
| attribute\_contract\_fulfillment | Attribute contract fulfillment mapping for the IDP adapter | <pre>map(object({<br>    source_type = string<br>    value       = string<br>  }))</pre> | <pre>{<br>  "policy.action": {<br>    "source_type": "ADAPTER",<br>    "value": "policy.action"<br>  },<br>  "username": {<br>    "source_type": "ADAPTER",<br>    "value": "username"<br>  }<br>}</pre> | no |
| bypass\_external\_validation | Whether to bypass validation on creation/update (PF 10+) | `bool` | `false` | no |
| captcha\_for\_authentication | CAPTCHA can be enabled for the login form to prevent automated attacks | `bool` | `false` | no |
| captcha\_for\_password\_change | CAPTCHA can be enabled for the password change form to prevent automated attacks | `bool` | `false` | no |
| captcha\_for\_password\_reset | CAPTCHA can be enabled for password reset and account unlock features to prevent automated attacks | `bool` | `false` | no |
| captcha\_for\_username\_recovery | CAPTCHA can be enabled for username recovery features to prevent automated attacks | `bool` | `false` | no |
| challenge\_retries | Number of failed user authentications after which the PingFederate account locking service blocks future attempts. | `number` | `3` | no |
| change\_password\_email\_notification | Send users a notification upon a password change. | `bool` | `false` | no |
| change\_password\_email\_template | HTML email template (in <pf\_home>/server/default/conf/template/mail-notifications) used to send a changing password email | `string` | `"message-template-end-user-password-change.html"` | no |
| change\_password\_message\_template | HTML template (in <pf\_home>/server/default/conf/template) to render when a user is being redirected after successfully changing their password | `string` | `"html.form.message.template.html"` | no |
| change\_password\_policy\_contract | The policy contract to use for change password. Selecting a policy contract will enable usage of Authentication Policy during password change. | `string` | `""` | no |
| change\_password\_template | HTML template (in <pf\_home>/server/default/conf/template) to render for a user to change their password | `string` | `"html.form.change.password.template.html"` | no |
| enable\_remember\_my\_username | Allows users to store their username as a cookie when authenticating with this adapter. | `bool` | `false` | no |
| enable\_this\_is\_my\_device | Allows users to indicate whether their device is shared or private. | `bool` | `false` | no |
| enable\_username\_recovery | Allow users to get their username from an email | `bool` | `false` | no |
| expiring\_password\_warning\_template | HTML template (in <pf\_home>/server/default/conf/template) to warn the user about approaching password expiry day | `string` | `"html.form.password.expiring.notification.template.html"` | no |
| extended\_attributes | A list of additional attributes that can be returned by the IdP adapter. The extended attributes are only used if the adapter supports them. | <pre>list(object({<br>    name      = string<br>    pseudonym = bool<br>    masked    = bool<br>  }))</pre> | `[]` | no |
| local\_identity\_profile | Optionally associate this instance with a Local Identity Profile | `string` | `null` | no |
| login\_challenge\_template | HTML template (in <pf\_home>/server/default/conf/template) to render during a strong authentication as a second step | `string` | `"html.form.login.challenge.template.html"` | no |
| login\_template | HTML template (in <pf\_home>/server/default/conf/template) to render for login | `string` | `"html.form.login.template.html"` | no |
| logout\_path | Path on the PingFederate server to invoke the HTML Form Adapter logout functionality | `string` | `null` | no |
| logout\_redirect | A fully qualified URL, usually at the SP, to which a user will be redirected after logout (applicable only when Logout Path is set above) | `string` | `null` | no |
| logout\_template | HTML template (in <pf\_home>/server/default/conf/template) to render after logout (applicable only when Logout Path is set above and if Logout Redirect is not provided) | `string` | `"idp.logout.success.page.template.html"` | no |
| name | The name for the idp adapter | `string` | n/a | yes |
| notification\_publisher | Optionally associate this instance with a notification delivery mechanism | `string` | `null` | no |
| otp\_length | For self-service password reset, the number of characters used in one-time passwords | `number` | `8` | no |
| otp\_time\_to\_live | For self-service password reset, the validity period (in minutes) for password reset tokens | `number` | `10` | no |
| password\_credential\_validator\_ids | The ID for the password credential validator | `list(string)` | n/a | yes |
| password\_management\_system | A fully-qualified URL to your password management system where users can change their password | `string` | `""` | no |
| password\_management\_system\_message\_template | HTML template (in <pf\_home>/server/default/conf/template) to render when a user is being redirected to the password management system to change their password | `string` | `"html.form.message.template.html"` | no |
| password\_reset\_code\_template | HTML template (in <pf\_home>/server/default/conf/template) rendered to prompt a user for a code challenge during password reset | `string` | `"forgot-password-resume.html"` | no |
| password\_reset\_error\_template | HTML template (in <pf\_home>/server/default/conf/template) to render when an error occurs during password reset | `string` | `"forgot-password-error.html"` | no |
| password\_reset\_policy\_contract | The policy contract to use for password reset | `string` | `null` | no |
| password\_reset\_success\_template | HTML template (in <pf\_home>/server/default/conf/template) rendered upon a successful password reset | `string` | `"forgot-password-success.html"` | no |
| password\_reset\_template | HTML template (in <pf\_home>/server/default/conf/template) rendered to prompt a user to define their new password during password reset | `string` | `"forgot-password-change.html"` | no |
| password\_reset\_type | Select the method to use for self-service password reset | `string` | `"NONE"` | no |
| password\_reset\_username\_template | HTML template (in <pf\_home>/server/default/conf/template) rendered to prompt a user for their username during password reset | `string` | `"forgot-password.html"` | no |
| ping\_id\_properties | For self-service password reset using PingID, upload your pingid | `string` | `null` | no |
| post\_password\_change\_re\_authentication\_delay | Amount of time (milliseconds) to wait after a successful password change before automatically re-authenticating the user against the Password Credential Validator using the new password | `number` | `0` | no |
| remember\_my\_username\_lifetime | Number of days that the username is stored | `number` | `30` | no |
| require\_verified\_email | The user’s email address has to be verified before a password reset, account unlock or username recovery email is sent | `bool` | `false` | no |
| revoke\_sessions\_after\_password\_change\_or\_reset | Revokes a user's authentication sessions after a password change or reset is completed by this adapter | `bool` | `false` | no |
| session\_max\_timeout | Session Max Timeout (in minutes). | `number` | `480` | no |
| session\_state | Determines how state is maintained within one adapter or between different adapter instances | `string` | `"None"` | no |
| session\_timeout | Session Idle Timeout (in minutes) | `number` | `60` | no |
| show\_password\_expiring\_warning | Show a warning message to the user on login about an approaching password expiration. | `bool` | `false` | no |
| snooze\_interval\_for\_expiring\_password\_warning | Amount of time (in hours) to wait after a expiring password warning before the next warning | `number` | `24` | no |
| this\_is\_my\_device\_lifetime | Number of days that the user's 'This is My Device' selection is stored | `number` | `30` | no |
| threshold\_for\_expiring\_password\_warning | Threshold (in days) to start warning the user about approaching password expiry day | `number` | `7` | no |
| track\_authentication\_time | Determines if the time each end user authenticated is tracked | `bool` | `true` | no |
| username\_recovery\_email\_template | HTML email template (in <pf\_home>/server/default/conf/template/mail-notifications) used to send a username recovery email | `string` | `"message-template-username-recovery.html"` | no |
| username\_recovery\_info\_template | HTML template (in <pf\_home>/server/default/conf/template) rendered to prompt a user to check their email for their recovered username | `string` | `"username.recovery.info.template.html"` | no |
| username\_recovery\_template | HTML template (in <pf\_home>/server/default/conf/template) rendered to prompt a user for their email address during username recovery | `string` | `"username.recovery.template.html"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the idp adapter resource |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
