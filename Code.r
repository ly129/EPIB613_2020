########## Lecture 2 ##########

2+5
2-5
2*5
2/5

2e3

2^3; 8^(1/3)

sqrt(4)

log(4)    # Natural log

exp(2)

# Usually
x <- 5
x

y <- z <- 6
y
z

# <- , = and -> are equivalent when we assign values
instructor <- "Yi"
course = "EPIB 613"
"Fall 2020" -> semester

instructor; course; semester

x + y

one.over.three <- 1/3
print(one.over.three)

one.over.three * 3

# If we copy-paste the result instead of saving it in an object
0.3333333 * 3
# loss of precision

course <- "EPIB 613"
Course <- "EPIB 601"
Course

x

x <- y
x

number <- c(1, 2, 3)
class(number)

# As in most programming languages, there are integers and floating-point numbers in R
class(5L)

# Double precision floating-point numbers in R
# is.double() checks whether an object is a double precision floating-point number
is.double(5); is.double(5L)

# How precise is double precision?
print(1/3)
options(digits = 22) # show more decimal points
print(1/3)
options(digits = 7) # reset to default

letter <- letters[1:3]; letter
class(letter)

logical <- c(TRUE, FALSE)
class(logical)

factor <- as.factor(letters[1:3]); print(factor)
class(factor)

mixed.factor <- factor(c(1,3,4,23423, "epib", "fall2020", T, F))
mixed.factor

x <- 5; x

days.per.month <- c(31,28,31,30,31,30,31,31,30,31,30,31)
days.per.month

# We can add names to the vector for each entry
names(days.per.month) <- c('jan', 'feb', 'mar', 'apr', 
                           'may', 'jun', 'jul', 'aug',
                           'sep', 'oct', 'nov', 'dec')
print(days.per.month)

# But the names will not affect calculations.
sum(days.per.month)

mymatrix1 <- matrix(c(3:14), nrow = 4, byrow = TRUE)
print(mymatrix1)

mymatrix2 <- matrix(c(3:14), nrow = 4, byrow = FALSE)
print(mymatrix2)

rownames <- c("row1", "row2", "row3", "row4")
colnames <- c("col1", "col2", "col3")
rownames(mymatrix1) <- rownames
colnames(mymatrix1) <- colnames
print(mymatrix1)

myarray <- array(1:24, dim = c(4,3,2))
print(myarray)

# Don't worry about the data generating process.
set.seed(6132020) # Make random numbers generated from sample() reproducible.

# A fake observation study
# Randomly assign ~60% of patients to take drug
drug <- sample(c(0,1), size = 100, replace = TRUE, prob = c(0.6, 0.4))

# Randomly assign ~20% of patients to be cured with or without taking the drug.
cured <- sample(c(0,1), size = 100, replace = TRUE, prob = c(0.2, 0.8))

# Some factors that may affect the efficacy of the drug
bmi.cat <- sample(1:3, size = 100, replace = TRUE) # Randomly assign BMI categories
age.cat <- sample(1:4, size = 100, replace = TRUE) # Randomly assign age categories

sex <- as.character(sample(c("female", "male"), size = 100, replace = TRUE))

data <- data.frame(drug, cured, bmi.cat, age.cat, sex) # Make our data frame
data$sex <- as.character(data$sex)
head(data, 10)

# The table below shows the first 10 rows of the fake dataset.
# This is a typical dataset you will see in Epidemiology.
# Each row is a patient, with their own information.
# Goal is to assess the drug effectiveness.

# By tabulating the data, we can assess the association (EPIB 601 material).
# If we only tabulate drug and outcome (cured or not), we get a 2x2 table
    ## which is a matrix or a 2-dimensional array.
# 1st dimension: drug, 2nd dimension: cured

data$drug <- factor(data$drug, levels = c(1,0))
data$cured <- factor(data$cured, levels = c(1,0))

table(data[c("drug", "cured")])

# This may not be enough, we want to see how people with different BMI may differ.
    ## Confounder, also 601 material
# We now need a 2x2x3 table, which is a 3-dimensional array.
# 1st dimension: drug, 2nd dimension: cured, 3rd dimension: bmi.cat

table(data[c("drug", "cured", "bmi.cat")])

