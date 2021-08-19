module "rest_api_data_source" {
  source = "../../modules/data_store_rest_api"

  name     = "Example Rest API Data Store"
  base_url = "https://api.server.com/api/v1/end-point"

  attributes = {
    foo0 = "/foo0"
    foo1 = "/foo1"
    foo2 = "/foo2"

  }

  http_request_headers = {
    Cache-Control = "no-cache"
    Accept        = "application/json"
    Host          = "api.server.com"

  }

}
