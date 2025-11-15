tempfile <- file.path(tempdir(), "../.commit_temp_helper")

if (!file.exists(tempfile)) {
  file.create(tempfile)
  Sys.chmod(tempfile, mode = "0644")
}
