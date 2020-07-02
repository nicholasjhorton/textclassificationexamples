#' Number of Stop Words
#'
#' This function takes in any dataframe with a headline variable and returns a
#' new dataframe containing the variable num_stop_words, which is an integer
#' that indicates the frequency of stop words within the headline.
#'
#' @param ds dataset
#'
#' @examples
#' articles_stops <- num_stop_words(articles)
#'
#' }
#' @export


num_stop_words <- function(ds){
  data(stop_words)
  tidyds <-  ds%>%
    unnest_tokens(words, headline) %>%
    filter(str_detect(words, paste(stop_words$word, collapse = "|"))) %>%
    group_by(ids) %>%
    summarize(num_stop_words = n())
  ds <- full_join(ds, tidyds, "ids")
  ds[is.na(ds)] <- 0
  return(ds)
}
