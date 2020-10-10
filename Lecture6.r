for (names in c("Lucy", "John", "Mark", "Candy")) {
    print(names)
}

x <- 11:15
n <- length(x)

for (index in 1:length(x)) {
    x[index] <- 2 * x[index]
}
x

# Vectorized operation?
x <- 11:15
x <- x * 2; x

df <- data.frame(names = c("Lucy", "John", "Mark", "Candy"),
                 score = c(67, 56, 87, 91))
df$names <- as.character(df$names)
df

for (i in 1:4) {
    df$curved[i] <- round(sqrt(df$score[i])*10)
}
df

x <- 1
y <- 5

iteration <- 0

while (x < y) {
    x <- x + 1
    iteration <- iteration + 1
    cat("iteration ", iteration, ", x = ", x, "\n", sep = "")
}

x

# Vectorized operation?

# Sometimes loops are necessary.

9 %% 2   # 9 mod 2

9 %/% 2

# y %% x
# y %/% x

y <- 9
x <- 2
counter <- 0

while (y >= x) {
    y <- y - x
    counter <- counter + 1
}

integer.div <- counter
modulus <- y

integer.div
modulus

# Girlfriend
watermelon <- T
gf.orange <- 6

gf.watermelon <- if (watermelon == TRUE) {
    "Buy 1 watermelon"
}

gf.watermelon

# Mr. Programmer
watermelon <- F

pro.orange <- if (watermelon == TRUE) {
    "Buy 1 orange"
} else {
    "Buy 6 oranges"   # As seen in class, print() is useless here.
}
pro.orange

# pro.watermelon <- ???

# I prefer a simple function, ifelse(test, yes, no)

watermelon <- F
ifelse(watermelon == TRUE, yes = "Buy 1 orange", no = "Buy 6 oranges")

# ifelse is vectorized
df$pass <- ifelse(test = df$score >= 65, yes = TRUE, no = FALSE)
df

# vectorized operation
df$pass2 <- df$score>=65;df

# Mr. Pro explains why he comes home with one orange for 3 times.

i <- 0
repeat {
    i <- i + 1
    cat("Because they have watermelons!  X", i, "\n")
    
    if (i>=3){
        break
    }
}



df.copy <- df
df.copy$score[2] <- df.copy$names[3] <- NA
df.copy

is.na(df.copy)

# Total number of cells with missing values
sum(is.na(df.copy))

# Whether a data point (row) is complete
complete.cases(df.copy)

!complete.cases(df.copy)

# Complete data points
df.copy[complete.cases(df.copy), ]

# Taking the average score
mean(df.copy$score)

mean(df.copy$score, na.rm = TRUE)

sum(df.copy$score)
sum(df.copy$score, na.rm = T)

na.omit(df.copy)



# Options in R that deals with missingness
# ?na.action

# Absolute value
abs(-3)

ceiling(3.14159); ceiling(-3.14159)

floor(3.14159); floor(-3.14159)

trunc(3.14159); trunc(-3.14159)

signif(3.14159, 3)

round(pi, digits = 10)

floor(9/2)

age <- c(1,6,4,5,8,5,4,3)
age

sum(age)

mean(age)

prod(age)

median(age)

var(age)
sd(age)

max(age)
min(age)
range(age)

age

which.max(age)   #returns the index of the greatest element of x
which.min(age)   #returns the index of the smallest element of x

seq(from = 0, to = 1, by = 0.25)
quantile(1:100, probs = seq(from = 0, to = 1, by = 0.25))
# Returns the specified quantiles.

age
unique(age)   # Gives the vector of distinct values

diff(age)   # Replaces a vector by the vector of first differences

sort(age, decreasing = T)   # Sorts elements into order

order(age)
age[order(age)]   # x[order(x)] orders elements of x

age
cumsum(age)    # Cumulative sums
cumprod(age)   # Cumulative products



df$pass2 <- NULL
df$student.no <- NULL
df

for (i in 1:4){
    df$student.no[i] <- paste("student", i)
}
df

n <- nrow(df)
plot(as.factor(df$student.no), df$curved,
     # Math symbols in text
     main = expression(paste("Score is ", alpha, ", curved score is ", sqrt(alpha)%*%10)),
     # Variable value in text
     xlab = paste("There are", n, "students"))

find <- "epib"
courses.EBOH <- c("epib601", "epib602", "bios601", "bios602", "math556", "math557")

grep(pattern = find, x = courses.EBOH, value = T)

grep(pattern = find, x = courses.EBOH, value = F)

grepl(pattern = find, x = courses.EBOH)

gsub(pattern = find, replacement = "EPIB", x = courses.EBOH)

regexpr(pattern = find, text = "I'm in epib 613! I'm in epib 607.")

gregexpr(pattern = find, text = c("I'm in epib 613. I'm in epib 607.",
                                  "I prefer epib 613."))

unlist(gregexpr(pattern = find, text = c("I'm in epib 613. I'm in epib 607.",
                                  "I prefer epib 613.")))

# ?sets
a <- 1:5
b <- 3:7

text1 <- c("epib", "bios", "math")
text2 <- c("epib", "pphs")

union(a, b)

intersect(a, b)

setdiff(a, b)

setdiff(b, a)

union(text1, text2)

intersect(text1, text2)

setequal(text1, text2)
