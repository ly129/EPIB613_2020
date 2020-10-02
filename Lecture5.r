head(iris)

summary(iris)

# Some parameters related to titles, labels, limits...
plot(x = iris$Sepal.Length, y = iris$Sepal.Width,
#      main = "Sepal Width vs. Sepal Length",    # Title
#      sub = "Iris",                             # Sub title
#      xlim = range(iris$Sepal.Length),          # limits of x-axis
#      ylim = c(1, 10),                          # Limits of y-axis
#      xlab = "Sepal Length",                    # Label of x-axis
#      ylab = "Sepal Width",                     # Label of y-axis
#      log = "xy"                                # Axis to be set on log scale
#      col = iris$Species,                       # color
#      pch = as.numeric(iris$Species),           # point type
#      axes = F,
)            
# x and y are arguments - these two are sufficient for a plot
# In this plot, I specified some most basic graphical parameters.

# Add legends
legend("topleft",
       legend = unique(iris$Species),
       col = unique(iris$Species),
       pch = as.numeric(unique(iris$Species))
)

# ggplot2
library(ggplot2)
e <- ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species, shape = Species)) +
        geom_point(size = 3) +
        labs(title = "Sepal Width vs. Sepal Length",
             subtitle = "Iris",
             x = "Sepal Length",
             y = "Sepal Width")
e

# Some parameters related to text and plot size.
plot(mdeaths,
#      type = "b",    # Type of plot
#      pch = ,     # plotting symbols, 1~25 plus anything you want.
#      cex = 2,       # Plotting text and symbol size
#      cex.axis = 2,  # Axis annotation size
#      main = "Sepal Length", 
#      cex.main = 2,  # Title text size
#      cex.lab = 1,   # Axis label size
#      lwd = 1,       # Line width
#      lty = 4
)

table(iris$Species)

pie(x = table(iris$Species),
#     col = 1:3,
    clockwise = T,
    main = "Species of Iris",  
)

# Some parameters related to colors
# par(bg = "lightgreen") # par() sets graphical parameters before plots.

hist(iris$Sepal.Length,
#      freq = F,             # count or proportion
#      breaks = 15,
#      breaks = seq(from = 4,to = 8,by = 0.5),
#      xlim = range(iris$Sepal.Length),
#      main = "Histogram of Sepal Length",
#      sub = "Iris",
#      xlab = "Sepal Length",
#      col.main = "blue",
#      col.axis = 2,
#      col.lab = "#009933",
#      col.sub = 4,           # multiple ways to specify color.
#      col = "darkgreen",
#      border = "blue",       # Color of border of the bars
#      density = 2,           # density of shading lines
#      angle = 15             # angle of shading lines, in degrees.
)
# border, density and angle are parameters specific to hist().
# Mostly showed parameters related to colors.
# Sorry I am really really really bad with colors.

table(iris$Species)
barplot(table(iris$Species))

par(mar = c(8, 4, 4, 2) + 0.1) 
# Set the margins around the plotting area
plot(table(iris$Species), type = "h", las = 2)
# las controls the orientation of axis annotations.

boxplot(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width)

fx1 <- function(x){x^2-10}
fx2 <- function(x){x^3}

# plot(fx1)

curve(fx1,
      xlim = c(-10, 10), ylim = c(-10, 10),
      col = 2, lty = 1)
curve(fx2, add = TRUE,   # add is an parameter in curve()
      col = 3, lty = 2)  # TRUE -> plot on the existing plot

x <- seq(from = -10, to = 2, by = 0.25)
y1 <- exp(x[1:24])
y2 <- exp(x[25:49])
points(x=x[1:24], y=y1, pch = ">")  # Add these points to the existing plot
lines(x=x[25:49], y=y2)
# Add the smooth line containing these points to the existing plot
# lines(x=x, y=y)     

abline(h = 5, lty = 3)      # h -> horizontal line at y = 5 
abline(v = -8, lty = "dotdash")     # v => vertical line at x = -8

abline(a = 0, b = 1/2)      # y = a + bx

# legend
legend("topright",       # Can also be "top", "bottomright", ...
       c(expression(paste(x^2-10)), expression(paste(x^3))),
       col = c(2,3),      # Usually corresponds to the plot
       lty = c(1,2),
       text.col = c(2,3))

xx <- seq(from = -10, to = 10, by = 0.1)
yy <- dnorm(xx, mean = 0, sd = 2)  
# dnorm() gives the normal distribution density
plot(x = xx, y = yy, type = "l", main = "PDF of Normal(0, 2)",
     axes = F,      # Suppress axes
     xlab = "x", ylab = "Density"
)
# axis() allows us to customize axes.
axis(1, at = seq(from = -10, to = 10, by = 4))
axis(2, at = seq(from = 0, to = 1, by = 0.02))
grid(col = "red")   # add grid lines.
# Explore the parameters allowed in grid()

par(mfrow = c(2,2),                # 2 x 2 = 4 plots on the same page,
    mar = c(3, 2, 1, 1) + 0.1)     # mar allows us to change margins
plot(lm(Sepal.Length~Petal.Length, data = iris))
# lm() for linear regression - EPIB 621 material
# Plot your linear regression object will give 4 diagnostic plots.

matrix(c(1,1,2,3), 2, 2, byrow = TRUE)

nf <- layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
par(mar = c(3, 2, 1, 1) + 0.1)
# layout.show(nf)  # Shows the partition of the plotting area
plot(x=x, y=c(y1, y2), type = "l")
plot(x=xx, y=yy, type = "l")
boxplot(iris$Sepal.Length, iris$Petal.Length)

# pdf(file = "Normal_Density.pdf")

# plot(x = xx, y = yy, type = "l", main = "PDF of Normal(0, 2)",
#      axes = F, xlab = "x", ylab = "Density")
# axis(1, at = seq(from = -10, to = 10, by = 2))
# axis(2, at = seq(from = 0, to = 1, by = 0.02))
# grid()

# dev.off()


