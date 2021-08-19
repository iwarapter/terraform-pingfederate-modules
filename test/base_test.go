package test

import (
	"fmt"
	"log"
	"net/http"
	"testing"
	"time"

	"github.com/iwarapter/pingfederate-sdk-go/services/keyPairsSigning"

	"github.com/iwarapter/pingfederate-sdk-go/services/authenticationSelectors"
	"github.com/iwarapter/pingfederate-sdk-go/services/idpAdapters"
	"github.com/iwarapter/pingfederate-sdk-go/services/oauthAccessTokenManagers"
	"github.com/iwarapter/pingfederate-sdk-go/services/passwordCredentialValidators"

	"github.com/iwarapter/pingfederate-sdk-go/services/version"

	pf "github.com/iwarapter/pingfederate-sdk-go/pingfederate/models"

	"github.com/iwarapter/pingfederate-sdk-go/pingfederate/config"
)

var cfg *config.Config

func TestMain(m *testing.M) {
	cfg = config.NewConfig().WithUsername("Administrator").WithPassword("2FederateM0re").WithEndpoint("https://localhost:9999/pf-admin-api/v1")

	client := version.New(cfg)

	for i := 0; i < 12; i++ {
		v, r, err := client.GetVersion()
		if err != nil {
			fmt.Printf("Unable to connect to PingFederate: %s\n", err)
			time.Sleep(time.Second * 5)
		}
		if r != nil {
			fmt.Printf("Waiting for PingFederate to start, response code: %d\n", r.StatusCode)
			if r.StatusCode == http.StatusOK {
				fmt.Printf("Connected to PingFederate version: %s\n", *v.Version)
				time.Sleep(time.Second * 5)
				break
			}
		}
	}
	if err := dataSetup(); err != nil {
		log.Fatalf("unable to setup test data\n%s", err)
	}
	m.Run()
}

func getConfigField(conf *pf.PluginConfiguration, field string) string {
	for _, configField := range *conf.Fields {
		if *configField.Name == field && configField.Value != nil {
			return *configField.Value
		}
	}
	return ""
}

func getTableRowValue(conf *pf.PluginConfiguration, table, field string) string {
	for _, t := range *conf.Tables {
		if *t.Name == table {
			for _, r := range *t.Rows {
				for _, f := range *r.Fields {
					if *f.Name == field && f.Value != nil {
						return *f.Value
					}
				}
			}
		}
	}
	return ""
}

// Bool is a helper routine that allocates a new bool value
// to store v and returns a pointer to it.
func Bool(v bool) *bool { return &v }

// Int is a helper routine that allocates a new int value
// to store v and returns a pointer to it.
func Int(v int) *int { return &v }

// String is a helper routine that allocates a new string value
// to store v and returns a pointer to it.
func String(v string) *string { return &v }

