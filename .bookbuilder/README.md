To install the build environment (within the running container):

```
mamba run --no-capture-output -n base python -m ipykernel install --user --name base
mamba create --name bookbuilder --file .bookbuilder/conda-linux-64.lock
```

To execute the notebooks:
```
mamba run -n bookbuilder pytest --numprocesses 2 --nbmake --overwrite --nbmake-kernel=base \
	notebooks/*.ipynb \
    --deselect=notebooks/04c1_Geomag-Ground-Data-FTP.ipynb
```

And build the jupyter-book (without executing notebooks):
```
jupyter-book build --config _config-ci.yml .
```

To update the conda-lock environment:
```
pipx install --python /usr/bin/python3.11 conda-lock
conda-lock --platform linux-64 --no-dev-dependencies --kind explicit --file environment.yml
```