# Further include age to see how age category comes into the association
# We now need a 2x2x3x4 table, which is a 4-dimensional array.
# 1st dimension: drug, 2nd dimension: cured, 3rd dimension: bmi.cat, 4th dimension: age.cat

# table(data)

names <- c("Lucy", "John", "Mark", "Candy")
score <- c(67, 56, 87, 91)
pass <- c(T, F, T, T)
df <- data.frame(names, score, pass); print(df)

str(df) # checking the structure of an object

mylist <- list("Red", factor(c("a","b")), matrix(c(21,32,11, 22,1,1), nrow = 3), TRUE)
print(mylist)

str(mylist)

ch.letter <- letters[1:3]
print(ch.letter)

class(ch.letter)

fac.letter <- as.factor(letters[1:3])
print(fac.letter)
# Note the additional 'Levels: a b c' in the output

class(fac.letter)
# Should factor be considered as a data structure or a data type?

factor(1:10)

c(-1, 5.44, 100, 34123)

c(-1, "epib")   # a character '-1'

-1:10 # Integers, by increments of 1.

(-1:10) * 0.1

seq(from = 0.33, to = 9.33, by = 3)

seq(from = 0, to = 1, length = 5)

rep(1.2, times = 5)

rep(c("six", "one", "three"), times = 2)

rep(c("six", "one", "three"), each = 2)

sequence(5)

sequence(c(6, 1, 3))

# Can you make a numeric vector (-4, -3, -2, 0, 0.5, 1, 0, 0.5, 1, 1, 1, 2, 2, 3, 3)?

c(-4:-2, rep(seq(from = 0, to = 1, by = .5), times = 2), rep(c(1,2,3), each = 2))

(0:2) * 0.5

a <- c(1, 8, 8)
b <- c(2, 8, 4)
a; b

a+1 # here 1 is considered as a vector (1, 1, 1)

a+b

a*b

a^2

c <- matrix(c(1,2,3,4), nrow = 2, byrow = T)
d <- matrix(c(5,6,7,8), nrow = 2, byrow = F)
print(c); print(d)

c+1

c+d

c*d

c^2

a
sum(a)

c; rowSums(c)

a %*% b

a %o% b

c %*% d

# Recall vector a and b from above.
print(a); print(b)

a == b # Equal or not?

a != b # Not equal?

a > b

a <= b

# And
a; b
a>5 & b>5

# Or
a>=5 | b>=5

"ABC" == "ABC"

"ABC" == "abc"

TRUE + TRUE + FALSE # True = 1, False = 0.

random.numbers <- rnorm(10)* 100;
random.numbers

random.numbers > 10
# How many?
sum(random.numbers>10)

students<- c('a','b','c','d','e')
scores.607 <- c(80, 99, 55, 70, 84)
scores.613 <-c(85, 90, 62, 40, 88)
Curved.607 <-scores.607 *1.1
Curved.613<-scores.613*1.1
Pass.607<-c(T,T,F,T,T)
Pass.613<-c(T,T,T,F,T)
Df<-data.frame(students, scores.607, scores.613, Curved.607, Curved.613, Pass.607, Pass.613)
Df

students <- c(rep(letters[1:5], times = 2))
scores <-  c(80, 99, 55, 70, 84, 85, 90, 62, 40, 88)
course <- rep(c("epib607", "epib613"), each = 5)
curve <- scores*1.1
pass <- curve >= 65 
df <- data.frame(students, course, scores, curve, pass); df

########## Lecture 3 ##########
vector <- c(6, 13, 20, 2, 0)
vector

# Pick the 2nd
vector[2]

# Pick 2nd - 4th
vector[2:4]

# Pick no. 1, 3, 5
vector[c(1, 3, 5)]

# Code like a pro
# This good practice makes it clearer for revisits and/or edits
# Reproducibility!

# Pick no. 1, 3, 5
index.integer <- c(1, 3, 5)
vector[index.integer]

# Re-order
vector[c(5,4,3,2,1)]

vector

order.index <- order(vector, decreasing = F)
order.index

vector[order.index]

# delete the 2nd and 4th - equivalent to keeping the rest
vector[-c(2,4)]

# change the value of the 5th
vector.new <- vector
vector.new[5] <- 1
vector.new

