## R CMD check results

0 errors | 0 warnings | 1 note

* Hot-fix to resolve R CMD check failures on r-devel-linux-x86_64-debian-clang, r-devel-linux-x86_64-debian-gcc, r-release-linux-x86_64
* Now copying news-md-template.Rmd to tempdir() before calling rmarkdown::render in order to address these issues and clean up tempdir() after rendering changelog file
* Furthermore, vignette now static (eval=FALSE) to also address these errors on some systems
