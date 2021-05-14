# Makefile
.PHONY: test

pf-init:
	@docker run --rm -d --hostname pingfederate --name pingfederate \
		-e SERVER_PROFILE_URL=https://github.com/pingidentity/pingidentity-server-profiles.git \
		-e SERVER_PROFILE_PATH=getting-started/pingfederate \
		-e IMAGE_VERSION=pingfederate-alpine-az11-10.0.6-210514-d9b5 \
		-e PING_IDENTITY_DEVOPS_KEY=$(PING_IDENTITY_DEVOPS_KEY) \
		-e PING_IDENTITY_DEVOPS_USER=$(PING_IDENTITY_DEVOPS_USER) \
		-e PING_IDENTITY_ACCEPT_EULA=YES \
		--publish 9999:9999 \
		--publish 9031:9031 pingidentity/pingfederate:10.0.6-edge

checks:
	@go fmt ./...
	@for d in modules/*/ ; do \
  		terraform fmt "$d"; \
  	done

test:
	@PINGFEDERATE_PASSWORD=2FederateM0re go test -count=1 -v -timeout 30m  ./...
