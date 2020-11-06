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
              breaks = c(-Inf, 65, 70, 75, 80, 85, Inf),
              labels = c("F", "B-", "B", "B+", "A-", "A"))
groups

score.list <- split(scores, f = groups)

# set one value to NA for teaching purpose
score.list$A[5] <- NA
score.list

# Average for each letter grade
lapply(score.list, FUN = mean)

lapply(score.list, FUN = mean, na.rm = T)

# sapply on a list
sapply(score.list, FUN = mean)

sapply(score.list, FUN = mean, na.rm = T, simplify = F)

# sapply() on a data frame
head(iris)
sapply(iris, FUN = class)

# sapply on a vector
sapply(c(6, 1, 3), FUN = seq)

# sapply an operator instead of a function
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

aaa_x10 <- replicate(n = 10, expr = {
    "aaa"
})
aaa_x10

replicate(n = 5, expr = {
    rnorm(n = 2)
})

library(plyr)
library(dplyr)
library(ggplot2)
library(mosaic)
yrbss <- readr::read_csv(file = "/Users/YLIAN/Desktop/Teaching/EPIB613/2020/yrbss.csv")
set.seed(234)
number.samples <- 25

# Draw 25 samples of size 16 each and calculate 80%, 96% t-based confidence intervals
mu <- mean(yrbss$weight)
R.16.80.96 <- replicate(number.samples, {
    sample.16 <- yrbss %>%
        dplyr::sample_n(size = 16) %>%
        dplyr::pull(weight)
    
    c(t.test(sample.16, conf.level = .80)$conf.int,
      t.test(sample.16, conf.level = .96)$conf.int)
}) %>% t()

# check coverage for 80% interval
mean(sapply(1:number.samples,
            FUN = function(i) {
                (mu >= R.16.80.96[i,1]) & (mu <= R.16.80.96[i,2])
            }
    )
)

# check coverage for 96% interval
mean(sapply(1:number.samples, function(i){
(mu >= R.16.80.96[i,3]) & (mu <= R.16.80.96[i,4])
}))

par(mfrow = c(1,2))
plot(range(R.16.80.96), c(1, number.samples),
     col="black", typ="n",
     main = "80% Confidence Interval",
     ylab="Samples",
     xlab="Mean Weight (kg)")

segments(R.16.80.96[,1], 1:number.samples, R.16.80.96[,2], 1:number.samples)
abline(v = mu, lty = 2, col = "red")

plot(range(R.16.80.96), c(1, number.samples), col="black", typ="n",
    main = "96% Confidence Interval", ylab="Samples",
    xlab="Mean Weight (kg)")
segments(R.16.80.96[,3], 1:number.samples, R.16.80.96[,4], 1:number.samples)
abline(v = mu, lty = 2, col = "red")

# possion based CI
set.seed(12345)
true_lambda <- 6
sims <- rpois(100, lambda = true_lambda)
df <- plyr::ldply(sims, function(i) {
    z_ci <- poisson.test(x = i, T = 1)$conf.int
    c(z_ci,i, dplyr::between(true_lambda, z_ci[1],z_ci[2]))
})

df$trial <- factor(seq_along(df$V1))
colnames(df) <- c("lower","upper","mean", "covered", "trial")
df$covered <- factor(df$covered, levels = 0:1, labels = c("no","yes"))
df$width <- df$upper - df$lower

p <- ggplot(df, aes(mean, trial, colour = covered))
p + geom_point() +
    geom_errorbarh(aes(xmax = upper, xmin = lower)) +
    geom_vline(xintercept = true_lambda) +
    theme_bw(base_size = 13L) +
    labs(caption = sprintf("average CI width is %0.2f", median(df$width)))

set.seed(12345)
true_lambda <- 6
sims <- rpois(100, lambda = true_lambda)
df <- plyr::ldply(sims, function(i) {
  z_ci <- qnorm(p = c(0.025, 0.975), mean = i, sd = sqrt(i)) 
  c(z_ci,i, dplyr::between(true_lambda, z_ci[1],z_ci[2]))
}) 

df$trial <- factor(seq_along(df$V1))
colnames(df) <- c("lower","upper","mean", "covered", "trial")
df$covered <- factor(df$covered, levels = 0:1, labels = c("no","yes"))
df$width <- df$upper - df$lower

p <- ggplot(df, aes(mean, trial, colour = covered))
p + geom_point() +
    geom_errorbarh(aes(xmax = upper, xmin = lower)) +
    geom_vline(xintercept = true_lambda) + 
    theme_bw(base_size = 13L) +
    labs(caption = sprintf("average CI width is %0.2f", mean(df$width)))
