# Local collection install conflict between ansible-lint and molecule

This repo serves as a reproducer for [ansible-lint#2265](https://github.com/ansible/ansible-lint/issues/2265).

## Setup

You will need a python environment with both `ansible-lint` and `molecule` installed. As a convenience, a Makefile
target is provided that will set up a virtual environment and install the required packages. To use this, simply run

```
$ make venv
$ . venv/bin/activate
```

## Reproducing the bug

The bug manifests both when `molecule` followed by `ansible-lint` and when running `ansible-lint` followed by `molecule`. Makefile
targets are provided to reproduce both these scenarios. In both cases, the `XDG_CACHE_HOME` environment variable will be overriden
to avoid any interference between the two scenarios.

### molecule first

To reproduce the bug when `molecule` is run first, execute:

```
$ make molecule_then_lint
```

The `XDG_CACHE_HOME` environment variable will be set to `cache/molecule-then-lint`.

### ansible-lint first

To reproduce the bug when `ansible-lint` is run first, execute:

```
$ make lint_then_molecule
```

The `XDG_CACHE_HOME` environment variable will be set to `cache/lint-then-molecule`.

## The example collection

The example collection was created with `ansible-galaxy collection init example.lint_vs_molecule`

The only changes subsequently made to the collection were:
- Delete superflous directories (`docs` and `plugins`)
- Create a `dummy` role with a single task
- Clean up the generated `galaxy.yml` and fill in some details
- Add some information to `README.md`
- Add a basic molecule scenario with `molecule init scenario`
    - Update the `molecule/default/converge.yml` playbook to include the `example.lint_vs_molecule.dummy` role
