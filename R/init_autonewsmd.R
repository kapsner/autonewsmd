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

init_autonewsmd <- function(self, private, repo_name, repo_path, repo_remotes) {
  stopifnot(
    is.character(repo_name),
    ifelse(
      test = is.null(repo_remotes),
      yes = TRUE,
      no = is.character(repo_remotes)
    ),
    ifelse(
      test = is.null(repo_path),
      yes = TRUE,
      no = is.character(repo_path) && dir.exists(repo_path)
    )
  )
  if (is.null(repo_path)) {
    message(
      "No 'repo_path' provided. Setting 'repo_path' to '.'."
    )
    repo_path <- "."
  }
  self$repo_name <- repo_name
  private$repo_path <- normalizePath(repo_path)
  private$repo <- git2r::repository(path = private$repo_path)
  repo_url <- git2r::remote_url(
    repo = private$repo,
    remote = repo_remotes
  )
  private$repo_url <- gsub(
    pattern = "\\.git$",
    replacement = "",
    x = repo_url
  )
}
