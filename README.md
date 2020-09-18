# Swarm_notebooks

[![VRE-Interact](https://img.shields.io/badge/interact-VRE-blue)](https://vre.vires.services/user-redirect/lab/tree/shared/Swarm_notebooks/02a__Intro-Swarm-viresclient.ipynb "Run notebooks on the ESA Swarm Virtual Research Environment")
[![Treebeard notebook status](https://api.treebeard.io/Swarm-DISC/Swarm_notebooks/master/buildbadge)](https://treebeard.io/admin/Swarm-DISC/Swarm_notebooks/master "View the latest notebook run")

Notebooks demonstrating access to Swarm data for scientific analyses. For more info, and to view them, go to https://swarm-vre.readthedocs.io/en/master/notebooks_preface.html

## Contributing

A proper contributing guide is in progress. If interested please contact ashley.smith@ed.ac.uk

Notebooks are stored in the git repo with outputs cleared. To clear notebook outputs:
```python
jupyter nbconvert --clear-output --inplace *.ipynb
```
(requires nbconvert >=6.0)

Notebooks are picked up by Treebeard and executed, with the outputs viewable within the Swarm-VRE docs.