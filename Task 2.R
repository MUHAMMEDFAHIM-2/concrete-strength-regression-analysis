install.packages(c("readxl","dplyr","ggplot2","corrplot","car","psych","GGally"))

## Load packages
library(readxl)
library(dplyr)
library(ggplot2)
library(corrplot)
library(psych)
library(car)
library(GGally)
library(lmtest)    # Breusch–Pagan (heteroscedasticity)


## Load data
raw <- read_excel("concrete compressive strength.xlsx")


## Inspect raw
str(raw)
cat("\nRows:", nrow(raw), "  Cols:", ncol(raw), "\n")


## Column renaming 
names(raw) <- c(
  "Cement", "Slag", "FlyAsh", "Water", "Superplasticizer",
  "CoarseAgg", "FineAgg", "Age", "ConcreteCategory",
  "ContainsFlyAsh", "Strength"
)


## Basic cleaning 
# Drop duplicate rows
dups_n <- sum(duplicated(raw))
cat("\nDuplicate rows detected:", dups_n, "\n")
concrete <- raw %>% distinct()    # removes duplicates


# Convert categorical to factor
concrete$ConcreteCategory <- as.factor(concrete$ConcreteCategory)
concrete$ContainsFlyAsh <- as.factor(concrete$ContainsFlyAsh)


# Quick NA check
na_counts <- sapply(concrete, function(x) sum(is.na(x)))
cat("\n--- NA COUNTS PER COLUMN ---\n")
print(na_counts)

#descriptive statistics
describe(concrete)


# Select only numeric columns
num_vars <- concrete %>%
  select(Cement, Slag, FlyAsh, Water, Superplasticizer,
         CoarseAgg, FineAgg, Age, Strength)


# Compute correlation matrix
corr_matrix <- cor(num_vars)


# Display as heatmap
corrplot(corr_matrix, method = "color", tl.cex = 0.8, addCoef.col = "black",
         number.cex = 0.7, title = "Correlation Heatmap", mar=c(0,0,2,0))


# Pairwise scatterplots (only main variables)
GGally::ggpairs(
  concrete,
  columns = c("Cement", "Water", "Age", "Superplasticizer", "Strength"),
  title = "Pairwise Relationships among Key Variables"
)


# Histogram
ggplot(concrete, aes(x = Strength)) +
  geom_histogram(fill = "#0073C2", color = "white", bins = 30) +
  labs(title = "Distribution of Concrete Compressive Strength",
       x = "Strength (MPa)", y = "Count")


# QQ Plot
qqPlot(concrete$Strength, main = "Q-Q Plot for Compressive Strength")


#Boxplot
ggplot(concrete, aes(x = ContainsFlyAsh, y = Strength, fill = ContainsFlyAsh)) +
  geom_boxplot() +
  labs(title = "Compressive Strength by Fly Ash Usage",
       x = "Contains Fly Ash", y = "Strength (MPa)")


# Shapiro–Wilk Test
shapiro.test(concrete$Strength)


#Kolmogorov–Smirnov Test
ks.test(concrete$Strength, "pnorm", mean(concrete$Strength), sd(concrete$Strength))


# Create a log-transformed variable
concrete$LogStrength <- log(concrete$Strength)

# Test normality again
shapiro.test(concrete$LogStrength)

#visualize again
qqPlot(concrete$LogStrength, main = "Q-Q Plot for Log-Transformed Strength")


#One way Anova
anova1 <- aov(Strength ~ ContainsFlyAsh, data = concrete)
summary(anova1)


boxplot(Strength ~ ContainsFlyAsh, data = concrete,
        col = c("#FF9999", "#66CCFF"),
        main = "Compressive Strength by Fly Ash Usage",
        xlab = "Contains Fly Ash", ylab = "Strength (MPa)")


# Two way Anova
concrete$AgeGroup <- cut(concrete$Age,
                         breaks = c(0, 28, 90, 365),
                         labels = c("Early", "Medium", "Late"))

anova2 <- aov(Strength ~ ContainsFlyAsh * AgeGroup, data = concrete)
summary(anova2)


# Multiple linear regression model
model1 <- lm(LogStrength ~ Cement + Slag + FlyAsh + Water + 
               Superplasticizer + CoarseAgg + FineAgg + Age, 
             data = concrete)

summary(model1)


#Residual plots
par(mfrow=c(2,2))
plot(model1)S


#Multicollinearity
vif(model1)


# Residual normality
shapiro.test(resid(model1))
qqPlot(resid(model1), main="Q-Q Plot of Model Residuals")

bptest(model1) 

durbinWatsonTest(model1)


# Refining the Model
model2 <- lm(LogStrength ~ Cement + Water + Superplasticizer + Age, data = concrete)
summary(model2)

# Comparing
anova(model1, model2)


concrete$PredictedStrength <- exp(predict(model2))
concrete$PredictedStrength

