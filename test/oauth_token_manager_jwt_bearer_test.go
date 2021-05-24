package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/iwarapter/pingfederate-sdk-go/services/oauthAccessTokenManagers"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestJwtBearerOauthTokenManager(t *testing.T) {
	// t.Parallel()

	client := oauthAccessTokenManagers.New(cfg)

	tests := []struct {
		testName      string
		vars          map[string]interface{}
		expectedError bool
		errorMessage  string
	}{
		{
			testName: "default deployment",
			vars: map[string]interface{}{
				"name":                              "test1",
				"instance_id":                       "test1",
				"jws_algorithm":                     "PS256",
				"extended_attributes":               []string{"foo"},
				"active_signing_certificate_key_id": "example",
				"symmetric_keys": []map[string]interface{}{
					{
						"key_id":   "foo",
						"key":      "9319441558153724693874699619254816014359790324818031901517360910403143220219940540347473320637629375485027716143321366694653017649229829172928410608545829888156345926891971920063583224149743814433939091791753720491153843019524960678262165907902446944351631",
						"encoding": nil,
					},
				},
				"certificates": []map[string]interface{}{
					{
						"key_id":      "example",
						"certificate": "signme",
					},
				},
			},
		},
		{
			testName: "we can set multiple extended attributes",
			vars: map[string]interface{}{
				"name":                              "test1",
				"instance_id":                       "test1",
				"jws_algorithm":                     "PS256",
				"extended_attributes":               []string{"foo", "bar"},
				"active_signing_certificate_key_id": "example",
				"certificates": []map[string]interface{}{
					{
						"key_id":      "example",
						"certificate": "signme",
					},
				},
			},
		},
	}
	for _, tc := range tests {
		t.Run(tc.testName, func(t *testing.T) {

			terraformOptions := &terraform.Options{
				TerraformDir: "../modules/oauth_token_manager_jwt_bearer",
				Vars:         tc.vars,
				NoColor:      true,
			}

			if tc.expectedError {
				if _, err := terraform.InitAndApplyE(t, terraformOptions); err != nil {
					assert.Contains(t, err.Error(), tc.errorMessage)
				}
			} else {
				defer terraform.Destroy(t, terraformOptions)
				terraform.InitAndApply(t, terraformOptions)
				mgr, _, err := client.GetTokenManager(&oauthAccessTokenManagers.GetTokenManagerInput{Id: tc.vars["instance_id"].(string)})

				assert.Nil(t, err)
				assert.NotNil(t, mgr)

				assert.Equal(t, *mgr.Name, tc.vars["name"])
				assert.Equal(t, *mgr.Id, tc.vars["instance_id"])
			}
		})
	}
}
