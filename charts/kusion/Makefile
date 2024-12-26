# To generate help information
.DEFAULT_GOAL := help
.PHONY: help
help:  ## This help message :)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: lint
lint:  ## Lint, will not fix but sets exit code on error 
	@which yamllint > /dev/null || (echo "Installing yamllint@latest ..."; brew install yamllint && echo -e "Installation complete!\n")
	@yamllint --config-file ../../.github/configs/lintconf.yaml *.yaml

.PHONY: doc
doc:  ## Auto Generate README with helm-docs and README.md.gotmpl
	@which helm-docs > /dev/null || (echo "Installing helm-docs@latest ..."; go install github.com/norwoodj/helm-docs/cmd/helm-docs@latest && echo -e "Installation complete!\n")
	@helm-docs
