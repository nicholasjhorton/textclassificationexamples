#' Exaggerated Words
#'
#' This function takes in any dataframe with a headline variable and returns a
#' new dataframe containing the variable exaggerated_words, which is a boolean
#' that indicates the presence of one of the phrases found in _________
#'
#' @param ds dataset
#'
#' @examples
#' articles_exaggerated <- exaggerated_words(articles)
#'
#' }
#' @export
exaggerated_words <- function(ds){
  ds <- ds %>%
    mutate(exaggerated_words = str_detect(headline, paste(hyperbolic$V1,
                                                          collapse = "|")))
  return(ds)
}
