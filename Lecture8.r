library(covdata)
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

pop_county <- read_csv("https://opendata.arcgis.com/datasets/21843f238cbb46b08615fc53e19e0daf_1.csv") %>% 
    dplyr::rename(fips = GEOID, population = B01001_001E, state = State) %>%
    dplyr::select(state, fips, population)

pop_county

raw <- read_csv("https://opendata.arcgis.com/datasets/21843f238cbb46b08615fc53e19e0daf_1.csv")

dim(raw)
raw.rename <- dplyr::rename(`.data` = raw, fips = GEOID, population = B01001_001E, state = State)
names(raw); names(raw.rename)

raw.rename.select <- dplyr::select(`.data` = raw.rename, state, fips, population)
raw.rename.select

county_level <- nytcovcounty %>%
    dplyr::left_join(pop_county, by = c("state","fips")) %>%
    dplyr::mutate(cases.per.10k = cases/population * 1e4) %>%
    dplyr::filter(state %in% c("Iowa","Illinois")) %>%
    dplyr::group_by(county)
county_level

nytcovcounty

# Again breaks it down
county.left_join <- left_join(x = nytcovcounty,
                              y = pop_county,
                              by = c("state","fips"))
county.left_join

county.left_join.mutate <- mutate(`.data` = county.left_join,
                                  cases.per.10k = cases/population * 1e4)
county.left_join.mutate

county.left_join.mutate.filter <- dplyr::filter(`.data` = county.left_join.mutate,
                                                state %in% c("Iowa","Illinois"))
county.left_join.mutate.filter

county.left_join.mutate.filter.group_by <- dplyr::group_by(`.data` = county.left_join.mutate.filter,
                                                           cases)
county.left_join.mutate.filter.group_by

pop_state <- pop_county %>%
    dplyr::group_by(state) %>%
    dplyr::summarise(population = sum(population, na.rm = TRUE))
pop_state

state_level <- county_level %>%
    dplyr::group_by(state, date) %>%
    dplyr::filter(date >= "2020-03-15") %>%
    dplyr::summarise(cases = sum(cases)) %>%
    dplyr::left_join(pop_state, by = "state") %>%
    dplyr::mutate(cases.per.10k = cases / population * 1e4, state = factor(state),
                  time = as.numeric(date - min(date)) + 1)
state_level

set.seed(613)
students <- rep(c("Lucy", "John", "Mark", "Candy", "Chris"), 3)
course <- rep(c("epib601", "epib607", "epib613"), each = 5)
scores <- sample(50:100, size = 15, replace = T)
program <- rep(c("EPIB", "EPIB", "EPIB", "PH", "PH"))

df <- data.frame(students, course, scores, program)
df <- df[sample(1:nrow(df)), ]   # shuffle the rows to make things more complicated
df

## A sample solution
my_wider <- function(data, pivot, names_from, values_from) {
  
  # reorder data - to take advantage of the ordering of factors
  data <- data[order(data[, pivot]), ]
  data <- data[order(data[, names_from]), ]
  
  # get column names
  col.names <- unique(data[, names_from])

  # get number of columns - one for each course
  n.col <- length(col.names)
  
  # generate pivot variable
  pivot.var <- unique(data[, pivot])
  
  # generate number of pivots
  n.pivot <- length(pivot.var)
  
  # generate value matrix
  value.mat <- matrix(data[, values_from], nrow = n.pivot, ncol = n.col, byrow = F)
  
  # assemble wide data frame
  data_wide <- data.frame(pivot.var, value.mat)
  
  # rename wide data frame
  names(data_wide) <- c(pivot, as.character(col.names))
  
  return(data_wide)
}

df_wide <- my_wider(df, pivot = "students", names_from = "course", values_from = "scores")
df_wide

my_longer <- function(data, pivot, cols, names_to, values_to) {
  
  # extract the values
  values <- data[, cols]
  
  # change it to a vector, by column
  values <- as.vector(as.matrix(values))
  
  # determine number of cols
  n.col <- length(cols)
  
  # rep the pivot variable
  pivot.var <- rep(unlist(data[, pivot]), n.col)
  
  # determine the number of pivots
  n.pivot <- nrow(data)
  
  # make the names_to variable
  names_to.var <- rep(cols, each = n.pivot)
  
  # assemble long data frame
  data.long <- data.frame(pivot.var, names_to.var, values)
  
  # rename long data frame
  names(data.long) <- c(pivot, names_to, values_to)
  
  return(data.long)
  
}

my_longer(df_wide,
          pivot = "students",
          cols = c("epib601", "epib607", "epib613"),
          names_to = "course",
          values_to = "scores")

aggregate(scores ~ course, FUN = mean, data = df)

aggregate(scores ~ course + program, FUN = mean, data = df)

mean.rounded <- function(x) {
    round(mean(x))
}

aggregate(scores ~ course + program, FUN = mean.rounded, data = df)

df

aggregate(scores ~ course, FUN = print, data = df)
