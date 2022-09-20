# nolint start

repo_dir <- file.path(tempdir(), "debugging")
git2r::clone(
  url = "https://github.com/kapsner/rpkgTemplate",
  local_path = repo_dir
)

an <- autonewsmd::autonewsmd$new("Test", repo_path = repo_dir)
debug(an$generate)
an$generate()

# nolint end
