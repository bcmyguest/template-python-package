# CLAUDE.md

template-python-package: __DESCRIPTION__

uv project, `src/` layout, hatchling build. Logic lives in typed functions in
`src/template_python_package/`; `main()` only parses arguments and prints.

## Commands

```bash
uv sync --locked
uv run -m pytest
uv run ruff check && uv run ruff format --check
uv run pyrefly check
scripts/version-sync.sh   # pyproject.toml == uv.lock
```

Run Python only through `uv run`. Pre-commit enforces Conventional Commits;
commit types set the release version. Keep `.python-version`,
`requires-python` and `[tool.pyrefly] python-version` in lockstep.

## Releases

Run the **Prepare release** workflow on `main` (tick `dry_run` to preview).
It computes the next version with git-cliff, bumps `pyproject.toml` and
`uv.lock`, tags `vX.Y.Z` and dispatches `release.yml`, which tests, builds the
sdist and wheel, smoke-tests the wheel in a clean environment, uploads to PyPI
when `PUBLISH_PYPI=true` and creates the GitHub release. Never bump the version
by hand.
