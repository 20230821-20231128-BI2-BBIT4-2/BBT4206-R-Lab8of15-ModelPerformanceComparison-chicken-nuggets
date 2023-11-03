## Required packages----
if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## caret
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## kernlab 
if (require("kernlab")) {
  require("kernlab")
} else {
  install.packages("kernlab", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## randomForest 
if (require("randomForest")) {
  require("randomForest")
} else {
  install.packages("randomForest", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}



## Loading the dataset----
data(BreastCancer)

BreastCancer <- na.omit(BreastCancer)


## Training the model----
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)


### CART 
set.seed(7)
Class_model_cart <- train(Class ~ ., data = BreastCancer,
                             method = "rpart", trControl = train_control)

### KNN 
set.seed(7)
Class_model_knn <- train(Class ~ ., data = BreastCancer,
                            method = "knn", trControl = train_control)

### SVM 
set.seed(7)
Class_model_svm <- train(Class ~ ., data = BreastCancer,
                            method = "svmRadial", trControl = train_control)

### Random Forest 
set.seed(7)
Class_model_rf <- train(Class ~ ., data = BreastCancer,
                           method = "rf", trControl = train_control)


results <- resamples(list( CART = Class_model_cart,KNN = Class_model_knn, SVM = Class_model_svm,
                          RF = Class_model_rf))

## results----
summary(results)

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
bwplot(results, scales = scales)

scales <- list(x = list(relation = "free"), y = list(relation = "free"))
dotplot(results, scales = scales)

splom(results)

## Pairwise xyPlots

xyplot(results, models = c("RF", "SVM"))

xyplot(results, models = c("SVM", "CART"))

## statistical significance test----
diffs <- diff(results)

summary(diffs)

