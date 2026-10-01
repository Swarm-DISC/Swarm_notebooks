VRE_IMAGE ?= registry.gitlab.eox.at/esa/vires_vre_ops/vre-swarm-notebook
VRE_TAG ?= 1.0.14
BUILDER_IMAGE = vre-swarm-notebook-bookbuilder:$(VRE_TAG)
TARGET_BRANCH ?= master

CONTAINER_ENGINE ?= $(shell command -v podman 2>/dev/null || echo docker)

NOTEBOOKS = notebooks/*.ipynb docs/*.ipynb
DESELECT = --deselect=notebooks/04c1_Geomag-Ground-Data-FTP.ipynb

# Helper to embed a comma inside $(if ...) — Make treats commas as argument separators
comma := ,

WORKDIR = /home/jovyan/Swarm_notebooks

# Mount ~/.viresclient.ini if it exists (local dev), otherwise no-op
VIRESCLIENT_CONFIG = $(HOME)/.viresclient.ini
MOUNT_CONFIG = $(if $(wildcard $(VIRESCLIENT_CONFIG)),-v $(VIRESCLIENT_CONFIG):/home/jovyan/.viresclient.ini:ro$(comma)z,)

.PHONY: image execute html all serve clean vre help

help:  ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

image:  ## Build the extended Docker image
	$(CONTAINER_ENGINE) build --build-arg VRE_TAG=$(VRE_TAG) -t $(BUILDER_IMAGE) .

execute: image  ## Execute notebooks (TARGET_BRANCH=staging for staging)
	$(CONTAINER_ENGINE) run --rm -v $(CURDIR):$(WORKDIR):z -w $(WORKDIR) \
		$(MOUNT_CONFIG) \
		-e VIRES_TOKEN \
		-e VIRES_TOKEN_STAGING \
		-e VIRES_TOKEN_STAGING_DISC \
		-e TARGET_BRANCH=$(TARGET_BRANCH) \
		$(BUILDER_IMAGE) \
		bash -c '\
			export CDF_LIB=/opt/conda/lib && \
			if [ "$$TARGET_BRANCH" = "staging" ]; then \
				pip install --user --upgrade "git+https://github.com/ESA-VirES/VirES-Python-Client@staging#egg=viresclient"; \
			fi && \
			if [ -n "$$VIRES_TOKEN" ]; then \
				viresclient set_token https://vires.services/ows $$VIRES_TOKEN && \
				viresclient set_default_server https://vires.services/ows; \
			fi && \
			if [ -n "$$VIRES_TOKEN_STAGING" ]; then \
				viresclient set_token https://staging.vires.services/ows $$VIRES_TOKEN_STAGING; \
			fi && \
			if [ -n "$$VIRES_TOKEN_STAGING_DISC" ]; then \
				viresclient set_token https://disc.vires.services/ows $$VIRES_TOKEN_STAGING_DISC; \
			fi && \
			mamba run -n bookbuilder pytest --numprocesses 2 --nbmake --overwrite --nbmake-kernel=base \
				$(NOTEBOOKS) $(DESELECT) \
		'

html: image  ## Build the Jupyter Book (assumes notebooks already executed)
	$(CONTAINER_ENGINE) run --rm -v $(CURDIR):$(WORKDIR):z -w $(WORKDIR) $(BUILDER_IMAGE) \
		bash -c 'mamba run -n bookbuilder jupyter-book build .'

all: execute html  ## Execute notebooks then build book

serve:  ## Serve the built book locally at http://localhost:8000
	python -m http.server -d _build/html 8000

vre:  ## Start interactive VRE JupyterLab (no build tools)
	$(CONTAINER_ENGINE) run -it --rm \
		-p 10000:8888 \
		-v $(CURDIR):$(WORKDIR):z \
		$(MOUNT_CONFIG) \
		--user $$(id -u):$$(id -g) --userns=keep-id \
		-e JUPYTER_ENABLE_LAB=yes \
		$(VRE_IMAGE):$(VRE_TAG)

clean:  ## Remove build artifacts
	rm -rf _build
