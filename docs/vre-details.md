# ⚙️ VRE: System details

This page offers more details about the computational environment: what software is installed, how you can add new packages, and how you can replicate the software environment on other machines.

:::{admonition} Hardware available
:class: note
As this  is a freely provided service, the per-user “hardware” available is limited. The limits are subject to change, but at time of writing they are:
- 1 CPU
- 3.5 GB RAM
- 10 GB persistent storage

If you try running some hardware and quota inspection commands that you are used to running on physical \*nix machines, you may be confused by the outputs - this is a result of the virtualisation within a cloud environment
:::

## Software available: Python packages

:::{admonition} To see the full list:
:class: info
Open a Terminal (`File/New/Terminal`) and enter: `conda list`
:::

### VirES/EOX software

[viresclient](https://github.com/ESA-VirES/VirES-Python-Client/)
: Access to VirES server (download of Swarm products as pandas/xarray)

[eoxmagmod](https://github.com/ESA-VirES/MagneticModel/)
: Optimised forward evaluation of Swarm geomagnetic models

### Swarm community software

[chaosmagpy](https://github.com/ancklo/ChaosMagPy)
: CHAOS model forward code and geomag modelling utilities

[pyamps](https://github.com/klaundal/pyAMPS)
: AMPS model forward code

[swarmpyfac](https://github.com/Swarm-DISC/SwarmPyFAC)
: Implementation of single-spacecraft FAC algorithm

[ibp](https://gitext.gfz-potsdam.de/rother/ibp-model)
: Ionospheric bubble probability forward code

### Wider geomagnetism and space physics community software

[magpysv](https://github.com/gracecox/MagPySV)
: Generating secular variation time series from ground observatory data

[apexpy](https://github.com/aburrell/apexpy)
: Apex and quasi-dipole coordinate transformations

[spacepy](https://github.com/spacepy/spacepy)
: Tools for space physics

### General Python software (highlights)

[pandas](https://pandas.pydata.org)
: Powerful analysis tool built around dataframes

[xarray](https://xarray.pydata.org)
: For labelled multi-dimensional arrays

[cartopy](https://scitools.org.uk/cartopy)
: Geospatial data processing and maps

[dask](https://docs.dask.org)
: Flexible library for parallel computing

[holoviz ecosystem](https://holoviz.org)
: High level tools to simplify making complex visualisations

:::{note}
We are seeking to evolve this list, which involves a wider effort to increase portability of software. Generally speaking, to add a package here, we require it to be available through `pip` or `conda` and that the software be designed for portability (no large data packages included, and manageable dependencies) and that it is actively maintained. See below to try adding a package yourself to test it.
:::{admonition} Software lists and communities
:class: seealso
- [Python in Heliophysics Community (PyHC)](https://heliopython.org/projects/)
- [Software Underground](https://softwareunderground.org/stack)
:::

## Installing other packages

The default environment comes from a Docker image which is based on the Jupyter Notebook Scientific Python Stack [(`jupyter/scipy-notebook`)](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-scipy-notebook) - with our own extra software and configuration layered on top. This image is loaded when your container starts (i.e. when you log in). It will spin down when you are not using it and restart when you access it again (in its original unmodified state). If you try to install other software, it may not survive the container restart, depending on how you do it. In any case, you will only be affecting *your* environment. Unless you fully understand what you are doing, you are likely to run into problems trying to install and use other software. In this case, please get in touch if you are interested in having access to some particular software.

If you install some packages with `conda install ...` or `pip install ...`, this will indeed install them and make them available to the default kernel immediately. *However*, they will disappear the next time your container shuts down. When you have not been active for some period of time (<~hours), the container within which your environment is running will shut down. When you log in again, the environment is created anew from the image that everybody shares, so your modifications will no longer be present. This means that installing packages (& extensions) in this way is only sensible for briefly trying them out.

## Managing custom environments

If you need access to a different collection of packages (e.g. you need a certain unsupported package, or different versions of what is available), then the way to achieve this is through creating an additional *kernel*, which you can then optionally use to execute scripts or notebooks, in place of the default kernel (the default one will also remain available). This procedure is not covered in full here, but in short:  
```bash
conda create --prefix <kernelpath> ipykernel <package1> <package2> ...
```  
will create a new conda environment (see the existing ones with `conda env list`).

:::{note}
See [the conda documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#specifying-location) for more information on this. Note that to create the environment we must use ``--prefix`` rather than ``--name`` to specify the exact location (choosing the home directory), otherwise the environment location will default to ``/opt/conda/envs/`` *which is not permanent*.
:::

For example:  
```bash
conda create --prefix ~/envs/my_env ipykernel numpy
```  
will create an environment stored within `~/envs/` and called `my_env`, with the packages ipykernel (this is *required* in order to work with Jupyter notebooks), and numpy. This kernel then needs to be *registered* with Jupyter:  
```bash
~/envs/my_env/bin/python -m ipykernel install --user --name my_env --display-name "my_env"
```  
The kernel should now be available to use from within notebooks: when running a notebook, click the "Python 3" button near the top right to change the kernel, or from the top menu: `Kernel / Change Kernel`. You can also access the environment in a terminal with `conda activate ~/envs/my_env`. Since we have stored it in the home directory, it will not be lost when the container shuts down. You can see what kernels are installed and visible to Jupyter with `jupyter kernelspec list`.

## A note on reproducability

*Execution environment:*

An important scenario which is not fully supported by the VRE is ensuring reproducability of code in the future. The VRE is an evolving service which provides a single software environment which is updated over time. As newer versions of packages are installed, we can not guarantee that your code will run exactly the same in the future - this depends on the packages you use and how their behaviours and interfaces change over time. Managing your own custom conda environment as described above is one way to mitigate against this. The VRE as an easy-to-access environment where you can quickly experiment with things, share demonstrations of your code, run tutorials etc. For a detailed introduction to reproducability, please refer to [The Turing Way](https://the-turing-way.netlify.app). Another project which you may be interested in if you are working in geospace science is [Resen](https://ingeo.datatransport.org/home/resen) which aims to tackle this issue of reproducability.

*Data environment:*

Aside from using a consistent software environment, input data must be identical between runs to ensure exact repeatability. VirES provides access to *only the most recent available versions* of data and models. This means that it is not possible to reproduce older results *deterministically* when using viresclient. The product version numbers are available within the data objects returned by viresclient, so you should record these when documenting and publishing your results. If you want to be able to repeat your analysis *identically* in the future (using the same product versions), we recommend you store the interim data returned by viresclient so that you are no longer relying on the VirES server.

## Portability of the environment

We would like to make it easier for you to run a compatible software stack on any machine (your laptop, workstation, or HPC etc.). While you can install `viresclient` within any Python environment and start accessing Swarm data, the exact combination of software and their versions means that a collaborator's analysis code may not work the same within your environment. If both of you can share the same software stack, where one of you may work on the VRE for ease of use and the other may use an HPC system to run expensive computations, then it will make it easier to share analysis code. We are looking into solutions for how to do this reliably, given the differing requirements of institutional systems.