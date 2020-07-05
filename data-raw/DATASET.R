library(dplyr) # data-wrangling
library(mosaic) # sampling datasets

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

# creating vector of words not suitable for work found within
# clickbait headlines to filter dataset.

nsfw <- c("fuck", "sex", "piss", "dominatrix",
          "urin", "blackface", "masturba", "dick", "badass",
          "shirtless", "hand job", "damn", "shit", "WTF", "boob",
          "butt", "tinder", "poop", "horny", "grindr", "hell", "orgasm",
          "cocaine", "suicid", "period underwear", "vasectom", "boner",
          "herpes", "vagina", "ass", "nude", "abortion", "porn", "crotch",
          "f#@k", "lube", "nipple", "pee", "condom", "sugar daddy", "lynch")

# filtering out articles containing nsfw language
articles_clean <- articles %>%
  mutate(nsfw = str_detect(headline, regex((paste(nsfw, collapse = "|")),
                                        ignore_case = TRUE))) %>%
  filter(nsfw == FALSE)


# setting seed for smaller samples
set.seed(1999)

sample_clickbait <- mosaic::sample(articles_clean %>%
                                  filter(clickbait == TRUE),
                                  size = 1000)
sample_headlines <- mosaic::sample(articles_clean %>%
                                   filter(clickbait == FALSE),
                                 size = 1000)

# sample headlines n = 2000
sample_articles <- rbind(sample_headlines, sample_clickbait) %>%
  select(-orig.id, -nsfw)

articles_clean <- articles_clean %>%
  select(-nsfw)

usethis::use_data(articles, overwrite = TRUE)
usethis::use_data(common, overwrite = TRUE)
usethis::use_data(exaggerated, overwrite = TRUE)
usethis::use_data(contractions, overwrite = TRUE)
usethis::use_data(question, overwrite = TRUE)
usethis::use_data(sample_articles, overwrite = TRUE)
usethis::use_data(articles_clean, overwrite = TRUE)
