[![Build
documents](https://github.com/bergentroll/pali-english-recitations/actions/workflows/building.yaml/badge.svg)](https://github.com/bergentroll/pali-english-recitations/actions/workflows/building.yaml)

# GitHub Actions for the Pāli-English Recitations

## Description

The dirctory contains all necessary files for GitHub CI Actions.

[Dockerfile](./Dockerfile) is used to maintain a GNU/Linux environment to build
documents. The pipeline fetching a docker image from the https://hub.docker.com
hub, so an updated image should be uploaded. To build an image run the
following command in this directory:

```shell
docker image build --tag 'image_name:tag' --compress --force-rm .
```

The pipeline may be ran locally with the [act](https://github.com/nektos/act)
tool. To do so run `act` at root of the repository with a trigger name
(Docker is required):

```shell
act push -v
```

The `-v` key for verbose output.

## TODO list

- Fix epub metadata validation error
- Use local `epubcheck` if already in `$PATH`
