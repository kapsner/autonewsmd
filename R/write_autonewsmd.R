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

write_autonewsmd <- function(self, private, force, con) {

  stopifnot(
    !is.null(self$repo_list),
    !is.null(private$repo_url),
    is.logical(force)
  )

  if (isFALSE(force)) {
    full_path <- file.path(
      private$repo_path,
      paste0(self$file_name, self$file_ending)
    )
    msg <- paste0(
      "Do you want to write the file '", full_path, "'?"
    )
    if (file.exists(full_path)) {
      msg <- paste(
        msg, "CAUTION: this overwrites the existing file!",
        sep = "\n"
      )
    }
    msg <- paste(
      msg, "(Use `force = TRUE` to omit this interactive question.)",
      sep = "\n"
    )
    if (is.null(con) && interactive()) {
      answer <- utils::askYesNo(
        msg = message(msg),
        default = NA
      )
    } else if (inherits(con, c("file", "connection"))) {
      # display prompt and options
      optlist <- paste(c("Yes", "no", "cancel"), collapse = "/")
      prompt_opt <- paste0(msg, " (", optlist, ")\n")
      message(prompt_opt)
      read_con <- readLines(con = con, n = 1)
      if (read_con %in% c("Yes", "yes", "y", "ye")) {
        answer <- TRUE
      } else {
        answer <- FALSE
      }
    } else {
      stop(paste0(
        "Please provide a valid connection containing the ",
        "answer to the interactive question, if the newly generated ",
        "changelog file should be written to the file system."
      ))
    }

    if (!isTRUE(answer)) {
      return(invisible())
    }
  }

  # nolint start
  repo_list <- self$repo_list
  repo_url <- private$repo_url
  repo_name <- self$repo_name
  repo_path <- private$repo_path
  file_name <- self$file_name
  file_ending <- self$file_ending
  # nolint end

  # address issues on some systems when rendering the markdown with the
  # template as input
  template_file <- tempfile(
    pattern = "autonewsmd-",
    tmpdir = tempdir(),
    fileext = "-news-md-template.Rmd"
  )

  # copy template file from package directory to tempdir()
  file.copy(
    from = system.file(
      "templates/news-md-template.Rmd",
      package = "autonewsmd"
    ),
    to = template_file,
    overwrite = TRUE
  )

  rmarkdown::render(
    input = template_file,
    output_file = I(paste0(file_name, file_ending)),
    output_dir = repo_path
    #, intermediates_dir = tempdir()
    #, knit_root_dir = tempdir()
  )

  invisible(file.remove(template_file))
}
