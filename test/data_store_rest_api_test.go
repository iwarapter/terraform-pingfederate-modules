package test

import (
	"testing"

	"github.com/iwarapter/pingfederate-sdk-go/pingfederate/models"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/iwarapter/pingfederate-sdk-go/services/dataStores"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestDataStoreRestApi(t *testing.T) {
	// t.Parallel()

	client := dataStores.New(cfg)

	tests := []struct {
		testName      string
		name          string
		baseURL       string
		apiAttr       map[string]string
		httpRequest   map[string]string
		expectedError bool
		errorMessage  string
	}{
		{
			testName: "default deployment",
			name:     "test1",
			baseURL:  "https://foo.com/api/v1",
			apiAttr: map[string]string{
				"foo": "/foo",
			},
			httpRequest: map[string]string{
				"Host": "api.server.com",
			},
		},
	}
	for _, tc := range tests {
		t.Run(tc.testName, func(t *testing.T) {

			terraformOptions := &terraform.Options{
				TerraformDir: "../modules/data_store_rest_api",

				Vars: map[string]interface{}{
					"name":        tc.name,
					"baseURL":     tc.baseURL,
					"apiAttr":     tc.apiAttr,
					"httpRequest": tc.httpRequest,
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

				ds, _, err := client.GetDataStores()
				assert.Nil(t, err)
				assert.NotNil(t, ds)
				assert.Len(t, ds.Items, 1)

				assert.Equal(t, (*ds.Items)[0].(models.CustomDataStore).Name, tc.name)
			}
		})
	}
}
