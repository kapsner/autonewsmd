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

prepare_rda <- function(self, private) {

  stopifnot(
    "`repo_list` is missing or `NULL`" = !is.null(self$repo_list),
    "`repo_url` is missing or `NULL`" = !is.null(private$repo_url)
  )

  repo_list <- self$repo_list
  repo_url <- private$repo_url
  repo_name <- self$repo_name
  file_name <- self$file_name

  save(
    repo_list, repo_name, repo_url, file_name, mdtemplate_tags_decreasing,
    file = file.path(tempdir(), "autonewsmd.Rda")
  )
}
