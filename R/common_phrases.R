#' Common Phrases
#'
#' This function takes in any dataframe with a headline variable and returns a
#' new dataframe containing the variable common_phrases, which is a boolean
#' that indicates the presence of one of the phrases found in _________
#'
#' @param ds dataset
#'
#' @examples
#' articles_common <- common_phrases(articles)
#'
#' }
#' @export
common_phrases <- function(ds){
  ds <- ds %>%
    mutate(common_phrases = str_detect(headline,
                                       paste(common_phrases, collapse = "|")))
  return(ds)
}
