

# autonewsmd

<!-- badges: start -->

[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![](https://www.r-pkg.org/badges/version/autonewsmd)](https://cran.r-project.org/package=autonewsmd)
[![CRAN
checks](https://badges.cranchecks.info/worst/autonewsmd.svg)](https://cran.r-project.org/web/checks/check_results_autonewsmd.html)
[![](http://cranlogs.r-pkg.org/badges/grand-total/autonewsmd?color=blue)](https://cran.r-project.org/package=autonewsmd)
[![](http://cranlogs.r-pkg.org/badges/last-month/autonewsmd?color=blue)](https://cran.r-project.org/package=autonewsmd)
[![Dependencies](https://tinyverse.netlify.app/badge/autonewsmd)](https://cran.r-project.org/package=autonewsmd)
[![R build
status](https://github.com/kapsner/autonewsmd/workflows/R%20CMD%20Check%20via%20%7Btic%7D/badge.svg)](https://github.com/kapsner/autonewsmd/actions)
[![R build
status](https://github.com/kapsner/autonewsmd/workflows/lint/badge.svg)](https://github.com/kapsner/autonewsmd/actions)
[![R build
status](https://github.com/kapsner/autonewsmd/workflows/test-coverage/badge.svg)](https://github.com/kapsner/autonewsmd/actions)
[![](https://codecov.io/gh/https://github.com/kapsner/autonewsmd/branch/main/graph/badge.svg)](https://app.codecov.io/gh/https://github.com/kapsner/autonewsmd)
<!-- badges: end -->

The purpose of the `autonewsmd` R package is to bring the power of
conventional commit messages to the R community. There is no need
anymore to tediously maintain a changelog file manually. If you are
using conventional commit messages, `autonewsmd` will do that for you
and automatically generate a human readable changelog file directly from
the repository’s git history.

Conventional commit messages
(<https://www.conventionalcommits.org/en/v1.0.0/>) come with some easy
rules to create human readable commit messages for a git history. One
advantage is that following these conventions, these messages are also
machine readable and automated tools can run on top of them in order to,
e.g., generate beautiful changelogs out of them. Similar tools written
in other programming languages are, for example,
[`auto-changelog`](https://github.com/cookpete/auto-changelog) for
JavaScript and
[`auto-changelog`](https://github.com/KeNaCo/auto-changelog) for Python.

## Installation

You can install `autonewsmd` with:

``` r
install.packages("autonewsmd")
```

You can install the development version of `autonewsmd` with:

``` r
install.packages("remotes")
remotes::install_github("kapsner/autonewsmd")
```

## Supported Commit Types

The default changelog template organizes commits according to their
association with specific tags. The tags form the headings of the
changelog file and are sorted in decreasing order according to their
release dates. The following table lists the commit types that are
currently supported by `autonewsmd`. To be correctly recognized by
`autonewsmd`, it is important that the formatting of the commit messages
follow the conventions described
[here](https://www.conventionalcommits.org/en/v1.0.0/#commit-message-with--to-draw-attention-to-breaking-change).

<center>

| Type      | Changelog Subheading |
|-----------|----------------------|
| feat:     | New features         |
| fix:      | Bug fixes            |
| refactor: | Refactorings         |
| perf:     | Performance          |
| build:    | Build                |
| test:     | Tests                |
| ci:       | CI                   |
| docs:     | Docs                 |
| style:    | Style                |
| chore:    | Other changes        |

</center>

If any commit type includes `BREAKING CHANGE` in its commit message’s
body or footer, the subheading **`Breaking changes`** is included as
first subheading within the respective sections. Furthermore, the
detection of breaking changes using the exclamation mark (`!`) between
the type description and the colon (as described
[here](https://www.conventionalcommits.org/en/v1.0.0/#commit-message-with--to-draw-attention-to-breaking-change))
is supported as well.

## Example

First of all, create a small repository with some commit messages.

``` r
library(autonewsmd)

# (Example is based on the public examples from the `git2r` R package)
## Initialize a repository
path <- file.path(tempdir(), "autonewsmd")
dir.create(path)
repo <- git2r::init(path)

## Config user
git2r::config(repo, user.name = "Alice", user.email = "alice@example.org")
git2r::remote_set_url(repo, "foobar", "https://example.org/git2r/foobar")

## Write to a file and commit
lines <- "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do"
writeLines(lines, file.path(path, "example.txt"))

git2r::add(repo, "example.txt")
git2r::commit(repo, "feat: new file example.txt")

## Write again to a file and commit
Sys.sleep(2) # wait two seconds, otherwise, commit messages have same time stamp
lines2 <- paste0(
  "eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
  "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ",
  "nisi ut aliquip ex ea commodo consequat."
)
write(lines2, file.path(path, "example.txt"), append = TRUE)

git2r::add(repo, "example.txt")
git2r::commit(repo, "refactor: added second phrase")

## Also add a tag here
git2r::tag(repo, "v0.0.1")
```

Then, instantiate an `autonewsmd` object. Here, you must provide the
`repo_name` (this argument is used to compose the title of the changelog
file). The `repo_path`-argument can be provided optionally and defaults
to the current working directory (`"."`). The `repo_path` should be the
root of a git repository. The `$generate()`-method creates a list with
all commit messages that is used for rendering the changelog file.

``` r
an <- autonewsmd$new(repo_name = "TestRepo", repo_path = path)
an$generate()
```

Executing the `$write()`-method, the changelog is written to the path
specified with the `repo_path`-argument. If `force = FALSE` (the
default), a dialog is prompted to ask the user if the file should be
(over-) written.

``` r
an$write(force = TRUE)
```

Now, we can verify that the file `NEWS.md` also appears in the git
folder and check its content.

``` r
list.files(path)
#> [1] "example.txt" "NEWS.md"
```

``` r
newsmd <- readLines(file.path(path, "NEWS.md"))
newsmd
#>  [1] "# TestRepo NEWS"
#>  [2] ""
#>  [3] "## v0.0.1 (2022-08-27)"
#>  [4] ""
#>  [5] "#### New features"
#>  [6] ""
#>  [7] "-   new file"
#>  [8] "    ([22b8453](https://example.org/git2r/foobar/tree/22b845346a0f3686d79eb86445af6be71dc86da6))"
#>  [9] ""
#> [10] "#### Refactorings"
#> [11] ""
#> [12] "-   added second phrase"
#> [13] "    ([ec510eb](https://example.org/git2r/foobar/tree/ec510ebb465d25ab7ad27e8b637cf4113b55cbdf))"
#> [14] ""
#> [15] "Full set of changes:"
#> [16] "[`22b8453...v0.0.1`](https://example.org/git2r/foobar/compare/22b8453...v0.0.1)"
```

## Pre-Commit Hook

The functionality of `autonewsmd` is also available as a pre-commit hook
(for more background information on pre-commit please visit
<https://pre-commit.com/>). To use `autonewsmd` as pre-commit hook, just
add the following snippet to your project’s
[.pre-commit-config.yaml](.pre-commit-config.yaml).

``` yaml
- repo: https://github.com/kapsner/autonewsmd
  rev: v0.1.0.9002
  hooks:
  - id: recreate-changelog
    args: [ --file_name=NEWS ]  # 'NEWS' is the default value. Can be changed to e.g. 'CHANGELOG'
```

## Used By

[autonewsmd](https://github.com/kapsner/autonewsmd/blob/main/NEWS.md),
[sjtable2df](https://github.com/kapsner/sjtable2df/blob/main/NEWS.md),
[rBiasCorrection](https://github.com/kapsner/rBiasCorrection/blob/master/NEWS.md),
[BiasCorrector](https://github.com/kapsner/BiasCorrector/blob/master/NEWS.md),
[DIZtools](https://github.com/miracum/misc-diztools/blob/main/NEWS.md),
[DIZutils](https://github.com/miracum/misc-dizutils/blob/master/NEWS.md),
[DQAstats](https://github.com/miracum/dqa-dqastats/blob/master/NEWS.md),
[DQAgui](https://github.com/miracum/dqa-dqagui/blob/master/NEWS.md),
[miRacumDQA](https://github.com/miracum/dqa-miracumdqa/blob/master/NEWS.md),
[kdry](https://github.com/kapsner/kdry/blob/main/NEWS.md),
[mlexperiments](https://github.com/kapsner/mlexperiments/blob/main/NEWS.md),
[mllrnrs](https://github.com/kapsner/mllrnrs/blob/main/NEWS.md),
[mlsurvlrnrs](https://github.com/kapsner/mlsurvlrnrs/blob/main/NEWS.md)
[authors-block](https://github.com/kapsner/authors-block/blob/main/NEWS.md)

**(If you are using `autonewsmd` and you like to have your repository
listed here, please add the link pointing to the changelog file to this
[`README.md`](./README.md) and create a pull request.)**

## Related R Packages

- [`newsmd`](https://github.com/Dschaykib/newsmd): manually add updates
  (version or bullet points) to the NEWS.md file
- [`fledge`](https://github.com/cynkra/fledge): to streamline the
  process of updating changelogs (NEWS.md) and versioning R packages
  developed in git repositories (also supporting conventional commits)
- [`git-sv`](https://github.com/thegeeklab/git-sv): is a semantic
  versioning tool for git based on conventional commits written in Go

## TODOs:

- add options to format the changelog
- add more changelog style templates
- add support for [Commit message with
  scope](https://www.conventionalcommits.org/en/v1.0.0/#commit-message-with-scope)
