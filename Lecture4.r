########## Lecture 4 ##########
df <- read.csv("https://raw.githubusercontent.com/ly129/EPIB613_2020/master/scores.csv")
df <- df[1:5, ]
df

names(df)

# Recall the indexing system in R
df$students   # Select one variable

# Delete one variable
df$X <- NULL
df

df[, 2]

df[ , "scores"]

str(df[ , "scores"])   # 1D vector

df[ , "scores", drop = FALSE]
str(df[ , "scores", drop = FALSE])   # 4 x 1 data frame

df[1, ]
str(df[1, ])   # 1 x 4 data frame
# Can we drop a dimension here? Why?

df[1, , drop = TRUE]

# Delete variable "names" + reorder columns
df[ , c("students", "pass", "scores")]

# Select rows that passed
df[df$pass == TRUE, ]

df[df$students == "Lucy", ]

# Delete variable
df[ , -c(1, 2)]   # Delete the 1st and 2nd

# I believe that this used to work, but not anymore.
# df[ , -c("names", "score")]

# Now
drop <- c("students", "curve")
df[ , !names(df) %in% drop]

names(df)
!names(df) %in% drop

select = c("course", "scores", "pass")
df[ , names(df) %in% select]

# How does this work?
1 %in% c(1, 3, 5)
"b" %in% c("a", "c", "e")
1:10 %in% c(1, 3, 5)



df

# "select" argument selects columns
subset(df, select = c(students, pass))

# Can also delete unwanted columns
subset(df, select = -c(curve, pass))

# "subset" argument selects rows
# Can apply conditions
subset(df, subset = (scores > 80))

# Now use both select and subset arguments to apply conditions
# Select the names of those who passed
subset(df, select = students, subset = (pass == TRUE))

# Show the name and score of those who passed except Lucy.
# Recall logical operators &, | and !


library(dplyr)

df

# The column names must match exactly
new.students <- data.frame(students = c("Name", "Nom"),
                           course = 'epib607',
                           scores = c(79, 48),
                           curve = c(79, 48) * 1.1,
                           pass = c(TRUE, FALSE))
new.students

df.new <- rbind(df, new.students); df.new

# Option 1
df.copy <- df
df.copy$id1 <- 1:5
df.copy

# Option 2
df.copy <- data.frame(df, id2 = 1:5)
df.copy

# Option 3
id3 <- 1:5
df <- cbind(id3, df)
df

# df stores EPIB 607 scores
names(df)[1] <- "id"
df

# df.major stores student's ID and program of study of the entire department
df.major <- data.frame(id = 1:7,
                       major = c("MSc PH", "PhD Epi", "MSc Epi",
                                 "MSc PH", "MSc ExMed",
                                 "PhD Biostat", "MSc Biostat"))
df.major

merge(df, df.major, by = "id", all = TRUE)

merge(df, df.major, by = "id", all = F)