func dataSetup() error {
	pcv := passwordCredentialValidators.New(cfg)
	if _, _, err := pcv.GetPasswordCredentialValidator(&passwordCredentialValidators.GetPasswordCredentialValidatorInput{Id: "examplepcv"}); err != nil {
		if _, _, err := pcv.CreatePasswordCredentialValidator(&passwordCredentialValidators.CreatePasswordCredentialValidatorInput{
			Body: pf.PasswordCredentialValidator{
				Configuration: &pf.PluginConfiguration{
					Tables: &[]*pf.ConfigTable{
						{
							Name: String("Users"),
							Rows: &[]*pf.ConfigRow{
								{
									Fields: &[]*pf.ConfigField{
										{
											Name:  String("Username"),
											Value: String("example"),
										},
										{
											Name:  String("Password"),
											Value: String("example"),
										},
										{
											Name:  String("Confirm Password"),
											Value: String("example"),
										},
										{
											Name:  String("Relax Password Requirements"),
											Value: String("true"),
										},
									},
								},
							},
						},
					},
				},
				Id:                  String("examplepcv"),
				Name:                String("examplepcv"),
				PluginDescriptorRef: &pf.ResourceLink{Id: String("org.sourceid.saml20.domain.SimpleUsernamePasswordCredentialValidator")},
			},
		}); err != nil {
			return fmt.Errorf("unable to create test password credential validator\n%s", err)
		}
	}
	atv := oauthAccessTokenManagers.New(cfg)
	if _, _, err := atv.GetTokenManager(&oauthAccessTokenManagers.GetTokenManagerInput{Id: "testme"}); err != nil {
		if _, _, err := atv.CreateTokenManager(&oauthAccessTokenManagers.CreateTokenManagerInput{
			Body: pf.AccessTokenManager{
				AccessControlSettings: nil,
				AttributeContract: &pf.AccessTokenAttributeContract{
					ExtendedAttributes: &[]*pf.AccessTokenAttribute{
						{
							Name: String("name"),
						},
					},
				},
				Configuration:             &pf.PluginConfiguration{},
				Id:                        String("testme"),
				Name:                      String("testme"),
				PluginDescriptorRef:       &pf.ResourceLink{Id: String("org.sourceid.oauth20.token.plugin.impl.ReferenceBearerAccessTokenManagementPlugin")},
				SelectionSettings:         nil,
				SessionValidationSettings: nil,
			},
		}); err != nil {
			return fmt.Errorf("unable to create test password credential validator\n%s", err)
		}
	}
	idp := idpAdapters.New(cfg)
	if _, _, err := idp.GetIdpAdapter(&idpAdapters.GetIdpAdapterInput{Id: "idptestme"}); err != nil {
		if _, _, err := idp.CreateIdpAdapter(&idpAdapters.CreateIdpAdapterInput{BypassExternalValidation: Bool(true),
			Body: pf.IdpAdapter{
				AttributeContract: &pf.IdpAdapterAttributeContract{
					CoreAttributes: &[]*pf.IdpAdapterAttribute{
						{
							Name:      String("username"),
							Pseudonym: Bool(true),
						},
					},
					ExtendedAttributes: &[]*pf.IdpAdapterAttribute{
						{
							Name: String("sub"),
						},
					},
				},
				AttributeMapping: nil,
				AuthnCtxClassRef: nil,
				Configuration: &pf.PluginConfiguration{
					Tables: &[]*pf.ConfigTable{
						{
							Name: String("Credential Validators"),
							Rows: &[]*pf.ConfigRow{
								{
									Fields: &[]*pf.ConfigField{
										{
											Name:  String("Password Credential Validator Instance"),
											Value: String("examplepcv"),
										},
									},
								},
							},
						},
					},
					Fields: &[]*pf.ConfigField{
						{
							Name:  String("Realm"),
							Value: String("foo"),
						},
						{
							Name:  String("Challenge Retries"),
							Value: String("3"),
						},
					},
				},
				Id:                  String("idptestme"),
				Name:                String("idptestme"),
				ParentRef:           nil,
				PluginDescriptorRef: &pf.ResourceLink{Id: String("com.pingidentity.adapters.httpbasic.idp.HttpBasicIdpAuthnAdapter")},
			},
		}); err != nil {
			return fmt.Errorf("unable to create test idp adapter\n%s", err)
		}
	}
	authnSel := authenticationSelectors.New(cfg)
	if _, _, err := authnSel.GetAuthenticationSelector(&authenticationSelectors.GetAuthenticationSelectorInput{Id: "authseltestme"}); err != nil {
		if _, _, err := authnSel.CreateAuthenticationSelector(&authenticationSelectors.CreateAuthenticationSelectorInput{
			Body: pf.AuthenticationSelector{
				Configuration: &pf.PluginConfiguration{
					Tables: &[]*pf.ConfigTable{
						{
							Name: String("Networks"),
							Rows: &[]*pf.ConfigRow{
								{
									Fields: &[]*pf.ConfigField{
										{
											Name:  String("Network Range (CIDR notation)"),
											Value: String("127.0.0.1/32"),
										},
									},
								},
							},
						},
					},
					Fields: &[]*pf.ConfigField{
						{
							Name:  String("Result Attribute Name"),
							Value: String(""),
						},
					},
				},
				Id:                  String("authseltestme"),
				Name:                String("authseltestme"),
				PluginDescriptorRef: &pf.ResourceLink{Id: String("com.pingidentity.pf.selectors.cidr.CIDRAdapterSelector")},
			},
		}); err != nil {
			return fmt.Errorf("unable to create test authentication selector\n%s", err)
		}
	}
	signer := keyPairsSigning.New(cfg)
	if _, _, err := signer.GetKeyPair(&keyPairsSigning.GetKeyPairInput{Id: "signme"}); err != nil {
		if _, _, err := signer.CreateKeyPair(&keyPairsSigning.CreateKeyPairInput{
			Body: pf.NewKeyPairSettings{
				City:             String("test"),
				CommonName:       String("test"),
				Country:          String("GB"),
				Id:               String("signme"),
				KeyAlgorithm:     String("RSA"),
				KeySize:          Int(2048),
				Organization:     String("test"),
				OrganizationUnit: String("test"),
				State:            String("test"),
				ValidDays:        Int(365),
			},
		}); err != nil {

		}
	}
	return nil
}
