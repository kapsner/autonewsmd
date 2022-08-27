# Auto-Generate Changelog using Conventional Commits
# Copyright (C) 2022 Lorenz A. Kapsner
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

test_that("correct functioning of autonewsmd", {

  # (Example is based on the public examples from the `git2r` R package)
  ## Initialize a repository
  path <- tempdir()
  repo <- git2r::init(path)

  ## Config user
  git2r::config(repo, user.name = "Alice", user.email = "alice@example.org")
  git2r::remote_set_url(repo, "foobar", "https://example.org/git2r/foobar")


  ## Write to a file and commit
  lines <- "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do"
  writeLines(lines, file.path(path, "example.txt"))

  git2r::add(repo, "example.txt")
  git2r::commit(repo, "feat: new file")

  ## Write again to a file and commit
  lines2 <- paste0(
    "eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ",
    "nisi ut aliquip ex ea commodo consequat."
  )
  write(lines2, file.path(path, "example.txt"), append = TRUE)

  git2r::add(repo, "example.txt")
  Sys.sleep(2) # wait two seconds, otherwise, commit messages have same
  # time stamp
  git2r::commit(repo, "refactor: added second phrase")

  #### work with autonewsmd
  an <- autonewsmd$new(repo_name = "TestRepo", repo_path = path)
  an$generate()

  expect_type(an$repo_list, "list")
  expect_length(an$repo_list, 1)
  expect_length(an$repo_list[["Unreleased"]], 7)

  an$write()

  expect_true(all(sapply(
    X = list.files(path),
    FUN = function(x) {
      x %in% c("example.txt", "NEWS.md")
    })
  ))

  ## check tags
  git2r::tag(repo, "r1.2.3")
  an <- autonewsmd$new(repo_name = "TestRepo", repo_path = path)

  expect_error(
    an$generate(),
    regexp = "No tags found that match the provided tag pattern"
  )

  ## check file endings
  an <- autonewsmd$new(repo_name = "TestRepo", repo_path = path)
  an$file_ending <- ".txt"
  an$tag_pattern <- "^r(\\d+\\.){2}\\d+(\\.\\d+)?$"
  an$generate()
  an$write()
  expect_length(list.files(path = path, pattern = "^NEWS\\.txt$"), 1)

  an <- autonewsmd$new(repo_name = "TestRepo", repo_path = path)
  an$file_ending <- ""
  an$tag_pattern <- "^r(\\d+\\.){2}\\d+(\\.\\d+)?$"
  an$generate()
  an$write()
  expect_length(list.files(path = path, pattern = "^NEWS$"), 1)

  # clean up
  do.call(
    file.remove,
    list(list.files(path, full.names = TRUE))
  )
})