# Note that the logical index has to have the same dimension as the object
index.logical <- c(T, F, T, F, T)
vector[index.logical]

# Usually we don't manually type T's and F's
vector[vector>4]

# How does it work?
vector>4

# Recall that we could give names to vector entries
names(vector) <- c("course level", "course code", "century", "decade", "year"); vector

vector["century"]

index.character <- c("course level", "course code")
vector[index.character]

vector[rep("century", 3)]

matrix <- matrix(c(3:14), nrow = 4, byrow = TRUE)
print(matrix)
# Note that the indices are given.

# The entry on the 2nd row 3rd column
matrix[2, 3]

# The 2nd row
matrix[2, ]

# The 1st and 3rd column
matrix[ , c(1, 3)]

# Change the order of columns. 
matrix[ , c(3, 1)]

# Column 1 and 2, row 2 and 4
matrix[c(2,4), c(1,2)]

# Delete the 3rd row
matrix[-3, ]

rownames(matrix)
colnames(matrix)

# Recall that we could give names to columns and rows

row.names <- c("row1", "row2", "row3", "row4")
col.names <- c("col1", "col2", "col3")
rownames(matrix) <- row.names
colnames(matrix) <- col.names
matrix

rownames(matrix)
colnames(matrix)

matrix(1:12, nrow = 4, dimnames = list(row.names, col.names))

matrix["row1", ]
# The output is a named vector as a result of dimension reduction

matrix["row2", "col3"]

array <- array(3:14, dim = c(2, 3, 2))
print(array)

array[ , , 1]

array[2, 3, 2]

array[1, , 2]

array[ , 1 , ]

df <- data.frame(names = c("Lucy", "John", "Mark", "Candy"),
                 score = c(67, 56, 87, 91))

df

df[2, ]
str(df[2, ])
# What is the structure of the result? Why?

df[ , 1]
# What is the structure of the result?

df[, 1, drop = F]
# What about now?

# There are column (variable) names that are ready to be used in data frames.
names(df)

print(df[, "names"])

df$names
# data.frame$variable.name gives the variable.

# Usually the str() functions will give you an idea on how to access values in R objects
str(df)

summary(df$score)

str(summary(df$score))

summary(df$score)[3]

attr(summary(df$score), "names")

# What is John's score?
df[df$names == "John",]

# How does this work?
df$names
df$names == "John"

# Anyone scored 100?
print(df[df$score == 100,])

# Highest score?
max(df$score)     # max() for maximum

# Who had the highes score?
df[df$score == max(df$score), ]

# Note that this is still a data frame.
str(df[df$score == max(df$score), ])

# I only need the name.
df[df$score == max(df$score), ]$names

# Change the order of the columns
df[ , c("score", "names")]
# By now you should have realized that,
# we change the order of columns by picking the columns
# in the order that we want.

list <- list("Red", factor(c("a","b")), c(21,32,11), TRUE)
print(list)

# single bracket gives the entire "sub-list"
# double bracket gives the R object stored in the "sub-list"
print(list[3])

list[3][[1]]

list[[3]]

str(print(list[3]))

str(print(list[[3]]))

list[[3]][2]

named.list <- list(course = "EPIB 613",
                   year = 2020,
                   pass.fail = T)
print(named.list)

str(named.list)

named.list$year

head(mtcars) # You can use this dataset directly whenever you want.

# data() # Shows all datasets in base R.

# head(cancer)
# Load 'cancer' data before loading the 'survival' package will result in error.
library(survival)
head(cancer)

df
write.csv(df, file = "~/Desktop/df.csv")

exercise.l3 <- read.csv("https://raw.githubusercontent.com/ly129/EPIB613_2020/master/scores.csv")

exercise.l3 <- exercise.l3[exercise.l3$course == "epib607", c("students", "course", "scores")]

exercise.l3$students <- letters[1:5]

sample.index <- sample(1:5, size = 3, replace = F)

exercise.l3 <- exercise.l3[sample.index, ]

exercise.l3 <- exercise.l3[order(exercise.l3$scores, decreasing = T), ]

exercise.l3

# save.image("path/xxxx.RData")
# write.csv(exercise.l3, "path/xxxx.csv")
