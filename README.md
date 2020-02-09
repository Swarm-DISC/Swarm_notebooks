# Swarm_notebooks

Notebooks demonstrating access to Swarm data for scientific analyses. To be deployed on the VRE. For more info, and to view them, go to https://swarm-vre.readthedocs.io/en/staging/notebooks_preface.html

## Managing the git branches

There are two branches: `dev` for clean commits (i.e. **without cell outputs** in the notebooks), and `master` which is periodically rebased to `dev` with an amended commit containing the *executed state* of the notebooks (i.e. **including cell outputs** for convenient viewing).

[(Reference for the motivation and more detail)](https://mg.readthedocs.io/git-jupyter.html#making-a-change)

To add or update a notebook, switch to the dev branch:

```
git checkout dev
```

then do some work on notebook(s), clear all outputs and save them, (or use [nbstripout](https://github.com/kynan/nbstripout)). *Ensure they are without cell outputs*, then commit the changes:

```
git add ...
git commit ...
git push ...
```

After some number of commits on dev, and you are ready to deploy the executed state on master, then: rebase the master branch to the current dev, execute the notebooks, amend the commit on master

```
git checkout master
git rebase -X ours dev
 <manually execute the notebooks, or use nbconvert>
git commit -a --amend
git push --force
```

## Execution of notebooks (nbconvert)

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

## Testing of notebooks (nbval)

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