# ?ToothGrowth
tg <- ToothGrowth
head(tg); tail(tg)
plot(tg$dose, tg$len, col = tg$supp, pch = "+", cex = 2)
legend("bottomright", legend = c("OJ", "VC"), pch = "+", col = 1:2, cex = 2)

fit.dose <- lm(len ~ dose, data = tg)
fit.dose

summary(fit.dose)

plot(tg$dose, tg$len, col = tg$supp, pch = "+", cex = 2)
legend("bottomright", legend = c("OJ", "VC"), pch = "+", col = 1:2, cex = 2)

abline(fit.dose, lwd = 2)

str(tg$supp)

tg$supp <- factor(tg$supp, levels = c("VC", "OJ"))

fit.supp2 <- lm(len ~ supp, data = tg)
summary(fit.supp2)

# change back
tg$supp <- factor(tg$supp, levels = c("OJ", "VC"))

means <- aggregate(len~supp, data = tg, FUN = mean)
diff(means$len)

fit.int <- lm(len~1, data = tg)
summary(fit.int)

plot(tg$dose, tg$len, col = tg$supp, pch = "+", cex = 2)
legend("bottomright", legend = c("OJ", "VC"), pch = "+", col = 1:2, cex = 2)

abline(fit.int, lwd = 2)

fit.slope <- lm(len~dose - 1, data = tg)
fit.slope

summary(fit.slope)

plot(tg$dose, tg$len, col = tg$supp, pch = "+",
     cex = 2, xlim = c(0,2), ylim = c(0,35))
legend("bottomright", legend = c("OJ", "VC"), pch = "+", col = 1:2, cex = 2)

abline(fit.slope, lwd = 2)

fit.both <- lm(len~supp+dose, data = tg)
summary(fit.both)

# or fit.both <- lm(len~., data = tg)
# ~. means fit on all other variables in the data frame.

plot(tg$dose, tg$len, col = tg$supp, pch = "+", cex = 2)
legend("bottomright", legend = c("OJ", "VC"), pch = "+", col = 1:2, cex = 2)

abline(a = fit.both$coefficients["(Intercept)"], b = fit.both$coefficients["dose"], lwd = 2)
abline(a = fit.both$coefficients["(Intercept)"] + fit.both$coefficients["suppVC"],
       b = fit.both$coefficients["dose"], col = "red", lwd = 2)

fit.interaction <- lm(len~supp*dose, data = tg)
summary(fit.interaction)

plot(tg$dose, tg$len, col = tg$supp, pch = "+", cex = 2,
     xlim = c(0,2), ylim = c(0,35))
legend("bottomright", legend = c("OJ", "VC"), pch = "+", col = 1:2, cex = 2)

abline(a = fit.interaction$coefficients["(Intercept)"],
       b = fit.interaction$coefficients["dose"], lwd = 2)
abline(a = fit.interaction$coefficients["(Intercept)"] + fit.interaction$coefficients["suppVC"],
       b = fit.interaction$coefficients["dose"] + fit.interaction$coefficients["suppVC:dose"],
       col = "red", lwd = 2)

fit.interaction.only <- lm(len~supp:dose + dose, data = tg)
summary(fit.interaction.only)

plot(tg$dose, tg$len, col = tg$supp, pch = "+", cex = 2,
     xlim = c(0,2), ylim = c(0,35))
legend("bottomright", legend = c("OJ", "VC"), pch = "+", col = 1:2, cex = 2)

abline(a = fit.interaction.only$coefficients["(Intercept)"],
       b = fit.interaction.only$coefficients["dose"], lwd = 2)
abline(a = fit.interaction.only$coefficients["(Intercept)"],
       b = fit.interaction.only$coefficients["dose"] + fit.interaction.only$coefficients["suppVC:dose"],
       col = "red", lwd = 2)

new.data <- data.frame(supp = c("OJ", "VC"), dose = rep(1.5, 2))
new.data
print(predict(object = fit.both, newdata = new.data))

predict(fit.both, newdata = new.data, interval = "confidence")

predict(fit.both, newdata = new.data, interval = "prediction")

plot(fit.dose)

fit.supp <- lm(len~supp, data = tg)
summary(fit.supp)

# str(fit.supp)
# str(summary(fit.supp))

# confidence interval for the estimates
confint(fit.supp)

t.test(len~supp, data = tg, var.equal = T)

N <- 100
x <- rnorm(N, 1, 3)
y <- rnorm(N, 3, 3)

samp <- data.frame(x, y)
head(samp)

par(mfrow = c(1,2))
plot(x, y)

plot(sample(x), y)

# Left is the case where y and x are associated
# Shuffle x breaks the association
# which leads to the plot with no pattern on the right hand side.

N <- 100
x <- rnorm(N, 1, 3)
# y <- rnorm(N, 3, 3)
y <- 3*x + rnorm(N, 0, 2)

samp <- data.frame(x, y)
head(samp)

par(mfrow = c(1,2))
plot(x, y)
plot(sample(x), y)

y <- tg$len
x <- tg$supp
mean(y[x=="VC"]) - mean(y[x=="OJ"])

# right hand side is the len of the VC and OJ group after shuffling the groups
# there should be no pattern - similar to the previous plot
# no pattern means that no group is higher or lower than the other.

par(mfrow = c(1,2))
plot(x, y)
plot(sample(x), y)

# shuffle VC and OJ, and calculate the difference in mean between the groups

one.test <- function(x,y) {
    xstar <- sample(x)
    mean(y[xstar=="VC"]) - mean(y[xstar=="OJ"])
}

one.test(tg$supp, tg$len)

# The histogram is the expected distribution of the difference in mean len of the two groups
# had any potential association been removed by shuffling.

# As expected, the mean difference in mean should be close to 0 when there is no association.

null.dist <- replicate(1000, one.test(x = tg$supp, y = tg$len))
hist(null.dist)

abline(v=coef(fit.supp)["suppVC"], lwd=2, col="blue")
abline(v=-coef(fit.supp)["suppVC"], lwd=2, col="blue")

mean(abs(null.dist) > abs(coef(fit.supp)["suppVC"]))
