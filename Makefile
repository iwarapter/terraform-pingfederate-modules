# Makefile
.PHONY: test

pf-init:
	@docker run --rm -d --hostname pingfederate --name pingfederate -v `pwd`/pingfederate-data.zip:/opt/in/instance/server/default/data/drop-in-deployer/data.zip -e PING_IDENTITY_DEVOPS_KEY=$(PING_IDENTITY_DEVOPS_KEY) -e PING_IDENTITY_DEVOPS_USER=$(PING_IDENTITY_DEVOPS_USER) -e PING_IDENTITY_ACCEPT_EULA=YES --publish 9999:9999 --publish 9031:9031 pingidentity/pingfederate:10.0.5-edge

checks:
	@go fmt ./...
	@for d in modules/*/ ; do \
  		terraform fmt "$d"; \
  	done

test:
	@go test -count=1 -v -timeout 30m  ./...
