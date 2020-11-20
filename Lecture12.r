df <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
df$rank <- ceiling(df$rank/2) - 1
head(df)

table(df[,c("rank", "admit")])[c(2,1),c(2,1)]

OR <- 40*125/(87*148); OR

fit1 <- glm(admit~rank,
            family = binomial(link = "logit"),
            data = df)
summary(fit1)

exp(fit1$coefficients)

# CI for the odds ratio
exp(confint(fit1, level = 0.95))

# Prediction
# type = "response" gives the fitted probability
nd <- data.frame(rank = c(0,1))
predict(fit1, type = "response", newdata = nd)

# type = "link" give the fitted linear predictor
predict(fit1, type = "link", newdata = nd)

fit2 <- glm(admit~gpa,
            family = binomial(),
            data = df)
summary(fit2)
# the link function for binomial family is logit by default - canonical link

fit2$coefficients

exp(fit2$coefficients)

# Predict the probability of admit given 4.0 GPA
predict(fit2, newdata=data.frame(gpa=4), type="response")

fit3 <- glm(admit~., family = binomial(), data = df)
summary(fit3)

library(MASS)
ds <- ships
ds <- ds[ds$service>0, ]
head(ds)

# The canonical link for poisson regression is log, so can be omitted.
fit.rate <- glm(incidents~type+as.factor(year)+offset(log(service)),
                family = poisson("log"), data = ds)
summary(fit.rate)

print(exp(fit.rate$coefficients))

x <- rnorm(1, mean = 10, sd = 1)
y <- rgamma(1, shape = 3, rate = 4)
x*y

boot.iter <- 10000
XY <- numeric(boot.iter)

set.seed(613)
for (i in 1:boot.iter) {
    x <- rnorm(n = 1, mean = 10, sd = 1)
    y <- rgamma(n = 1, shape = 3, rate = 4)
    XY[i] <- x * y
}
print(quantile(x = XY, probs = c(0.025,0.5,0.975)))
hist(XY, breaks = 20)

# Illustration of the idea on a different dataset.
stroke <- read.csv("https://raw.githubusercontent.com/ly129/EPIB613_2019/master/stroke.csv")
head(stroke)

fit <- glm(dead~sex+diab+coma+minf, data = stroke, family = binomial())
print(exp(coef(fit)))

# ROR of myocardial infarction vs. diabetes
ROR_minf_diab <- exp(coef(fit))[5] / exp(coef(fit))[3]
ROR_minf_diab

n <- nrow(stroke)
boot.iter <- 1000
ROR <- numeric(boot.iter)

set.seed(613)
for (i in 1:boot.iter) {
    boot.index <- sample(1:n, n, replace = T)
    boot.sample <- stroke[boot.index, ]
    fit <- glm(dead~sex+diab+coma+minf,
               data = boot.sample,
               family = binomial())
    ROR[i] <- exp(coef(fit))[5] / exp(coef(fit))[3]
}
print(quantile(x = ROR, probs = c(0.025,0.5,0.975)))
hist(ROR, breaks = 20)

library(boot)
# function to obtain the estimate of ROR
ROR <- function(data, indices) {
    # allows boot to select sample
    d <- data[indices,]
    fit <- glm(dead~sex+diab+coma+minf,
               data = d,
               family = binomial())
    ror <- exp(coef(fit))[5] / exp(coef(fit))[3]
    return(ror)
}
results <- boot(data = stroke, statistic = ROR, R = 1000)
results

plot(results)

boot.ci(results)
