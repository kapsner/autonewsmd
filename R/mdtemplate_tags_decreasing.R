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

mdtemplate_tags_decreasing <- function(repo_list, change_hierarchy, repo_url) {

  for (tag in names(repo_list)) {
    rl <- repo_list[[tag]]
    cat(paste0("\n## ", tag, " (", rl[["latest_date"]], ")"), "\n\n")
    for (chg in change_hierarchy) {
      # get commits of type with a clean summary (ensuring formatting according
      # to conventional commit style)
      chg_commits <- rl$commits[
        get("type") == chg & !is.na(get("clean_summary")),
      ]
      if (nrow(chg_commits) > 0) {
        cat(paste0("\n#### ", chg), "\n\n")
        for (chg_row in seq_len(nrow(chg_commits))) {
          # create commit list
          cat(paste0(
            "- ", chg_commits[chg_row, get("clean_summary")], " ([",
            chg_commits[chg_row, get("sha_seven")], "](",
            file.path(repo_url, "tree", chg_commits[chg_row, get("sha")]), "))"
          ), "\n")
        }
      }
    }
    if (!is.null(rl[["full_changes"]])) {
      cat("\n", rl[["full_changes"]], "\n\n")
    }
  }
}
