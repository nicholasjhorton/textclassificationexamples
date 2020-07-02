#' Question Words
#'
#' This function takes in any dataframe with a headline variable and returns a
#' new dataframe containing the variable question_words, which is a boolean
#' that indicates the presence of one of the phrases found in _________
#'
#' @param ds dataset
#'
#' @examples
#' articles_question <- question_words(articles)
#'
#' }
#' @export
question_words <- function(ds){
  ds <- ds %>%
    mutate(question_words = str_detect(headline, paste(question, collapse = "|")))
  return(ds)
}
