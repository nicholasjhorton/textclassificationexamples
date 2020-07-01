## code to prepare `DATASET` dataset goes here


# setting folder name
current_folder <- getwd()
# reading in data
clickbait <- read.delim(paste0(current_folder,"/clickbait_data"),
                        header = FALSE, sep = "\t") %>%
  mutate(clickbait = TRUE)
non_clickbait <- read.delim(paste0(current_folder,"/non_clickbait_data"),
                            header = FALSE, sep = "\t") %>%
  mutate(clickbait = FALSE)
# joining
articles <- rbind(clickbait, non_clickbait) %>%
  rename(title = V1)
# reading in common phrases defined by Chakraborty et al.
common_phrases <- read.delim(paste0(current_folder,"/common_phrases"),
                             header = FALSE, sep = "\n")
# reading in hyperbolic phrases defined by Chakraborty et al.
hyperbolic_phrases <- read.delim(paste0(current_folder,"/hyperbolic_phrases"),
                                 header = FALSE, sep = "\n")

usethis::use_data(DATASET, overwrite = TRUE)
