#################### Build Open edX Docker image based on Alpine Linux
.DEFAULT_GOAL := help
.ONESHELL:

openedx-image: ## Build image for buildah
	cd openedx-build
	./build.sh
##################### Information


ESCAPE = 
help: ## Print this help
	@grep -E '^([a-zA-Z_-]+:.*?## .*|######* .+)$$' Makefile \
		| sed 's/######* \(.*\)/\n               $(ESCAPE)[1;31m\1$(ESCAPE)[0m/g' \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%-30s\033[0m %s\n", $$1, $$2}'
