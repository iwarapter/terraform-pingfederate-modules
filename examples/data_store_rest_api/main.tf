module "rest_api_data_source" {
  source = "../../modules/data_store_rest_api"

  name    = "Example Rest API Data Store"
  baseURL = "https://api.server.com/api/v1/end-point"

  api_attributes = {
    attr1 = {
      local = "variable1",
      json  = "/variable1",
    }
    attr2 = {
      local = "variable2",
      json  = "/variable2",
    }
    attr3 = {
      local = "variable3",
      json  = "/variable3",
    }
  }

  http_request_headers = {
    header1 = {
      header_name  = "Cache-Control",
      header_value = "no-cache",
    }
    header2 = {
      header_name  = "Accept",
      header_value = "application/json",
    }
    header3 = {
      header_name  = "Host",
      header_value = "api.server.com",
    }
  }


}
