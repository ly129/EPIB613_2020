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
# write.csv(df, file = "~/Desktop/df.csv")

exercise.l3 <- read.csv("https://raw.githubusercontent.com/ly129/EPIB613_2020/master/scores.csv")

exercise.l3 <- exercise.l3[exercise.l3$course == "epib607", c("students", "course", "scores")]

exercise.l3$students <- letters[1:5]

sample.index <- sample(1:5, size = 3, replace = F)

exercise.l3 <- exercise.l3[sample.index, ]

exercise.l3 <- exercise.l3[order(exercise.l3$scores, decreasing = T), ]

exercise.l3

# save.image("path/xxxx.RData")
# write.csv(exercise.l3, "path/xxxx.csv")


