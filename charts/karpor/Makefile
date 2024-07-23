# To generate help information
.DEFAULT_GOAL := help
.PHONY: help
help:  ## This help message :)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: doc
doc:  ## Auto Generate README with helm-docs and README.md.gotmpl
	@which helm-docs > /dev/null || (echo "Installing helm-docs@latest ..."; go install github.com/norwoodj/helm-docs/cmd/helm-docs@latest && echo -e "Installation complete!\n")
	@helm-docs
