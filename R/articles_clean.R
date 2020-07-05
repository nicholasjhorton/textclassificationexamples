#' Headlines cleaned
#'
#' This subset of the clickbait dataframe removes headlines containing
#' explicit language or suggestive content. Given the volume of headlines
#' containing such language (especially for clickbait == TRUE), this filtering
#' might not catch all problematic headlines. User discretion is advised.
#'
#' @format A data frame with 22949 rows and 3 variables:
#' \describe{
#'   \item{headline}{String}
#'   \item{clickbait}{Boolean}
#'   \item{ids}{Integer}
#' }
#' @source \url{XX}
"articles_clean"
