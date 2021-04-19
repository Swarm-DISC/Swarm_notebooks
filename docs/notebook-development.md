# 📓 Notebook Development

:::{caution}
:class: caution
This guide is a work in progress
:::

## What are notebooks?

 > "Jupyter notebooks are documents that combine live runnable code with narrative text (Markdown), equations (LaTeX), images, interactive visualizations and other rich output" [(JupyterLab documentation)](https://jupyterlab.readthedocs.io/en/stable/user/notebook.html)

There are several ways notebooks are used:

- Exploratory messing-around [(example)](https://github.com/smithara/viresclient_examples)
    - won't be very tidy and reproducibility is low
    - easy way to quickly store your ideas for later or share with somebody else
- Demonstrations and documentation [(example)](http://heliopython.org/gallery/generated/gallery/index.html)
    - used to demonstrate how to use a particular package / system
    - good way to showcase something and can be part of a wider documentation
- Tutorials (scientific or otherwise) [(example)](https://github.com/xarray-contrib/xarray-tutorial)
    - ordered and informative with focus on the teaching element
    - can be used as a resource for a workshop
    - for a deep dive, read [Teaching and Learning with Jupyter](https://jupyter4edu.github.io/jupyter-edu-book/)
- Reproducible scientific analysis
    - publishable scientific content
    - portability and reproducibility is important
    - can be supplementary material for a publication
- Basis for interactive dashboards [(example)](https://github.com/pyviz-demos/glaciers)
    - combining powerful libraries to deploy a low-code dashboard developed directly in a notebook

## Writing a notebook

### Notebook contents

**Preamble:** The top of the notebook should contain the following things to orientate the user:

-   *Short* introduction to what the notebook contains, including links
    to related notebooks & relevant resources.
-   List of non-standard requirements for the notebook: e.g. data
    accessed by the notebook; additional packages to be installed. In
    the context of the VRE, *non-standard* here refers to anything not
    supported by the VRE currently (we can then investigate supporting
    these if appropriate). For a more sophisticated setup, consider a
    [requirements.txt](https://pip.pypa.io/en/stable/user_guide/#requirements-files)
    and/or
    [environment.yml](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)
    to specify packages (and versions).
-   Import all modules used in the notebook, and specify data file paths
    (use
    [pathlib](https://docs.python.org/3/library/pathlib.html#basic-use)
    for platform-agnostic paths). This will make it clear what other
    resources (outside the notebook) are required to run it - if you can
    run this first code cell, you should be able to run the rest.

**Organisation:** Divide the notebook into manageable sections separated
by sub-titles and descriptive text.

**Refactoring:** As you experiment with things, the notebook will
inevitably get disorganised and hard to follow. You should occasionally
review this and merge or split code cells into logical units. Before
leaving the notebook (and definitely before sharing with others!),
restart the kernel and *run the notebook from top to bottom* to ensure it
is valid.

### Pitfalls of notebooks

**Out-of-order execution:** It is easy to change cells, re-execute them
etc., in different orders, as you iteratively explore an analysis. This
can rapidly get the notebook into an ambiguous state (the code written
in the notebook no longer represents what has actually been run). Avoid
this with frequent review & refactoring.

**Managing the namespace:** A long notebook can contain too many
variables to keep track of. Sometimes you may inadvertently re-use a
variable name that you have used earlier, leading to unforeseen
consequences. Variables should be kept available only within the scope
of where they are relevant, and having too many variables defined at a
given moment makes it hard for the reader to follow. Avoid this by
refactoring the contents of a code cell into a function.

**Re-using code across notebooks:** Often you will want to re-use a
recipe developed in another notebook. You can simply copy across the
code from one notebook into another - this is where refactoring the code
into portable
[documented](https://python-102.readthedocs.io/en/latest/documenting.html)
functions will help. However, this is not a very maintainable path (do
you update both occurrences of the code when you want to change it?). If
the code is particularly important and often re-used, then it should be
moved into an [importable Python
module](https://python-102.readthedocs.io/en/latest/packaging.html#how-to-structure-a-python-project),
or even to a core package (e.g. viresclient).

:::{admonition} To do
:class: todo, dropdown
-   More detailed style guidance and worked examples
-   Problems with notebooks: challenges with: version control,
    integration with IDEs, testing and CI, linting, code quality,
    maintainability & extensibility
-   Improvements to workflow through Jupyter extensions
-   Diagram showing progress of a tool from notebook (usable by this
    notebook) to module+notebook (usable by any notebook in this
    repository) to package+notebook (usable by anybody) \-- increasing
    maturity
:::

## Sharing notebooks

Individual notebooks can be uploaded to JupyterLab using the \"Upload\" button
(which means you must first download the notebooks to your computer from
GitHub or elsewhere). To easily access a full repository, open a command
line console and use git:

To clone a repository to your working space:  
```bash
git clone https://github.com/pacesm/jupyter_notebooks.git ~/martins_notebooks
```  
(this will clone it into `martins_notebooks` within your home directory)

To clear any changes you made and fetch the latest version run:  
```bash
cd ~/martins_notebooks
git fetch
git reset --hard origin/master
```

### Creating a notebook repository

Notebooks of a certain theme can be collected together in a git
repository hosted on GitHub (or equivalents). For an example, see the
[materials used at the IAGA Summer School
2019](https://github.com/MagneticEarth/IAGA_SummerSchool2019). This
provides a central location where anyone can contribute, and it can
easily be redeployed to any computing environment.

To quickly share a single notebook, you might upload it as a
[GitHub Gist](https://gist.github.com/)

**When to create a repository?** If you have more than one notebook, it
is better to keep them in a repository - this gives you a way to track
changes and backup your work as well as making it easy to share by just
pointing to a URL. You may choose to keep a repository of assorted
notebooks under your GitHub account to manage and share small
experiments and code snippets - these could be moved to a more
documented thematic repository later. If you have a [portable &
reproducible
analysis](https://the-turing-way.netlify.app/reproducible-research/overview/overview-definitions)
to share (e.g. supplementary material to a publication), this is perfect
for it\'s own dedicated repository. When there is more than one
contributor (or you want to signal that contributions are welcome), use
a repository under a GitHub organisation (e.g.
[Swarm-DISC](https://github.com/Swarm-DISC/),
[MagneticEarth](https://github.com/MagneticEarth/), or your
research group) - add to an existing repository if your notebooks fit
the scope.

If the resource is intended to be public eventually, it is easier to
make it public from the beginning (i.e. hosting it in an open repository
on GitHub). This makes it easy to invite collaborators, provides a
consistent workflow to save effort re-tooling later, and prevents
inadvertently using non-open components that would delay the release. It
also gives you access to innumerable free services available to open
source projects (such as [GitHub
Actions](https://docs.github.com/en/actions)). If there are issues
blocking this initially, you can still use a private GitHub
repository with limited invited collaborators, which will be easy to
make public later. Perhaps what you are working on right now is
difficult to make public, but you can also consider releasing old
projects - it is worth the effort to [make public what you
can](https://the-turing-way.netlify.app/reproducible-research/open).

1.  [Create a new repo on GitHub](https://github.com/new)

    -   Choose a name that identifies the scope, e.g. Swarm_notebooks,
        IAGA_SummerSchool2019, viresclient_examples
    -   Choose a license (this is important to allow others to legally reuse your code - if you don't know and just want to make it free to use, pick the MIT license)
    -   Add a README - written in [markdown
        (.md)](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
        (easier) or [reStructuredText
        (.rst)](https://github.com/ralsina/rst-cheatsheet/blob/master/rst-cheatsheet.rst)
    -   Follow the instructions to clone it locally

2.  Keep the README updated as the project evolves. This is the first
    point of call for someone coming across your repository so try to
    keep it brief yet informative.

    -   List contributors, contact info, instructions for contributing
    -   Provide instructions for using the notebooks (any external data
        or software required?)
    -   Describe the contents of the notebooks (consider a table of
        contents)
    -   Add *badges* at the top of the README - see [Repository
        badges](#repository-badges)

3.  Add notebooks following a naming convention, for example:

    -   If the repository is a tutorial, number them in sequence:
        `01_introduction.ipynb, 02_first_steps.ipynb`
    -   If there will be several similar experimentative notebooks,
        append/prepend author initials and dates:
        `1_exploratory_analysis_AS_2019-01-01.ipynb`

4.  If there are files other than notebooks, use a structure like:

```
.
├── LICENSE
├── README.md
├── environment.yml
├── data
│    ├── ...           <- Small volumes of data that cannot be robustly accessed in another way
│                       - TODO: For larger data, see below
├── notebooks
│    ├── ...           <- Jupyter notebooks
└── src
     ├── __init__.py   <- Makes src a Python module
     ├── ...           <- Shared module for this project
                        - This can include functions/classes used in more than one notebook
                        - TODO: Instructions for importing from here
```

[\[More info on this
structure\]](https://drivendata.github.io/cookiecutter-data-science/#directory-structure)

:::{admonition} To do
:class: todo, dropdown
-   License recommendations
-   Handling version control
-   Making portable with env/reqs specification
-   Handling software and data deps (internal/external \...)
-   Data dependencies:
    -   Go to the source - pull in from somewhere else (with initial
        build script, or within notebook)
    -   Git-LFS
    -   Institutional/external server (with some guarantee that it will
        remain accessible in the same format\...)
    -   Cloud bucket and using [Intake](https://intake.readthedocs.io/)
-   Automated testing
:::

### Repository badges

\"Badges\" provide at-a-glance info and dynamic links for metadata,
tools to interact with the code, information from services monitoring
code health etc. For example, [NBViewer](https://nbviewer.jupyter.org/)
renders notebooks better than GitHub. These badges can be added to the project README.
You can create a badge using code like below:

Markdown:

    [![nbviewer](https://img.shields.io/badge/render-nbviewer-orange.svg)](https://nbviewer.jupyter.org/github/smithara/IAGA_SummerSchool2019/tree/master/notebooks/)

reStructuredText:

    .. image:: https://img.shields.io/badge/render-nbviewer-orange.svg
       :target: https://nbviewer.jupyter.org/github/smithara/IAGA_SummerSchool2019/tree/master/notebooks/

[![image](https://img.shields.io/badge/render-nbviewer-orange.svg)](https://nbviewer.jupyter.org/github/smithara/IAGA_SummerSchool2019/tree/master/notebooks/)

### nbgitpuller

nbgitpuller is a tool which enables the creation of magic links that tell Jupyter to automatically pull in an external git repository. The extension is installed on the VRE so that you can use the [nbgitpuller link generator](https://jupyterhub.github.io/nbgitpuller/link?hub=https://vre.vires.services/&repo=https://github.com/Swarm-DISC/Swarm_notebooks) to provide an easy way for others to access your notebooks (beware that there is [automatic merging behaviour](https://jupyterhub.github.io/nbgitpuller/topic/automatic-merging.html) that you may not want).