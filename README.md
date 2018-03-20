# Point cloud related conda recipes

Work in progress to build conda packages for pdal and dependencies 

## Trying it out

`conda install -c mathieu pdal`

or using an environemnt specification by creating an `environment.yml` file as follows:

```yaml
# environment.yml

name: pdal-env
channels:
  - mathieu
  - conda-forge
dependencies:
  - python=3.6
  - pdal
```


and run `conda env create -f environment.yml`
