% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/text_attributes.R
\name{pronouns}
\alias{pronouns}
\title{Number of Pronouns}
\usage{
pronouns(ds)
}
\arguments{
\item{ds}{dataset}
}
\description{
This function takes in any dataframe with headline and ids variables
and returns a new dataframe containing the variable pronouns,
which is an integer that indicates the number of pronouns
within the headline.
Pronouns detected include: I, me, you, he, him, she, her, it, we,
us, they, them, and one.
}
