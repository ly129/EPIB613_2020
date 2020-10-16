# The structure

func_name <- function(argument){
    statement
}

# Build the function
a_b <- function(a, b) {
    f = a - b
    return(f)
}

# Use the function
a_b(5, 3)

a_b(3, 5)

a_b(3, a = 5)

a_b(a = 5, b = 3)

a_b(b = 3, a = 5)

a_b(a = c(5,6,7), b = c(3,2,1))

# Recall
9 %/% 2
9 %% 2

int.div <- function(a, b){
    int <- floor(a/b)
    mod <- a - int*b
    return(list(integer = int, modulus = mod))
}

# Recall: how do we access the modulus?
result <- int.div(21, 4)
result$integer

int.div <- function(a, b){
    int <- a%/%b
    mod <- a%%b
    cat(a, "%%", b, ": \n integer =", int,"\n ------------------ \n modulus =", mod, "\n")
}
int.div(21, 4)

int.div <- function(a, b){
    int <- a%/%b
    mod <- a%%b
    return(c(a, b))
}
int.div(21, 4)

# No need to worry about the details here.
# Just want to show that functions do not always have to return() something.
AIcanadian <- function(who, reply_to) {
    system(paste("say -v", who, "Sorry!"))
}
# AIcanadian("Alex", "Sorry I stepped on your foot.")

# Train my chatbot - AlphaGo style.
# I'll let Alex and Victoria talk to each other.
# MacOS has their voices recorded.
# chat_log <- rep(NA, 8)
# for (i in 1:8) {
#     if (i == 1) {
#         chat_log[1] <- "Sorry I stepped on your foot."
#         system("say -v Victoria Sorry, I stepped on your foot.")
#     } else {
#         if (i %% 2 == 0)
#             chat_log[i] <- AIcanadian("Alex", chat_log[i - 1])
#         else
#             chat_log[i] <- AIcanadian("Victoria", chat_log[i - 1])
#     }
# }
# chat_log

data_summary <- function(func) {
    data <- read.csv("https://raw.githubusercontent.com/ly129/EPIB613_2020/master/scores.csv", header = TRUE)
    by(data = data$scores, INDICES = list(data$course), FUN = func)
}
data_summary(mean)

times_2_by_default_dislikes_3_hates_4 <- function(a, b = 2){
    if (b == 3) {
        warning("I dislike 3!")
    }
    
    if (b == 4) {
        stop("I hate 4!")
    }
    
    return(a*b)
}

times_2_by_default_dislikes_3_hates_4(a = 6)

times_2_by_default_dislikes_3_hates_4(a = 6, b = 3)

# times_2_by_default_dislikes_3_hates_4(a = 6, b = 4)

times_2_by_default_dislikes_3_hates_4(a = 6, b = 5)

# Sample data
set.seed(613)
students <- rep(c("Lucy", "John", "Mark", "Candy", "Chris"), 3)
course <- rep(c("epib601", "epib607", "epib613"), each = 5)
scores <- sample(50:100, size = 15, replace = T)

df <- data.frame(students, course, scores)
df <- df[sample(1:nrow(df)), ]
df

library(tidyverse)

df_wide <- pivot_wider(data = df, names_from = course, values_from = scores)
df_wide

df_long <- pivot_longer(data = df_wide, cols = contains("epib"), names_to = "course", values_to = "scores")
df_long

# ?dplyr::select # for how to select columns

my_wider <- function(data, pivot, names_from, values_from) {
    
}
