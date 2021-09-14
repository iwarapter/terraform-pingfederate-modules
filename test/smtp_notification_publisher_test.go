package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/iwarapter/pingfederate-sdk-go/services/notificationPublishers"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.

func TestSmtpNotificationPublisher(t *testing.T) {
	// t.Parallel()

	client := notificationPublishers.New(cfg)

	tests := []struct {
		testName      string
		name          string
		from_address  string
		email_server  string
		expectedError bool
		errorMessage  string
	}{
		{
			testName:     "smtp publisher",
			name:         "foo",
			from_address: "someone@foo.com",
			email_server: "server.foo.com",
		},
	}
	for _, tc := range tests {
		t.Run(tc.testName, func(t *testing.T) {

			terraformOptions := &terraform.Options{
				TerraformDir: "../modules/smtp_notification_publisher",

				Vars: map[string]interface{}{
					"name":         tc.name,
					"from_address": tc.from_address,
					"email_server": tc.email_server,
				},
				NoColor: true,
			}

			if tc.expectedError {
				if _, err := terraform.InitAndApplyE(t, terraformOptions); err != nil {
					assert.Contains(t, err.Error(), tc.errorMessage)
				}
			} else {
				defer terraform.Destroy(t, terraformOptions)
				terraform.InitAndApplyAndIdempotent(t, terraformOptions)
				smtppubId := terraform.Output(t, terraformOptions, "id")
				require.NotEmpty(t, smtppubId)
				smtppubId = strings.Trim(smtppubId, `"`)
				np, _, err := client.GetNotificationPublisher(&notificationPublishers.GetNotificationPublisherInput{Id: smtppubId})
				require.Nil(t, err)
				require.NotNil(t, np)
				assert.Equal(t, *np.Name, tc.name)
			}
		})
	}
}
