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

markdown_render <- function(
    repo_list,
    repo_url,
    repo_name,
    repo_path,
    file_name,
    file_ending
  ) {

  rmarkdown::render(
    input = system.file(
      "templates/news-md-template.Rmd",
      package = "autonewsmd"
    ),
    output_file = I(paste0(file_name, file_ending)),
    output_dir = repo_path,
    intermediates_dir = tempdir(),
    knit_root_dir = tempdir()
  )

}
