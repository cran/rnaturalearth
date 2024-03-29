#' Check whether to install rnaturalearthdata and install if necessary
#'
#' If the rnaturalearthdata package is not installed, install it from GitHub
#' using devtools. If it is not up to date, reinstall it.
#'
#' @export
check_rnaturalearthdata <- function() {
  rnaturalearthdata_version <- "0.0.0.9000"
  if (!requireNamespace("rnaturalearthdata", quietly = TRUE)) {
    message("The rnaturalearthdata package needs to be installed.")
    install_rnaturalearthdata()
  } else if (
    utils::packageVersion("rnaturalearthdata") < rnaturalearthdata_version) {
    message("The rnaturalearthdata package needs to be updated.")
    install_rnaturalearthdata()
  }
}

#' Install the naturalearthdata package after checking with the user
#' @export
install_rnaturalearthdata <- function() {
  instructions <- paste(
    "Please try installing the package for yourself",
    "using the following command: \n",
    # "devtools::install_github('ropensci/rnaturalearthdata')")
    "install.packages(\"rnaturalearthdata\")"
  )

  error_func <- function(e) {
    stop(
      paste("Failed to install the rnaturalearthdata package.\n", instructions)
    )
  }

  # 23/2/17 changed to try install if not interactive to avoid winbuilder
  # warning
  input <- 1
  if (interactive()) {
    input <- utils::menu(c("Yes", "No"),
      title = "Install the rnaturalearthdata package?"
    )
  }

  if (input == 1) {
    message("Installing the rnaturalearthdata package.")
    tryCatch(
      utils::install.packages("rnaturalearthdata",
        repos = c("http://packages.ropensci.org", "http://cran.rstudio.com"),
        type = "source"
      ),
      error = error_func, warning = error_func
    )
  } else {
    stop(paste(
      "The rnaturalearthdata package is necessary for that method.\n",
      instructions
    ))
  }
}
