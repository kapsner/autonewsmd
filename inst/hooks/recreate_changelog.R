"Recreate CHANGELOG.md during a precommit.
Usage:
  recreate_changelog.R [options] ...

Options:
  --repo_remotes The remote repositorie's name (defaults to 'origin')
  --file_name Set the `file_name` argument of `autonewsmd()` (defaults to 'NEWS')

" -> doc

if (!(requireNamespace("pak"))) {
  install.packages("pak")
}

for (req_pkg in c("autonewsmd", "precommit", "docopt", "git2r")) {
  if (!(requireNamespace(req_pkg))) {
    pak::pkg_install(req_pkg)
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
  repo_remotes <- "origin"
}

args <- list(repo_name = basename(getwd()))
if (!is.null(repo_remotes)) {
  args$repo_remotes <- repo_remotes
}
tryCatch(
  expr = {
    an <- do.call(autonewsmd::autonewsmd$new, args)
    an$file_name <- filename
    an$generate()
    an$write(force = TRUE)

    # append skip string
    append_string <- "recreate-changelog"
    cur_val <- Sys.getenv("SKIP")
    if (cur_val != "") {
      skip_string <- paste0(
        cur_val,
        ",",
        append_string
      )
    } else {
      skip_string <- append_string
    }

    system(paste0(
      "git add ",
      filename,
      ".md && ",
      "SKIP=",
      skip_string,
      " git commit --amend --no-edit --no-verify"
    ))
  },
  error = function(e) {
    warning(e)
  }
)
