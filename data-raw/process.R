suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(stringr))
processsub <- function(filename) {
  lines <- readLines(filename)
  ds <- tibble(lines) %>%
    mutate(
      start = str_locate(lines, "Subject: ")[,2],
      subjectline = str_sub(lines, start, end = -1L),
      subjectline = str_replace(subjectline, "    [ ]*[A-Za-z0-9.]*$", "")
    ) %>%
    select(-lines, -start)
  newfilename <- str_replace(filename, ".txt$", ".csv")
  write.csv(ds, file = newfilename)
}
processsub("spam.txt")
processsub("hard_ham.txt")
processsub("easy_ham.txt")




