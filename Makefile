# Makefile
.PHONY: test
CURDATE := ${shell date +'%y%m%d'}

pf-init:
	@docker run --rm -d --hostname pingfederate --name pingfederate \
		-e IMAGE_VERSION=pingfederate-alpine-az11-10.2.2-${CURDATE}-d9b5 \
		-e PING_IDENTITY_DEVOPS_KEY=$(PING_IDENTITY_DEVOPS_KEY) \
		-e PING_IDENTITY_DEVOPS_USER=$(PING_IDENTITY_DEVOPS_USER) \
		-e PING_IDENTITY_ACCEPT_EULA=YES \
		--publish 9999:9999 \
		--publish 9031:9031 pingidentity/pingfederate:10.2.3-edge

checks:
	@go fmt ./...
	@for d in modules/*/ ; do \
  		terraform fmt "$d"; \
  	done

test:
	@PINGFEDERATE_PASSWORD=2FederateM0re go test -count=1 -v -timeout 30m  ./...
