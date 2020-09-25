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

df[, 2, drop = F]

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
df$pass == T
df[df$pass == TRUE, ]

df[df$students == "Lucy", ]

# Delete variable
df[ , -c(1, 2)]   # Delete the 1st and 2nd

# I believe that this used to work, but not anymore.
# df[ , -c("names", "score")]

# Now
drop <- c("students", "curve")
df[ , !names(df) %in% drop]

df

names(df)
!names(df) %in% drop

select = c("course", "scores", "pass")
df[ , names(df) %in% select]

# How does this work?
1 %in% c(1, 3, 5)
"b" %in% c("a", "c", "e")
1:10 %in% c(1, 3, 5)

# df[row.cond, col.cond]
df[df$students != "Lucy" & df$pass == TRUE, c("students", "scores")]

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
subset(df, select=c(students, scores), subset= pass & students!="Lucy" )

# use of ()
x <- 1

(x <- 1)

df$pass & df$students!="Lucy"

(df$pass & df$students!="Lucy")

df$pass

df$pass == TRUE

library(dplyr)

df.step1 <- filter(df, pass & students != "Lucy"); df.step1

df.step2 <- select(df.step1, students, scores); df.step2

df %>% 
  filter(pass == T & students != "Lucy") %>%
  select(students, scores)

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

# Question from class:
# In case of duplicated variable names from both data frames that are not used for merging,
# keep only one of them.

# The merge() function does not seem to support it.
    # Maybe delete the unwanted one from one of the data frames before merging is easier.
# We can still do something on our own.

df.major$scores <- round(runif(7, 50, 100)); df.major

# Note how merge() treats duplicated variables (scores.x and scores.y)
merge(x = df, y = df.major, by = "id")

# We can change the suffixes
merge(df, df.major, by = "id", suffixes = c(".keep", ".discard"))

# Use functions that deal with character string in R
# ?grepl
grepl("a", c("abc", "bbc", "cbc"))

df.dup <- merge(df, df.major, by = "id", suffixes = c(".keep", ".discard"))
discard.flag <- grepl(".discard", names(df.dup))
df.dup[, !discard.flag]

# Replicate merging with dplyr

# Question from class: make a histogram from a frequency table
# <==> Switch a summary count data into raw data

ddd <- data.frame(Age = c(0,1,2,3), Freqency = c(4, 2, 1, 3))
ddd

# The apply family of functions will come later in the course
mapply(rep, ddd$Age, ddd$Freqency)

ddd.raw <- unlist(mapply(rep, ddd$Age, ddd$Freqency)); ddd.raw
hist(ddd.raw)
