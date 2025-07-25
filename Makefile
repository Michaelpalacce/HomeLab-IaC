# Setting SHELL to bash allows bash commands to be executed by recipes.
# Options are set to exit when a recipe line exits non-zero or a piped command fails.
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

##@ General

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk command is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Sync

.PHONY: commit-mac
commit-mac: ## Commits the state file to nfs
	cp terraform.tfstate /private/nfs/terraform/ && \
	cp .envrc /private/nfs/terraform

.PHONY: fetch-mac
fetch-mac: ## Fetches the state and vars from NFS to local
	cp /private/nfs/terraform/terraform.tfstate . && \
	cp /private/nfs/terraform/.envrc .

.PHONY: commit-arch
commit-arch: ## Commits the state file to nfs
	cp terraform.tfstate /mnt/k3s/terraform/ && \
	cp .envrc /mnt/k3s/terraform/

.PHONY: fetch-arch
fetch-arch: ## Fetches the state and vars from NFS to local
	cp /mnt/k3s/terraform/terraform.tfstate . && \
	cp /mnt/k3s/terraform/.envrc . && \


