SHELL=/bin/bash -o pipefail

PLUGIN_NAME=leogr/docker-authz-plugin
PLUGIN_TAG=dev

GO ?= go
DOCKER ?= docker

export GO111MODULE=on

.PHONY: docker-authz-plugin
docker-authz-plugin:
	$(GO) build -a -tags netgo -ldflags '-extldflags "-static"' -o $@ .

.PHONY: plugin
plugin: clean
	$(DOCKER) build --no-cache -t ${PLUGIN_NAME}:rootfs .
	mkdir -p ./plugin/rootfs
	$(DOCKER) create --name tmp ${PLUGIN_NAME}:rootfs
	$(DOCKER) export tmp | tar -x -C ./plugin/rootfs
	cp config.json ./plugin/.
	$(DOCKER) rm -vf tmp

.PHONY: create
create: plugin
	@$(DOCKER) plugin rm -f "$(PLUGIN_NAME):${PLUGIN_TAG}" || true
	$(DOCKER) plugin create "${PLUGIN_NAME}:${PLUGIN_TAG}" ./plugin

.PHONY: enable
install: 
	$(DOCKER) plugin enable "${PLUGIN_NAME}:${PLUGIN_TAG}"

.PHONY: clean
clean:
	rm -rf ./plugin