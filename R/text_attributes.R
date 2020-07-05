
library(dplyr)
library(stringr)
library(tidytext)

#' Common Phrases
#'
#' This function takes in any dataframe with a headline variable and returns a
#' new dataframe containing the variable common_phrases, which is a boolean
#' that indicates the presence of one of the phrases found in the
#' dataframe common.
#'
#'
#' @param ds dataset
#'
#' @examples
#' articles_common <- common_phrases(articles)
#'
#' }
#' @export
#'

common_phrases <- function(ds){
  ds <- ds %>%
    mutate(common_phrases = str_detect(headline,
                                       paste(common$phrases, collapse = "|")))
  return(ds)
}

#' Exaggerated Phrases
#'
#' This function takes in any dataframe with a headline variable and returns a
#' new dataframe containing the variable exaggerated_phrases,
#' which is a boolean that indicates the presence of one of the phrases
#' found in the dataframe exaggerated.
#'
#'
#' @param ds dataset
#'
#' @examples
#' articles_exaggerated <- exaggerated_phrases(articles)
#'
#' }
#' @export
#'
exaggerated_phrases <- function(ds){
  ds <- ds %>%
    mutate(exaggerated_phrases = str_detect(headline,
                                            paste(exaggerated$phrases,
                                                          collapse = "|")))
  return(ds)
}

#' Question Words
#'
#' This function takes in any dataframe with a headline variable and returns a
#' new dataframe containing the variable question_words, which is a boolean
#' that indicates the presence of one of the phrases found in the questions
#' dataset.
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
    mutate(question_words = str_detect(headline, paste(question$phrases,
                                                       collapse = "|")))
  return(ds)
}

#' Contraction Words
#'
#' This function takes in any dataframe with headline and ids variables
#' and returns a new dataframe containing the variable contraction_words,
#' which is an integer that enumerates the amount of contractions
#' (defined in dataset contractions) within a given headline.
#'
#'
#' @param ds dataset
#'
#' @examples
#' articles_contraction <- contraction_words(articles)
#'
#' }
#' @export
contraction_words <- function(ds){
  tidyds <-  ds %>%
    unnest_tokens(words, headline) %>%
    filter(str_detect(words, paste(contractions$phrases,
                                   collapse = "|"))) %>%
    group_by(ids) %>%
    summarize(num_contractions = n())
  ds <- full_join(ds, tidyds, "ids")
  ds[is.na(ds)] <- 0
  return(ds)
}

#' Number of Stop Words
#'
#' This function takes in any dataframe with  headline and ids variables
#' and returns a new dataframe containing the variable num_stop_words,
#' which is an integer enumerating the number of stop words (as defined by
#' the tidytext package) within a given headline.
#'
#'
#' @param ds dataset
#'
#' @examples
#' articles_stop_words <- num_stop_words(articles)
#'
#' }
#' @export
#'

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
#' Starts with Number
#'
#' This function takes in any dataframe with a headline variable and returns
#' a new dataframe containing the variable starts_with_num, which is a
#' boolean that indicates whether or not the headline starts with a number.
#'
#'
#' @param ds dataset
#'
#' @examples
#' articles_numstart <- starts_with_num(articles)
#'
#' }
#' @export
#'

starts_with_num <- function(ds){
  ds <- ds %>%
    mutate(starts_with_num = str_detect(headline, "^[[:digit:]]+"))
  return(ds)
}
#' Positivity (AFINN) Score
#'
#' This function takes in any dataframe with headline and ids variables and
#' returns a new dataframe containing the variable positivity,
#' which is an integer that represents the total AFINN score associated with
#' each headline. Scores of 0 represent neutral headlines, or headlines
#' not containing any words within the AFINN wordbank.
#'
#'
#' @param ds dataset
#'
#' @examples
#' articles_positivity <- positivity(articles)
#'
#' }
#' @export
#'

positivity <- function(ds){
  tidyds <- ds %>%
    unnest_tokens(words, headline) %>%
    inner_join(get_sentiments("afinn"), c("words" = "word")) %>%
    group_by(ids) %>%
    summarize(positivity = sum(value))
  ds <- full_join(ds, tidyds, "ids")
  ds[is.na(ds)] <- 0
  return(ds)
}
#' Number of Words
#'
#' This function takes in any dataframe with headline and ids variables
#' and returns a new dataframe containing the variable words, which is an
#' integer that indicates the number of words within the headline.
#'
#'
#' @param ds dataset
#'
#' @examples
#' articles_words <- words(articles)
#'
#' }
#' @export
#'
words <- function(ds){
  tidyds <- ds %>%
    unnest_tokens(words, title) %>%
    group_by(ids) %>%
    summarize(words = n())
  ds <- full_join(ds, tidyds)
  return(ds)
}

#' Number of Pronouns
#'
#' This function takes in any dataframe with headline and ids variables
#' and returns a new dataframe containing the variable pronouns,
#' which is an integer that indicates the number of pronouns
#' within the headline.
#' Pronouns detected include: I, me, you, he, him, she, her, it, we,
#' us, they, them, and one.
#'
#' @param ds dataset
#'
#' @examples
#' articles_pronouns <- pronouns(articles)
#'
#' }
#' @export
#'

pronouns <- function(ds) {
  pronouns <- c("I", "me", "you", "he" , "him", "she" , "her",
                "it", "we" , "us", "they" , "them", "one")
  tidyds <- ds %>%
    unnest_tokens(words, headline) %>%
    filter(str_detect(words, paste(pronouns,
                                   collapse = "|")))
    group_by(ids) %>%
    summarize(pronouns = n())
  ds <- full_join(ds, tidyds, "ids")
  ds[is.na(ds)] <- 0
  return(ds)
}
