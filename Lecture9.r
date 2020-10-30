library(covdata)
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

pop_county <- read_csv("https://opendata.arcgis.com/datasets/21843f238cbb46b08615fc53e19e0daf_1.csv") %>% 
    dplyr::rename(fips = GEOID, population = B01001_001E, state = State) %>%
    dplyr::select(state, fips, population)
county_level <- nytcovcounty %>%
    dplyr::left_join(pop_county, by = c("state","fips")) %>%
    dplyr::mutate(cases.per.10k = cases/population * 1e4) %>%
    dplyr::filter(state %in% c("Iowa","Illinois")) %>%
    dplyr::group_by(county)
# A subset that contains all dates after 2020-07-12 in Illinois
illinois <- county_level[county_level$state == "Illinois" & county_level$date >= "2020-07-12", ]

my_wider <- function(data, pivot, names_from, values_from) {
  
  # reorder data - to take advantage of the ordering of factors
  data <- data[order(data[, pivot]), ]
  data <- data[order(data[, names_from]), ]
  
  # get column names
  col.names <- unique(data[, names_from, drop = T])

  # get number of columns - one for each course
  n.col <- length(col.names)
  
  # generate pivot variable
  pivot.var <- unique(data[, pivot, drop = T])
  
  # generate number of pivots
  n.pivot <- length(pivot.var)
  
  # generate value matrix
  value.mat <- matrix(data[, values_from, drop = T], nrow = n.pivot, ncol = n.col, byrow = F)
  
  # assemble wide data frame
  data_wide <- data.frame(pivot.var, value.mat)
  
  # rename wide data frame
  names(data_wide) <- c(pivot, as.character(col.names))
  
  return(data_wide)
}

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

# Pivot_wider

# Pivot_longer


# my_wider

# my_longer


# Binomial distribution

# Toss a fair dice 10 times and get 6 for X times, X ~ Binomial(10, 1/6)
six <- 0:10

plot(six, dbinom(six, size = 10, prob = 1/6),
     type = 'h',
     main = 'Binomial (n = 10, p = 1/6)',
     ylab = 'Probability',
     xlab = '# six',
     lwd = 10)



x <- seq(-4, 4, length = 100)
hx <- dnorm(x)

plot(x, hx, type = "l", lwd = 10,
     xlab = "x value", ylab = "Density",
     main = "Standard Normal Distribution")



# what is quantile?
set.seed(613)
# uniformly sample between 50 and 100
scores <- runif(n = 10, min = 50, max = 100)
hist(scores)

# The sample quantile
quantile(x = scores)

# uniform distribution
qunif(p = 0.25, min = 50, max = 100)



x <- seq(-4, 4, length = 100)
hx <- dnorm(x)

plot(x, hx, type = "l", lwd = 10,
     xlab = "x value", ylab = "Density",
     main = "Standard Normal Distribution")

abline(v = qnorm(p = 0.025,
                 mean = 0,
                 sd = 1,
                 lower.tail = T),
       lwd = 5, col = 'red', lty = 2)

plot(x, hx, type = "l", lwd = 10,
     xlab = "x value", ylab = "Density",
     main = "Standard Normal Distribution")

abline(v = qnorm(p = 0.025,
                 mean = 0,
                 sd = 1,
                 lower.tail = F),
       lwd = 5, col = 'red', lty = 2)



pois.sample <- rpois(n = 5, lambda = 6)
pois.sample

norm.sample <- rnorm(n = 5, mean = 1, sd = 3)
norm.sample

# seed - for reproducible random number generation
set.seed(613)
rnorm(n = 4, mean = 1, sd = 3)
rgamma(n = 3, shape = 2, rate = 3)
rgamma(n = 3, shape = 2, rate = 3)

set.seed(613)
rnorm(n = 3, mean = 1, sd = 3)
rgamma(n = 2, shape = 2, rate = 3)
rgamma(n = 2, shape = 2, rate = 3)

mat <- matrix(1:6, nrow = 2); mat

apply(mat, MARGIN = 1, FUN = sum)

apply(mat, MARGIN = 2, FUN = sum)

myarray <- array(1:12, dim = c(2,3,2)); print(myarray)

apply(myarray, MARGIN = 1, FUN = sum)

# What happened?
apply(myarray, MARGIN = c(1, 3), FUN = sum)

set.seed(613)
scores <- round(runif(n = 20, min = 50, max = 100)); scores

groups <- cut(scores,
              breaks = c(50, 65, 70, 75, 80, 85, 100),
              labels = c("C+", "B-", "B", "B+", "A-", "A"))
groups

score.list <- split(scores, f = groups)
score.list$A[5] <- NA
score.list

# Average for each letter grade
lapply(score.list, FUN = mean)

lapply(score.list, FUN = mean, na.rm = T)

# sapply a list
sapply(score.list, FUN = mean)

sapply(score.list, FUN = mean, na.rm = T, simplify = F)

# sapply() a data frame
head(iris)
sapply(iris, FUN = class)

# sapply a vector
sapply(c(6, 1, 3), FUN = seq)

sapply(c(6, 1, 3), FUN = '+', 2)

# use our own function in FUN
sapply(c(6, 1, 3), FUN = function(x) {x + 2})

# plyr::ldply
plyr::ldply(`.data` = c(6, 1, 3), `.fun` = function(x) {x + 2})

score.list

# recall aggregate()
aggregate(Sepal.Length~Species, FUN = mean, data = iris)

# Alternative syntax
aggregate(iris$Sepal.Length, by = list(Species = iris$Species), FUN = mean)

tapply(X = iris$Sepal.Length, INDEX = list(Species = iris$Species), FUN = mean)

# Another function that does the same thing
by(data = iris$Sepal.Length, INDICES = list(Species = iris$Species), FUN = mean)


