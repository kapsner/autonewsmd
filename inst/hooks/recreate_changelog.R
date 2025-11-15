
"Recreate CHANGELOG.md during a precommit.
Usage:
  recreate_changelog.R [options] ... 

Options:
  --repo_remotes The remotes-repositorie's URL
  --file_name Set the `file_name` argument of `autonewsmd()` (defaults to 'NEWS')

" -> doc

for (req_pkg in c("precommit", "docopt", "autonewsmd", "git2r")) {
  if (!(req_pkg %in% installed.packages()[, "Package"])) {
    install.packages(req_pkg)
  }
}

arguments <- precommit::precommit_docopt(doc)

if (length(arguments$file_name) > 0) {
  filename <- arguments$file_name
} else {
  filename <- "NEWS"
}

if (length(arguments$repo_remotes) > 0) {
  repo_remotes <- arguments$repo_remotes
} else {
  repo_remotes <- NULL
}

tempfile <- file.path(tempdir(), "../.commit_temp_helper")

if (file.exists(tempfile)) {
  file.remove(tempfile)
  args <- list(repo_name = basename(getwd()))
  if (!is.null(repo_remotes)) {
    args$repo_remotes <- repo_remotes
  }
  an <- do.call(autonewsmd::autonewsmd$new, args)
  an$file_name <- filename
  an$generate()
  an$write(force = TRUE)

  system(paste0(
    "git add ", filename, ".md ",
    "git commit --amend --no-edit --no-verify"
  ))
}
