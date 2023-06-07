[![Build
documents](https://github.com/bergentroll/pali-english-recitations/actions/workflows/building.yaml/badge.svg)](https://github.com/bergentroll/pali-english-recitations/actions/workflows/building.yaml)

# GitHub Actions for the Pāli-English Recitations

## Description

The directory contains GitHub CI Actions to build artifacts.

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
