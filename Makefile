.PHONY: all

########################################################

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## create delta server docker image
	docker build -t delta-sharing . 
	
run: ## run server
	docker run --rm -it -p 8081:8081 delta-sharing                                                                                    
