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

get_git_log <- function(repo, repo_url, tag_pattern, type_mappings) {

  # load whole git-history into a data.table
  repo_df <- git2r::as.data.frame(repo) %>%
    data.table::as.data.table()

  # generate 7-char sha
  repo_df[, ("sha_seven") := substr(
    x = get("sha"),
    start = 1,
    stop = 7)
  ]

  # identify the conventional commits
  for (tm in names(type_mappings)) {
    pattern <- paste0("^", tm)
    repo_df[
      grepl(pattern = pattern, x = get("summary")),
      `:=` (
        # set the human readable type, used as subheadings
        "type" = type_mappings[tm],
        # clean up the commit summary
        "clean_summary" = gsub(
          pattern = pattern,
          replacement = "",
          x = get("summary")
        )
      )
    ]
  }

  # rewrite breaking changes
  repo_df[
    grepl(pattern = "^BREAKING CHANGE: ", x = get("message")),
    ("type") := "Breaking changes"
  ]

  # identify repository tags
  repo_tags <- git2r::tags(repo = repo)

  # default tag-column to NA if no tags available
  if (length(repo_tags) == 0) {
    repo_df[, ("tag") := NA_character_]
  } else {

    if (sum(grepl(pattern = tag_pattern, x = names(repo_tags))) > 0) {
      # reduce tags to those that match the tag-pattern only
      repo_tags <- repo_tags[grep(
        pattern = tag_pattern,
        x = names(repo_tags),
        value = TRUE
      )]

      for (tn in names(repo_tags)) {
        if (nrow(repo_df[get("sha") == repo_tags[[tn]]$target, ]) > 0) {
          repo_df[get("sha") == repo_tags[[tn]]$target, ("tag") := tn]
        } else if (nrow(repo_df[get("sha") == repo_tags[[tn]]$sha, ]) > 0) {
          repo_df[get("sha") == repo_tags[[tn]]$sha, ("tag") := tn]
        } else {
          warning(paste0(
            "An error occurred identifying commit target of tag '", tn, "'."
          ))
        }
      }

    } else {
      stop(paste0(
        "No tags found that match the provided tag pattern '",
        tag_pattern, "'.\nAvailable tags are: ",
        paste0(names(repo_tags), collapse = ", ")
      ))
    }
  }

  # now ensure that all commits in the data.table are sorted decreasingly
  repo_df <- repo_df[order(get("when"), decreasing = TRUE)]

  # assign each commit to a specific tag
  set_tag <- NULL
  for (i in seq_len(nrow(repo_df))) {
    sha_belongs_to_tag <- repo_df[i, get("tag")]
    if (!is.na(sha_belongs_to_tag)) {
      set_tag <- sha_belongs_to_tag
    } else if (is.na(sha_belongs_to_tag)) {
      if (i == 1) {
        set_tag <- "Unreleased"
      }
      stopifnot(!is.null(set_tag))
      repo_df[i, ("tag") := set_tag]
    }
  }

  # add a before-tag to each commit that indicates to which tag the previous
  # commit belongs; this is necessary to get the information on the full set
  # of changes between two releases
  repo_df[, ("tag_before") := c(repo_df$tag[2:nrow(repo_df)], NA_character_)]

  # create the repo-list that builds the data model for writing the changelog
  # file
  repo_list <- list()

  # iterate over all identified tags
  for (tn in unique(repo_df$tag)) {

    # init empty list for this tag
    append_list <- list()
    # add relevant commits
    append_list[["commits"]] <- repo_df[get("tag") == tn, ]

    # get the most recent date for this commit; if unreleased, the date of the
    # most recent commit, if tagged, the date of the tag
    ld <- append_list[["commits"]][
      which.max(get("when")),
      as.Date.character(x = get("when"), format = "%Y-%m-%d")
    ]
    append_list[["latest_date"]] <- as.character(ld)

    # if there are more than one commits, one can create a set of changes to
    # be viewed on git between the last release and the most recent commit
    if (nrow(append_list[["commits"]]) > 1) {
      # save first and last commit sha to list-entries
      append_list[["sha_from"]] <- append_list[["commits"]][
        which.min(get("when")), get("sha")
      ]
      append_list[["sha_to"]] <- append_list[["commits"]][
        which.max(get("when")), get("sha")
      ]

      # save tag before this release began to a field
      append_list[["tag_from"]] <- append_list[["commits"]][
        which.min(get("when")), get("tag_before")
      ]
      append_list[["tag_to"]] <- append_list[["commits"]][
        which.max(get("when")), get("tag_before")
      ]

      if (is.na(append_list[["tag_from"]])) {
        append_list[["tag_from"]] <- append_list[["commits"]][
          which.min(get("when")), get("sha_seven")
        ]
      } else if (append_list[["tag_from"]] == "Unreleased") {
        append_list[["tag_from"]] <- append_list[["commits"]][
          which.min(get("when")), get("sha_seven")
        ]
      }
      if (append_list[["tag_to"]] == "Unreleased") {
        append_list[["tag_to"]] <- append_list[["commits"]][
          which.max(get("when")), get("sha_seven")
        ]
      }

      # format the url for the full set of changes
      set_changes <- paste0(
        append_list[["tag_from"]], "...", append_list[["tag_to"]]
      )
      append_list[["full_changes"]] <- paste0(
        "Full set of changes:\ [`", set_changes,
        "`](", file.path(repo_url, "compare", set_changes), ")"
      )
    }
    repo_list[[tn]] <- append_list
  }
  return(repo_list)
}
