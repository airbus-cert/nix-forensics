# nix-forensics test suite

This folder contains tests to make sure that all tools bundled in Nix-Forensics work as expected. It should also allow us to catch any regressions when updating tools to their latest version.

We use [BATS](https://github.com/bats-core/bats-core) as our testing framework. See [its documentation](https://bats-core.readthedocs.io/en/stable/index.html) for more information, but the basic idea is that it's a Bash testing framework.

Tests can be run with the following command:

```
$ bash run_tests.sh
```

## Writing tests

If your tests need fixtures (for example, a forensics artifact to process), you can use the `setup_file()` and `teardown_file()` functions to download them and clean them up.

When downloading fixtures, prefer `github.com` or `archive.org` links for reproducibility. Do not link directly to the `master`/`main` branch, but to a specific commit.

Please refrain from pushing fixtures to this repository, as it would bloat up its size.
