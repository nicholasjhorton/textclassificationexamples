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
# reading in common clickbait phrases bank
common_phrases <- read.delim(paste0(current_folder,
                                    "/data-raw/common_phrases"),
                             header = FALSE, sep = "\n")
# reading in exaggerated word bank
exaggerated_phrases <- read.delim(paste0(current_folder,
                                         "/data-raw/hyperbolic_phrases"),
                                 header = FALSE, sep = "\n")

usethis::use_data(articles, overwrite = TRUE)
usethis::use_data(common_phrases, overwrite = TRUE)
usethis::use_data(exaggerated_phrases, overwrite = TRUE)
