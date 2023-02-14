.PHONY: generate-module
generate-module: # Generate module
	mint run genesis generate ./template/template.yml --options "date:$(shell date +%Y/%m/%d), module_name:${MODULE_NAME}" --option-path default_values.yml