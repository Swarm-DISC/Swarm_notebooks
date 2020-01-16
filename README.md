# Swarm_notebooks
Notebooks demonstrating access to Swarm data for scientific analyses. To be deployed on the VRE. For more info, and to view them, go to https://swarm-vre.readthedocs.io/en/staging/notebooks_preface.html

## Managing the git branches

There are two branches: `dev` for clean commits (i.e. without cell outputs in the notebooks), and `master` which is periodically rebased to `dev` with an amended commit containing the executed state of the notebooks (i.e. including cell outputs for convenient viewing).

[(Reference for the motivation and more detail)](https://mg.readthedocs.io/git-jupyter.html#making-a-change)

Switch to the dev branch and make changes (*NB: ensure they are without cell outputs*)
```
git checkout dev
git add ...
git commit ...
git push ...
```

After some number of commits on dev, and you are ready to deploy the executed state on master, then: rebase the master branch to the current dev, execute the notebooks, and update the commit on master and push it
```
git checkout master
git rebase -X ours dev
<manually execute the notebooks, or use nbconvert>
git commit -a --amend
git push --force
```
