# Swarm_notebooks

Notebooks demonstrating access to [products from the ESA Swarm mission](https://earth.esa.int/eogateway/missions/swarm) using [VirES](https://vires.services/)

Browse them at https://notebooks.vires.services

Interact with them on the [Swarm Virtual Research Environment](https://vre.vires.services/) (an [ESA project](https://earth.esa.int/eogateway/tools/swarm-vre))

## Development

Check [the wiki on GitHub](https://github.com/Swarm-DISC/Swarm_notebooks/wiki) for notes on the development process

### bookbuilder

The `bookbuilder` conda environment contains build tools (jupyter-book, nbmake, pytest)
that are kept isolated from the VRE base environment.

The lock file `conda-linux-64.lock` pins exact versions and is used by the `Dockerfile`
at image build time.

### Usage

Build and run everything via `make` (requires Docker or Podman):

```
make image       # Build the extended Docker image (includes the bookbuilder conda environment)
make execute     # Execute notebooks (uses ~/.viresclient.ini)
make html        # Build the Jupyter Book
make all         # Execute then build
make serve       # Serve the built book locally at http://localhost:8000
make vre         # Start interactive JupyterLab
```

Pass `TARGET_BRANCH=staging` to install the staging viresclient branch:
```
make execute TARGET_BRANCH=staging
```
