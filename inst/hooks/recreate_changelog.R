
"Recreate CHANGELOG.md during a precommit.
Usage:
  recreate_changelog.R [options] ... 

Options:
  --file_name Set the `file_name` argument of `autonewsmd()` (defaults to 'NEWS')

" -> doc

if (!("precommit" %in% installed.packages()[, "Package"])) {
  install.packages("precommit")
}

arguments <- precommit::precommit_docopt(doc)

if (arguments$file_name) {
  filename <- arguments$file_name
} else {
  filename <- "NEWS"
}

tempfile <- file.path(tempdir(), "../.commit_temp_helper")

if (file.exists(tempfile)) {
  file.remove(tempfile)
  an <- autonewsmd::autonewsmd$new(
    repo_name = basename(getwd()),
    file_name = filename
  )
  an$generate()
  an$write(force = TRUE)

  system(paste0(
    "git add ", filename, ".md ",
    "git commit --amend --no-edit --no-verify"
  ))
}
