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

#' R6 Class to construct the changelog file
#'
#' @description
#' The `autonewsmd` class is used to construct a new changelog file, set all
#'   required metadata and to generate the file and save it to the root-
#'   directory of the respective repository.
#'
#' @details
#' The changelog file has a title that typically includes the name of the
#'   repository, which needs at least to be provided when constructing a new
#'   changelog file.
#'
#' @examples
#' # (Example is based on the public examples from the `git2r` R package)
#' ## Initialize a repository
#' path <- file.path(tempdir(), "autonewsmd")
#' dir.create(path)
#' repo <- git2r::init(path)
#'
#' ## Config user
#' git2r::config(repo, user.name = "Alice", user.email = "alice@example.org")
#' git2r::remote_set_url(repo, "foobar", "https://example.org/git2r/foobar")
#'
#'
#' ## Write to a file and commit
#' lines <- "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do"
#' writeLines(lines, file.path(path, "example.txt"))
#'
#' git2r::add(repo, "example.txt")
#' git2r::commit(repo, "feat: new file")
#'
#' ## Write again to a file and commit
#' lines2 <- paste0(
#'   "eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
#'   "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ",
#'   "nisi ut aliquip ex ea commodo consequat."
#' )
#' write(lines2, file.path(path, "example.txt"), append = TRUE)
#'
#' git2r::add(repo, "example.txt")
#' git2r::commit(repo, "refactor: added second phrase")
#'
#' ## now construct a new autonewsmd object
#' an <- autonewsmd$new(repo_name = "TestRepo", repo_path = path)
#'
#' ## generate the news and write them to the repo
#' an$generate()
#'
#' if (interactive()) {
#'   an$write()
#' }
#'
#' @export

