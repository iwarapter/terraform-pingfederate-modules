package test

import (
	"testing"

	"github.com/iwarapter/pingfederate-sdk-go/pingfederate/models"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/iwarapter/pingfederate-sdk-go/services/idpAdapters"
	"github.com/stretchr/testify/assert"
)

func TestIdpAdapterHtmlFormAdapter(t *testing.T) {
	client := idpAdapters.New(cfg)

	tests := []struct {
		testName       string
		name           string
		vars           map[string]interface{}
		expectedError  bool
		errorMessage   string
		validationFunc func(t *testing.T, adapter *models.IdpAdapter)
	}{
		{
			testName: "default deployment",
			name:     "test1",
			validationFunc: func(t *testing.T, adapter *models.IdpAdapter) {
				assert.Equal(t, "3", getConfigField(adapter.Configuration, "Challenge Retries"))
				assert.Equal(t, "60", getConfigField(adapter.Configuration, "Session Timeout"))
				assert.Equal(t, "480", getConfigField(adapter.Configuration, "Session Max Timeout"))
				assert.Equal(t, "", getConfigField(adapter.Configuration, "Notification Publisher"))
				assert.Equal(t, "username", *adapter.AttributeMapping.AttributeContractFulfillment["username"].Value)
				assert.Equal(t, "policy.action", *adapter.AttributeMapping.AttributeContractFulfillment["policy.action"].Value)
			},
		},
	}
	for _, tc := range tests {
		t.Run(tc.testName, func(t *testing.T) {

			terraformOptions := &terraform.Options{
				TerraformDir: "../modules/idp_html_form_idp_adapter",

				Vars: map[string]interface{}{
					"name":                              tc.name,
					"password_credential_validator_ids": []string{"examplepcv"},
				},
				NoColor: true,
			}

			//add tc vars
			for k, v := range tc.vars {
				terraformOptions.Vars[k] = v
			}

			if tc.expectedError {
				if _, err := terraform.InitAndApplyE(t, terraformOptions); err != nil {
					assert.Contains(t, err.Error(), tc.errorMessage)
				}
			} else {
				defer terraform.Destroy(t, terraformOptions)
				terraform.InitAndApplyAndIdempotent(t, terraformOptions)
				mgr, _, err := client.GetIdpAdapters(&idpAdapters.GetIdpAdaptersInput{Filter: tc.name})

				assert.Nil(t, err)
				assert.NotNil(t, mgr)

				assert.Equal(t, *(*mgr.Items)[0].Name, tc.name)
				tc.validationFunc(t, (*mgr.Items)[0])
			}
		})
	}
}
