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

if (dir.exists("../../R")) {
  prefix <- "../../"
} else if (dir.exists("./R")) {
  prefix <- "./"
}

test_that(
  desc = "test lints",
  code = {
    skip_on_cran()
    skip_if(dir.exists("../../00_pkg_src"))
    lintr::expect_lint_free(path = prefix)
  })
