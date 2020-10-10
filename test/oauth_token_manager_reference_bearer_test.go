package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/iwarapter/pingfederate-sdk-go/services/oauthAccessTokenManagers"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestReferenceBearerOauthTokenManager(t *testing.T) {
	// t.Parallel()

	client := oauthAccessTokenManagers.New(cfg)

	tests := []struct {
		testName                string
		name                    string
		instanceID              string
		extendedAttributes      []string
		lifetimeExtensionPolicy string
		modeForSynchronousRPC   string
		expandScopeGroups       string
		expectedError           bool
		errorMessage            string
	}{
		{
			testName:                "default deployment",
			name:                    "test1",
			instanceID:              "test1",
			lifetimeExtensionPolicy: "ALL",
			modeForSynchronousRPC:   "3",
			expandScopeGroups:       "false",
			extendedAttributes:      []string{"sub"},
		},
		{
			testName:                "we can set multiple extended attributes",
			name:                    "test2",
			instanceID:              "test2",
			lifetimeExtensionPolicy: "ALL",
			modeForSynchronousRPC:   "3",
			expandScopeGroups:       "false",
			extendedAttributes:      []string{"sub", "foo"},
		},
		{
			testName:                "check variable validation lifetime_extension_policy",
			name:                    "test3",
			instanceID:              "test3",
			extendedAttributes:      []string{"sub"},
			lifetimeExtensionPolicy: "Foo",
			modeForSynchronousRPC:   "3",
			expandScopeGroups:       "false",
			expectedError:           true,
			errorMessage:            "The lifetime_extension_policy must be one of 'ALL', 'TRANSIENT', 'NONE'.",
		},
		{
			testName:                "check variable validation mode_for_synchronous_rpc",
			name:                    "test4",
			instanceID:              "test4",
			extendedAttributes:      []string{"sub"},
			lifetimeExtensionPolicy: "NONE",
			modeForSynchronousRPC:   "5",
			expandScopeGroups:       "false",
			expectedError:           true,
			errorMessage:            "The mode_for_synchronous_rpc must be either '3' (Majority) or '2' (All).",
		},
		{
			testName:                "check variable validation expand_scope_groups",
			name:                    "test5",
			instanceID:              "test5",
			extendedAttributes:      []string{"sub"},
			lifetimeExtensionPolicy: "NONE",
			modeForSynchronousRPC:   "3",
			expandScopeGroups:       "cheese",
			expectedError:           true,
			errorMessage:            "The expand_scope_groups must be either 'true' or 'false'.",
		},
	}
	for _, tc := range tests {
		t.Run(tc.testName, func(t *testing.T) {

			terraformOptions := &terraform.Options{
				TerraformDir: "../modules/oauth_token_manager_reference_bearer",

				Vars: map[string]interface{}{
					"name":                      tc.name,
					"instance_id":               tc.instanceID,
					"extended_attributes":       tc.extendedAttributes,
					"lifetime_extension_policy": tc.lifetimeExtensionPolicy,
					"mode_for_synchronous_rpc":  tc.modeForSynchronousRPC,
					"expand_scope_groups":       tc.expandScopeGroups,
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
				mgr, _, err := client.GetTokenManager(&oauthAccessTokenManagers.GetTokenManagerInput{Id: tc.instanceID})

				assert.Nil(t, err)
				assert.NotNil(t, mgr)

				assert.Equal(t, *mgr.Name, tc.name)
				assert.Equal(t, *mgr.Id, tc.instanceID)
			}
		})
	}
}
