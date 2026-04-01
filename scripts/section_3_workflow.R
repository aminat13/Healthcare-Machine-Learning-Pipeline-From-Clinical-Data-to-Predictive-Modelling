#loading in data 
library(readxl)
data <-read_excel("Assignment section 3 data set.xlsx") 
df <- data

#setting diagnosis as factor 
df$diagnosis <- factor(df$diagnosis,
                       levels = c("B", "M"),
                       labels = c("Benign", "Malignant"))

#subsetting sets
train_set <- df[df$set == "train", ]
test_set  <- df[df$set == "test", ]

#dropping columns
library(dplyr)
train_set_clean <- train_set %>% select(-id, -set)
test_set_clean <- test_set %>% select(-id, -set)

###PART 1: 

#fit decision tree
library(rpart)

model_tree <- rpart(diagnosis ~ ., data = train_set_clean, method = "class")

#plot tree
par(xpd = TRUE)
plot(model_tree)
text(model_tree, use.n = TRUE)

#predict on test set
pred_tree <- predict(model_tree, newdata = test_set, type = "class")

#confusion matrix
conf_mat <- table(Actual = test_set$diagnosis, Predicted = pred_tree)
conf_mat

#balanced accuracy
sensitivity <- conf_mat["Malignant", "Malignant"] / sum(conf_mat["Malignant", ])
specificity <- conf_mat["Benign", "Benign"] / sum(conf_mat["Benign", ])
balanced_accuracy <- (sensitivity + specificity) / 2
balanced_accuracy


###PART 2: 

#fit random forest (at least 10 trees)
library(randomForest)

rf_model <- randomForest(diagnosis ~ ., data = train_set,
                         ntree = 100, nodesize = 1, importance = TRUE)

print(rf_model)

#predict on test set
rf_pred <- predict(rf_model, newdata = test_set, type = "class")

#confusion matrix
rf_conf_mat <- table(Actual = test_set$diagnosis, Predicted = rf_pred)
rf_conf_mat

#balanced accuracy
rf_sensitivity <- rf_conf_mat["Malignant", "Malignant"] / sum(rf_conf_mat["Malignant", ])
rf_specificity <- rf_conf_mat["Benign", "Benign"] / sum(rf_conf_mat["Benign", ])
rf_bal_acc <- (rf_sensitivity + rf_specificity) / 2
rf_bal_acc


###PART 3: 

#extracting importance 
importance(rf_model)
model_tree$variable.importance

#plotting important variables 
varImpPlot(rf_model)

#ranking variables 
rf_imp <- importance(rf_model)
rf_imp_sorted <- rf_imp[order(rf_imp[,1], decreasing = TRUE), ]
top10_rf <- rf_imp_sorted[1:5, ]
top10_rf

rt_imp <- model_tree$variable.importance
rt_imp_sorted <- sort(rt_imp, decreasing = TRUE)
top10_rt <- rt_imp_sorted[1:5]
top10_rt