package test

import (
	"strings"
	"testing"

	"github.com/stretchr/testify/require"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/iwarapter/pingfederate-sdk-go/services/dataStores"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestDataStoreRestApi(t *testing.T) {
	// t.Parallel()

	client := dataStores.New(cfg)

	tests := []struct {
		testName             string
		name                 string
		baseURL              string
		api_attributes       map[string]string
		http_request_headers map[string]string
		expectedError        bool
		errorMessage         string
	}{
		{
			testName: "default deployment",
			name:     "test1",
			baseURL:  "https://foo.com/api/v1",
			api_attributes: map[string]string{
				"foo": "/foo",
			},
			http_request_headers: map[string]string{
				"Host": "api.server.com",
			},
		},
	}
	for _, tc := range tests {
		t.Run(tc.testName, func(t *testing.T) {

			terraformOptions := &terraform.Options{
				TerraformDir: "../modules/data_store_rest_api",

				Vars: map[string]interface{}{
					"name":                 tc.name,
					"baseURL":              tc.baseURL,
					"api_attributes":       tc.api_attributes,
					"http_request_headers": tc.http_request_headers,
				},
				NoColor: true,
			}

			if tc.expectedError {
				if _, err := terraform.InitAndApplyE(t, terraformOptions); err != nil {
					assert.Contains(t, err.Error(), tc.errorMessage)
				}
			} else {
				defer terraform.Destroy(t, terraformOptions)
				terraform.InitAndApply(t, terraformOptions)
				dsId := terraform.Output(t, terraformOptions, "id")
				require.NotEmpty(t, dsId)
				dsId = strings.Trim(dsId, `"`)
				ds, _, err := client.GetCustomDataStore(&dataStores.GetCustomDataStoreInput{Id: dsId})
				require.Nil(t, err)
				require.NotNil(t, ds)

				assert.Equal(t, *ds.Name, tc.name)
				assert.Equal(t, tc.baseURL, getTableRowValue(ds.Configuration, "Base URLs and Tags", "Base URL"))
				assert.Equal(t, "None", getConfigField(ds.Configuration, "Authentication Method"))
			}
		})
	}
}
