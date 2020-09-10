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
course

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

letters <- letters[1:3]; letters
class(letters)

logical <- c(TRUE, FALSE)
class(logical)

factor <- as.factor(letters[1:3]); print(factor)
class(factor)

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

data <- data.frame(drug, cured, bmi.cat, age.cat) # Make our data frame
head(data, 10)

# The table below shows the first 10 rows of the fake dataset.
# This is a typical dataset you will see in Epidemiology.
# Each row is a patient, with their own information.
# Goal is to assess the drug effectiveness.

# By tabulating the data, we can assess the association (EPIB 601 material).
# If we only tabulate drug and outcome (cured or not), we get a 2x2 table
    ## which is a matrix or a 2-dimensional array.
# 1st dimension: drug, 2nd dimension: cured

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

score

str(df) # checking the structure of an object

mylist <- list("Red", factor(c("a","b")), c(21,32,11), TRUE)
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

-1:10 # Integers, by increments of 1.

seq(from = 0.33, to = 9.33, by = 3)

seq(from = 0, to = 1, length = 5)

rep(1.2, times = 5)

rep(c("six", "one", "three"), times = 2)

rep(c("six", "one", "three"), each = 2)

sequence(5)

sequence(c(6, 1, 3))

# Can you make a numeric vector (-4, -3, -2, 0, 0.5, 1, 0, 0.5, 1, 1, 1, 2, 2, 3, 3)?

a <- c(1, 8, 8)
b <- c(2, 8, 4)

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


