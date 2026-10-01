ARG VRE_IMAGE=registry.gitlab.eox.at/esa/vires_vre_ops/vre-swarm-notebook
ARG VRE_TAG=1.0.14
FROM ${VRE_IMAGE}:${VRE_TAG}

USER root

# Register the base env kernel (notebooks execute here, untouched)
RUN mamba run --no-capture-output -n base python -m ipykernel install --name base

# Create isolated bookbuilder env for build tools only
COPY .bookbuilder/conda-linux-64.lock /tmp/conda-linux-64.lock
RUN mamba create --name bookbuilder --file /tmp/conda-linux-64.lock \
    && mamba clean -afy

ENV CDF_LIB=/opt/conda/lib
USER jovyan
WORKDIR /home/jovyan
