#' check that this scale is present in Natural Earth
#'
#' check name or numeric scale representations, return numeric one
#'
#' @param x scale of map to return, one of \code{110}, \code{50}, \code{10} or
#' \code{'small'}, \code{'medium'}, \code{'large'}
#'
#' @return integer scale of map
check_scale <- function(x) {
  if (is.numeric(x) && length(x) == 1) {
    if (x %in% c(110, 50, 10)) {
      return(x)
    }
  } else if (is.character(x) && length(x) == 1) {
    xnew <- c(small = 110, medium = 50, large = 10)[tolower(x)]

    if (!is.na(xnew)) {
      return(unname(xnew))
    }
  }

  stop(
    "Invalid `scale`. Must be one of [110, 50, 10, 'small', 'medium', 'large'] you have :",
    x,
    "\n",
    call. = FALSE
  )
}
