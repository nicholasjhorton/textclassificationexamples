library(dplyr)
## code to prepare `DATASET` dataset goes here


# setting folder name
current_folder <- getwd()
# reading in data
clickbait <- read.delim(paste0(current_folder,
                               "/data-raw/clickbait_data"),
                        header = FALSE, sep = "\t") %>%
  mutate(clickbait = TRUE)
non_clickbait <- read.delim(paste0(current_folder,
                                   "/data-raw/non_clickbait_data"),
                            header = FALSE, sep = "\t") %>%
  mutate(clickbait = FALSE)
# joining
articles <- rbind(clickbait, non_clickbait) %>%
  rename(headline = V1)

# assigning unique ID to each headline
ids <- c(1:nrow(articles))

# joining with articles dataframe
articles <- cbind(articles, ids)




# reading in common clickbait phrases bank
common <- read.delim(paste0(current_folder,
                            "/data-raw/common_phrases"),
                             header = FALSE, sep = "\n") %>%
  rename(phrases = V1)
# reading in exaggerated word bank
exaggerated <- read.delim(paste0(current_folder,
                                "/data-raw/hyperbolic_phrases"),
                                header = FALSE, sep = "\n") %>%
  rename(phrases = V1)

# reading in contractions
contractions <- read.delim(paste0(current_folder,
                                 "/data-raw/contractions.txt"),
                          header = FALSE, sep = "\n") %>%
  rename(phrases = V1)

# reading in question words
question <- read.csv(paste0(current_folder,
                                  "/data-raw/question_words.csv")) %>%
  select(x) %>%
  rename(phrases = x)

usethis::use_data(articles, overwrite = TRUE)
usethis::use_data(common, overwrite = TRUE)
usethis::use_data(exaggerated, overwrite = TRUE)
usethis::use_data(contractions, overwrite = TRUE)
usethis::use_data(question, overwrite = TRUE)
