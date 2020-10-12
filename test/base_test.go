package test

import (
	"testing"

	"github.com/iwarapter/pingfederate-sdk-go/pingfederate/models"

	"github.com/iwarapter/pingfederate-sdk-go/pingfederate/config"
)

var cfg *config.Config

func TestMain(m *testing.M) {
	cfg = config.NewConfig().WithUsername("Administrator").WithPassword("2Federate").WithEndpoint("https://localhost:9999/pf-admin-api/v1")

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
