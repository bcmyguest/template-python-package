# template-python-package

[![CI](https://github.com/bcmyguest/template-python-package/actions/workflows/ci.yml/badge.svg)](https://github.com/bcmyguest/template-python-package/actions/workflows/ci.yml)

__DESCRIPTION__

<!-- template:start -->
## Using this template

```bash
gh repo create my-pkg --template bcmyguest/template-python-package --private --clone
cd my-pkg
scripts/init.sh my-pkg "One-line description"
git add -A && git commit -m "chore: init from template-python-package"
pre-commit install --install-hooks --hook-type pre-commit --hook-type commit-msg
```

`init.sh` renames `template-python-package` / `template_python_package`
everywhere (including `src/template_python_package/`), fills the description,
sets the owner from the `origin` remote, refreshes `uv.lock`, removes this
section and deletes itself. CI fails while any placeholder remains.

To publish to PyPI: add a pending trusted publisher on pypi.org (this repo,
workflow `release.yml`, environment `pypi`), create the `pypi` environment in
the repo settings, then set the repository variable `PUBLISH_PYPI=true`.
<!-- template:end -->

## Install

```bash
uv tool install template-python-package
```

Each GitHub release also carries the sdist and wheel with SHA-256 files:

```bash
gh release download --repo bcmyguest/template-python-package -p '*.whl'
uv tool install ./template_python_package-*.whl
```

## Usage

```bash
template-python-package Py
# Hello, Py!
```

```python
from template_python_package import greet
```

## License

Apache-2.0
