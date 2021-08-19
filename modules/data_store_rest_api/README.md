# Data Source - REST API Adapter

This is a module for the Data Source, REST API Adapter using `com.pingidentity.pf.datastore.other.RestDataSourceDriver` implementation.

## Usage


``` hcl
module "rest_api_data_source" {
  source = "../../modules/data_store_rest_api"

  name     = "Example Rest API Data Store"
  base_url = "https://api.server.com/api/v1/end-point"

}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| pingfederate | ~> 0.0.16 |

## Providers

| Name | Version |
|------|---------|
| pingfederate | ~> 0.0.16 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Define attributes to expose from this data source. Each named attribute must include a path using JSON Pointer syntax (RFC 6901) from where it is retrieved in the response of the REST API. For example, a JSON Response Attribute Path of /age will return the value of a top-level JSON key called "age". Click 'Add a new row ...' to add multiple entries. | `map(string)` | n/a | yes |
| authentication\_method | Select the authentication method used to access the REST service. | `string` | `"None"` | no |
| base\_url | The base URL of the REST API service. | `string` | n/a | yes |
| client\_id | When using OAuth client credentials grant type, this specifies the ID of the client created in the REST service for authentication. | `string` | `null` | no |
| client\_secret | When using OAuth client credentials grant type, this specifies the secret of the client created in the REST service authentication. | `string` | `null` | no |
| connection\_timeout | Determines the timeout in milliseconds until a connection is established. A timeout value of zero is interpreted as an infinite timeout. A value of -1 will cause the OS level default to be used. | `string` | `"10000"` | no |
| enable\_https\_hostname\_verification | When SSL/TLS is used, this specifies whether to check if the hostname for the REST service matches the hostname in the certificate it presents. | `string` | `"true"` | no |
| http\_request\_headers | Define HTTP headers to include in the request. | `map(string)` | n/a | yes |
| max\_payload\_size | Defines the maximum allowed size in kilobytes of the returned JSON response payload. A value of zero is interpreted as an unrestricted payload size. | `string` | `"1024"` | no |
| maximum\_retries\_limit | Maximum number of retries attempted if API fails with error codes configured. | `string` | `"5"` | no |
| name | name of the datas source | `string` | n/a | yes |
| oauth\_scope | When using OAuth client credentials grant type, this specifies the space delimited authorization scope(s) requested from the authorization endpoint to access the REST API service. | `string` | `null` | no |
| oauth\_token\_endpoint | When using OAuth client credentials grant type, this specifies the authorization server token endpoint URL. | `string` | `null` | no |
| password | The password to use for basic authentication. | `string` | `null` | no |
| read\_timeout | Defines the socket timeout in milliseconds. A timeout value of zero is interpreted as an infinite timeout. A value of -1 will cause the OS level default to be used. | `string` | `"10000"` | no |
| retry\_error\_codes | Comma-separated list of error code values for API re-attempt e.g. 429, 503. | `string` | `"429"` | no |
| retry\_request | Retry user data retrieval request if API fails with error codes configured. | `string` | `"true"` | no |
| test\_connection\_url | Tests connectivity to the REST service based on the provided Test Connection URL | `string` | `null` | no |
| username | The username to use for basic authentication. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The resource ID for the data store |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
