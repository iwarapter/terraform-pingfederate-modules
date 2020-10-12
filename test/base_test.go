package test

import (
	"fmt"
	"net/http"
	"testing"
	"time"

	"github.com/iwarapter/pingfederate-sdk-go/services/version"

	"github.com/iwarapter/pingfederate-sdk-go/pingfederate/models"

	"github.com/iwarapter/pingfederate-sdk-go/pingfederate/config"
)

var cfg *config.Config

func TestMain(m *testing.M) {
	cfg = config.NewConfig().WithUsername("Administrator").WithPassword("2Federate").WithEndpoint("https://localhost:9999/pf-admin-api/v1")

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
	m.Run()
}

func getConfigField(conf *models.PluginConfiguration, field string) string {
	for _, configField := range *conf.Fields {
		if *configField.Name == field && configField.Value != nil {
			return *configField.Value
		}
	}
	return ""
}