autonewsmd <- R6::R6Class(
  "autonewsmd",
  public = list(

    #' @field repo_name A character. The name of the repository, which is
    #'   inserted into the title of the changelog file.
    repo_name = NULL,

    #' @field tag_pattern A character. A regular expression pattern to identify
    #'   release tags in the repository.
    #'   Defaults to `"^v(\\d+\\.){2}\\d+(\\.\\d+)?$"` to identify patterns of
    #'   the from `v0.0.1.9001`.
    tag_pattern = "^v(\\d+\\.){2}\\d+(\\.\\d+)?$",

    #' @field repo_list The list contains the commit messages prepared for
    #'   the changelog file.
    repo_list = NULL,

    #' @field file_name A character. The name of the file, which is
    #'   inserted into the title of the changelog file. Defaults to `"NEWS"`
    #'   (typically one of `"NEWS"` or `"CHANGELOG"`).
    file_name = "NEWS",

    #' @field file_ending A character. The file ending of the file the
    #'   changelog should be written to. Defaults to `".md"`.
    file_ending = ".md",

    #' @description
    #' Create a new `autonewsmd` object.
    #' @param repo_name A character. The name of the repository, which is
    #'   inserted into the title of the changelog file.
    #' @param repo_path A character. The path of the repository to create a new
    #'   changelog for. If `NULL` (the default), it will point automatically to
    #'   to `"."`.
    #' @param repo_remotes A character. The name of the tracked repository that
    #'   should be used to get the repository's URL (e.g. when executing
    #'   `git remote -v` in the shell). Defaults to `NULL`.
    #' @return A new `autonewsmd` object.
    #'
    #' @examples
    #' # (Example is based on the public examples from the `git2r` R package)
    #' ## Initialize a repository
    #' path <- file.path(tempdir(), "autonewsmd")
    #' dir.create(path)
    #' repo <- git2r::init(path)
    #'
    #' ## Config user
    #' git2r::config(
    #'   repo, user.name = "Alice", user.email = "alice@example.org"
    #' )
    #' git2r::remote_set_url(repo, "foobar", "https://example.org/git2r/foobar")
    #'
    #'
    #' ## Write to a file and commit
    #' lines <- paste0(
    #'   "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do"
    #' )
    #' writeLines(lines, file.path(path, "example.txt"))
    #'
    #' git2r::add(repo, "example.txt")
    #' git2r::commit(repo, "feat: new file")
    #'
    #' ## Write again to a file and commit
    #' lines2 <- paste0(
    #'   "eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
    #'   "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ",
    #'   "nisi ut aliquip ex ea commodo consequat."
    #' )
    #' write(lines2, file.path(path, "example.txt"), append = TRUE)
    #'
    #' git2r::add(repo, "example.txt")
    #' git2r::commit(repo, "refactor: added second phrase")
    #'
    #' ## now construct a new autonewsmd object
    #' an <- autonewsmd$new(repo_name = "TestRepo", repo_path = path)
    #'
    initialize = function(
      repo_name,
      repo_path = NULL,
      repo_remotes = NULL
    ) {
      init_autonewsmd(self, private, repo_name, repo_path, repo_remotes)
    },

    #' @description
    #' Generate the list with the formatted commit messages that is used to
    #'   render the changelog.
    #' @details The function generates the formatted list with the commit
    #'   messages. If tags are available, each commit message is assigned to a
    #'   specific tag. These assignments are used to structure the changelog
    #'   document.
    #' @return Populates the public field `repo_list`.
    #'
    #' @examples
    #' # (Example is based on the public examples from the `git2r` R package)
    #' ## Initialize a repository
    #' path <- file.path(tempdir(), "autonewsmd")
    #' dir.create(path)
    #' repo <- git2r::init(path)
    #'
    #' ## Config user
    #' git2r::config(
    #'   repo, user.name = "Alice", user.email = "alice@example.org"
    #' )
    #' git2r::remote_set_url(repo, "foobar", "https://example.org/git2r/foobar")
    #'
    #'
    #' ## Write to a file and commit
    #' lines <- paste0(
    #'   "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do"
    #' )
    #' writeLines(lines, file.path(path, "example.txt"))
    #'
    #' git2r::add(repo, "example.txt")
    #' git2r::commit(repo, "feat: new file")
    #'
    #' ## Write again to a file and commit
    #' lines2 <- paste0(
    #'   "eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
    #'   "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ",
    #'   "nisi ut aliquip ex ea commodo consequat."
    #' )
    #' write(lines2, file.path(path, "example.txt"), append = TRUE)
    #'
    #' git2r::add(repo, "example.txt")
    #' git2r::commit(repo, "refactor: added second phrase")
    #'
    #' ## now construct a new autonewsmd object
    #' an <- autonewsmd$new(repo_name = "TestRepo", repo_path = path)
    #'
    #' ## generate the news and write them to the repo
    #' an$generate()
    #'
    generate = function() {
      generate_autonewsmd(self, private)
    },

    #' @description
    #' Writes the changelog to the file system.
    #' @details This function writes the changelog to the file system using the
    #'   `file_name` and `file_ending` fields to compose the file name.
    #'   CAUTION: existing files will be overwritten without any warning.
    #' @param force A boolean. If `FALSE` (the default) a dialog is prompted to
    #'   ask the user if the file should be (over-) written. If `TRUE`, the
    #'   dialog is not prompted and the changelog file is created directly.
    #' @param con A connection with the answer to the interactive question, if
    #'   the changelog file should be written to the file system. This argument
    #'   is intended mainly for being used in the unit tests.
    #' @return The function has no return value - it creates the new changelog
    #'   file.
    #'
    #' @examples
    #' # (Example is based on the public examples from the `git2r` R package)
    #' ## Initialize a repository
    #' path <- tempdir()
    #' repo <- git2r::init(path)
    #'
    #' ## Config user
    #' git2r::config(
    #'   repo, user.name = "Alice", user.email = "alice@example.org"
    #' )
    #' git2r::remote_set_url(repo, "foobar", "https://example.org/git2r/foobar")
    #'
    #'
    #' ## Write to a file and commit
    #' lines <- paste0(
    #'   "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do"
    #' )
    #' writeLines(lines, file.path(path, "example.txt"))
    #'
    #' git2r::add(repo, "example.txt")
    #' git2r::commit(repo, "feat: new file")
    #'
    #' ## Write again to a file and commit
    #' lines2 <- paste0(
    #'   "eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
    #'   "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ",
    #'   "nisi ut aliquip ex ea commodo consequat."
    #' )
    #' write(lines2, file.path(path, "example.txt"), append = TRUE)
    #'
    #' git2r::add(repo, "example.txt")
    #' git2r::commit(repo, "refactor: added second phrase")
    #'
    #' ## now construct a new autonewsmd object
    #' an <- autonewsmd$new(repo_name = "TestRepo", repo_path = path)
    #'
    #' ## generate the news and write them to the repo
    #' an$generate()
    #'
    #' if (interactive()) {
    #'   an$write()
    #' }
    #'
    write = function(force = FALSE, con = NULL) {
      write_autonewsmd(self, private, force, con)
    }
  ),

  private = list(
    repo = NULL,
    repo_url = NULL,
    repo_path = NULL,
    # mapping list for the conventional commit types
    type_mappings = list(
      "feat" = "New features",
      "fix" = "Bug fixes",
      "refactor" = "Refactorings",
      "perf" = "Performance",
      "build" = "Build",
      "test" = "Tests",
      "ci" = "CI",
      "docs" = "Docs",
      "style" = "Style",
      "chore" = "Other changes"
    )
  )
)
