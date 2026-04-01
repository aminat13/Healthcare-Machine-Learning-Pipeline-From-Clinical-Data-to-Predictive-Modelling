#loading in data 
install.packages("readxl")   # only the first time
library(readxl)
data <-read_excel("Assignment section 1 data set.xlsx", sheet=3) 
df <- data

####PART 1: EXPLORATORY DATA ANALYSIS

#summarising data
library(psych)
describe(df) 

#comparing sex differences 
sex_diff <- table(df$sex, df$group)
barplot(sex_diff,
        beside = TRUE,
        names.arg = c("Control", "Acupuncture"),
        legend.text = c("Female", "Male"),
        xlab = "Treatment Group",
        ylab = "Count",
        col = c("pink", "lightblue"))


#comparing migraine differences 
migraine_diff <- table(df$migraine, df$group)
barplot(migraine_diff,
        beside = TRUE,
        names.arg = c("Control", "Acupuncture"),
        legend.text = c("No Migraine", "Migraine"),
        xlab = "Treatment Group",
        ylab = "Count",
        col = c("lightgrey", "orange"))

#comparing age differences 
boxplot(age ~ group, data = df,
        names = c("Control", "Acupuncture"),
        xlab = "Treatment Group",
        ylab = "Age",
        col = c("lightblue", "lightgreen"))

#comparing chronicity differences
boxplot(chronicity ~ group, data = df,
        names = c("Control", "Acupuncture"),
        xlab = "Treatment Group",
        ylab = "Years with Headache",
        col = c("lightblue", "lightgreen"))

#removing withdrawals 
library(dplyr)
df <- df %>%
  filter(is.na(withdrawal_reason))

###PART2: MODEL BUILDING

#setting levels
df$group <- factor(df$group,
                   levels = c(0,1),
                   labels = c("Control", "Acupuncture"))
#model 1 building 

model_1 <- glm(response ~ group, data=df, family=binomial)
summary(model_1)
cbind(
  coef(model_1),
  exp(coef(model_1)),
  exp(confint.default(model_1))
)

model_1$null.deviance
model_1$deviance

#model 2 building 
model_2 <- glm(response ~ group*migraine, data=df, family=binomial)
summary(model_2)
cbind(
  coef(model_2),
  exp(coef(model_2)),
  exp(confint.default(model_2))
)

model_2$null.deviance
model_2$deviance

#model 3 building 
model_3 <- glm(response ~ group*sex, data=df, family=binomial)
summary(model_3) 
cbind(
  coef(model_3),
  exp(coef(model_3)),
  exp(confint.default(model_3))
)

model_3$null.deviance
model_3$deviance

#creating new change variables
df$med_change <- df$painmedspk5 - df$painmedspk1
df$gen_change <- df$gen5 - df$gen1

#model 4 building
model_4 <- lm(gen_change ~ group, data=df)
summary(model_4)
coef(model_4)
confint(model_4)

#model 5 building
model_5 <- lm(med_change ~ group, data=df)
summary(model_5)
coef(model_5)
confint(model_5)


