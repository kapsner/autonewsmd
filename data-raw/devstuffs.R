# nolint start
packagename <- "autonewsmd"

# remove existing description object
unlink("DESCRIPTION")
# Create a new description object
my_desc <- desc::description$new("!new")
# Set your package name
my_desc$set("Package", packagename)
#Set your name
my_desc$set_authors(c(
  person(
    given = "Lorenz A.",
    family = "Kapsner",
    email = "lorenz.kapsner@gmail.com",
    role = c('cre', 'aut', 'cph'),
    comment = c(ORCID = "0000-0003-1866-860X")
  )))
# Remove some author fields
my_desc$del("Maintainer")
# Set the version
my_desc$set_version("0.0.9.9002")
# The title of your package
my_desc$set(Title = "Auto-Generate Changelog using Conventional Commits")
# The description of your package
my_desc$set(Description = paste0(
  "Automatically generate a changelog file (NEWS.md / CHANGELOG.md) ",
  "from the git history using conventional commit messages ",
  "(<https://www.conventionalcommits.org/en/v1.0.0/>)."
))
# The description of your package
my_desc$set("Date/Publication" = paste(as.character(Sys.time()), "UTC"))
# The urls
my_desc$set("URL", "https://github.com/kapsner/autonewsmd")
my_desc$set("BugReports",
            "https://github.com/kapsner/autonewsmd/issues")

# Vignette Builder
my_desc$set("VignetteBuilder" = "quarto")
# Quarto
my_desc$set("SystemRequirements" = paste0(
  "Quarto command line tools ",
  "(https://github.com/quarto-dev/quarto-cli).")
)

# Testthat stuff
my_desc$set("Config/testthat/parallel" = "false")
my_desc$set("Config/testthat/edition" = "3")
# Roxygen
my_desc$set("Roxygen" = "list(markdown = TRUE)")

# License
my_desc$set("License", "GPL-3")
# Save everyting
my_desc$write(file = "DESCRIPTION")

# License
#usethis::use_gpl3_license()

# Depends
usethis::use_package("R", min_version = "4.1.0", type = "Depends")

# Imports
# https://cran.r-project.org/web/packages/data.table/vignettes/datatable-importing.html
usethis::use_package("data.table", type = "Imports")
usethis::use_package("quarto", type = "Imports")
usethis::use_package("R6", type = "Imports")
usethis::use_package("utils", type = "Imports")
usethis::use_package("git2r", type = "Imports")

# Suggests
usethis::use_package("testthat", type = "Suggests", min_version = "3.0.1")
usethis::use_package("lintr", type = "Suggests")
usethis::use_package("precommit", type = "Suggests")


# dev packages
# tag <- "master"
# devtools::install_github(repo = "r-lib/testthat", ref = tag, upgrade = "always")
# # https://cran.r-project.org/web/packages/devtools/vignettes/dependencies.html
# desc::desc_set_remotes(paste0("github::r-lib/testthat@", tag), file = usethis::proj_get())

usethis::use_build_ignore("cran-comments.md")
usethis::use_build_ignore(".lintr")
usethis::use_build_ignore("tic.R")
usethis::use_build_ignore(".github")
usethis::use_build_ignore("NEWS.md")
usethis::use_build_ignore("README.md")
usethis::use_build_ignore("README.qmd")
usethis::use_build_ignore("docs")
usethis::use_build_ignore("autonewsmd-manual.tex")
usethis::use_build_ignore(".pre-commit-hooks.yaml")
usethis::use_build_ignore(".pre-commit-config.yaml")
usethis::use_build_ignore("renv")
usethis::use_build_ignore("renv.lock")

usethis::use_git_ignore("!NEWS.md")
usethis::use_git_ignore("!README.md")
usethis::use_git_ignore("!README.qmd")
usethis::use_git_ignore("docs")
usethis::use_git_ignore("Meta")
usethis::use_git_ignore("!vignettes/*.qmd")

usethis::use_tidy_description()

quarto::quarto_render(input = "README.qmd")

an <- autonewsmd::autonewsmd$new(
  repo_name = packagename,
  repo_remotes = "origin"
)
an$generate()
an$write(force = TRUE)

# nolint end
