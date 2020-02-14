# Swarm_notebooks

[![VRE-Interact](https://img.shields.io/badge/interact-VRE-blue)](https://vre.vires.services/user-redirect/lab/tree/shared/Swarm_notebooks/02a__Intro-Swarm-viresclient.ipynb)
[![nbviewer](https://img.shields.io/badge/render-nbviewer-orange.svg)](https://nbviewer.jupyter.org/github/Swarm-DISC/Swarm_notebooks/tree/master/)

Notebooks demonstrating access to Swarm data for scientific analyses. For more info, and to view them, go to https://swarm-vre.readthedocs.io/en/staging/notebooks_preface.html

### Execution of notebooks (nbconvert)

Convert to executed state in place:

```
jupyter nbconvert --to notebook --inplace --execute 03*.ipynb
```

but be careful about cells that can't be handled by the automation (e.g. `set_token`, widgets...). 

By default, errors will cause nbconvert to halt. To allow errors (and execution will continue onto the following cells), use `allow_errors`:

```
jupyter nbconvert --to notebook --inplace --execute --ExecutePreprocessor.allow_errors=True 02a__Intro-Swarm-viresclient.ipynb
```

> To be determined whether the automated execution works well enough.

### Testing of notebooks (nbval)

Use [nbval](https://github.com/computationalmodelling/nbval) to just verify that notebooks complete without error (`nbval-lax`). nbval can also verify that cell outputs do not change, but that would be overly complicated to work with as the outputs will often change (e.g. change in progress bars, change in exact figure contents).

Quickstart:

- `pip install pytest nbval`
- `pytest --nbval-lax *.ipynb`
- Mark cells to be skipped with `# NBVAL_SKIP` like:

```
# NBVAL_SKIP
from viresclient import set_token
set_token("https://vires.services/ows", set_default=True)
# (user is now prompted to enter the token)
```