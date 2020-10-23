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
county.left_join <- dplyr::left_join(x = nytcovcounty,
                              y = pop_county,
                              by = c("state","fips"))
county.left_join

county.left_join.mutate <- mutate(`.data` = county.left_join,
                                  cases.per.10k = cases/population * 1e4)
county.left_join.mutate

county.left_join.mutate.filter <- dplyr::filter(`.data` = county.left_join.mutate,
                                                state %in% c("Iowa","Illinois"))
county.left_join.mutate.filter

# Base R subset function covered in previous lectures
# subset(x = county.left_join.mutate, subset = state %in% c("Iowa","Illinois"))

# %in%

1 %in% 1:3

c("a", "b", "c") %in% c("a", "d", "e")

county.left_join.mutate.filter.group_by <- dplyr::group_by(`.data` = county.left_join.mutate.filter, county)
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

# order of factors in R
# Check
sort(factor(c("A", "b", "a", "ab", "a1", "c", "1", "1a", "!!!")))

set.seed(613)
students <- rep(c("Lucy", "John", "Mark", "Candy", "Chris"), 3)
course <- rep(c("epib601", "epib607", "epib613"), each = 5)
scores <- sample(50:100, size = 15, replace = T)
program <- rep(c("EPIB", "EPIB", "EPIB", "PH", "PH"))

df <- data.frame(students, course, scores, program)
df <- df[sample(1:nrow(df)), ]   # shuffle the rows to make things more complicated
df

# the arguments will be
    # data = df
    # pivot = "students"
    # names_from = "course"
    # values_from = "scores"
# Use the actually R objects and values to test
# Finally put them into the function, substitute the actural values by argument names

# reorder data - to take advantage of the ordering of factors
df <- df[order(df[, "students"]), ]; df
df <- df[order(df[, "course"]), ]; df

# get column names
col.names <- unique(df[, "course"])
col.names

# get number of columns - one for each course
n.col <- length(col.names)
n.col

# generate pivot variable
pivot.var <- unique(df[, "students"])
pivot.var

# generate number of pivots
n.pivot <- length(pivot.var)
n.pivot

# generate value matrix
value.mat <- matrix(df[, "scores"], nrow = n.pivot, ncol = n.col, byrow = F)
value.mat

# assemble wide data frame
data_wide <- data.frame(pivot.var, value.mat)
data_wide

# rename wide data frame
names(data_wide) <- c("student", as.character(col.names))
data_wide

## A sample solution

# Put the steps together into the function
    # change df (the actual data frame) to data (argument name)
    # change "students" to pivot
    # change "course" to names_from
    # change "scores" to values_from
# so that the function can be applied to other similar data frames.

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

# df %>%
#     dplyr::group_by() %>%
#     dplyr::summarise()
df %>%
    group_by(course) %>%
    summarise(scores=mean(scores))

df[1,3] <- NA; df

df %>%
    group_by(course, program) %>%
    summarise(scores=mean(scores))

df %>%
    group_by(course, program) %>%
    summarise(scores=mean(scores, na.rm = T))

mean.rounded <- function(x) {
    round(mean(x))
}

aggregate(scores ~ course + program, FUN = mean.rounded, data = df)

df %>%
    group_by(course, program) %>%
    summarise(scores = round(mean(scores)))

df

aggregate(scores ~ course, FUN = print, data = df)

county_level

illinois <- county_level[county_level$state == "Illinois", ]

# aggregate(cases~county, FUN = plot, type = "l", data = illinois)

as.factor(unique(illinois$county))

# verify that we got the correct plots
plot(illinois[illinois$county == "Adams", ]$cases, type = "l")


