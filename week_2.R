library(tidyverse)
library(caret)
library(pROC)
library(glmnet)

# Set metaparameters
set.seed(42)

# Import and define training and testing data
diabetes_data <- read_csv('data/pima-indians-diabetes.csv',
                          col_names = c('preg', 'gluc', 'blood', 'skin',
                                        'ins', 'bmi', 'diab', 'age', 'class'))

train_inds <- sample(1:nrow(diabetes_data), 
                     size = floor(0.6 * nrow(diabetes_data)))
train_data <- diabetes_data[train_inds,]
test_data <- diabetes_data[-train_inds,]

#### Exercise 1 ####
# Fit the model on training data
model <- glm(class ~ ., data = train_data, family = 'binomial')

# Predict probabilities on test data
test_probs <- predict(model, test_data, type = 'response')

# Plot prediction results against actuals
testing <- tibble(probs = test_probs, 
                  actuals = as.factor(test_data$class))

ggplot(testing, aes(x = actuals, y = probs, color = actuals)) +
  geom_point(position = position_jitter(0.1)) +
  xlab('Actual class') + ylab('Predicted probabilities') +
  ggtitle('Diabetes predictions vs actuals')
  
ggplot(testing, aes(x = probs, fill = actuals)) +
  geom_histogram(color = 'black', position = 'dodge', binwidth = 0.1) +
  ggtitle('Diabetes predictions vs actuals') +
  xlab('Predicted probabilities') + ylab('Count') +
  ggtitle('Diabetes predictions vs actuals')

# Plot ROC curve and compute AUC
roc_output <- roc(testing$actuals, testing$probs)
plot.roc(roc_output)
roc_output$auc

# Compute precision-recall curve and plot
precisions <- 1:101
recalls <- 1:101
thresholds <- seq(0,1,0.01)

test_actuals <- testing$actuals == 1

for (i in 1:101){
  test_preds <- testing$probs > thresholds[i]
  tp <- sum(test_actuals & test_preds)
  fp <- sum(!test_actuals & test_preds)
  tn <- sum(!test_actuals & !test_preds)
  fn <- sum(test_actuals & !test_preds)
  prec <- tp / (tp + fp)
  recall <- tp / (tp + fn)
  precisions[i] <- prec
  recalls[i] <- recall
}

precisions[is.na(precisions)] <- 1

ggplot() +
  geom_line(aes(x = recalls, y = precisions)) +
  xlab('Recall') + ylab('Precision') +
  ggtitle('Precision-recall curve')

#### Exercise 2 ####
# Redefine training and testing data
X_train <- train_data[,c('preg', 'gluc', 'blood', 'skin',
                         'ins', 'bmi', 'diab', 'age')] %>%
  as.matrix()
X_test <- test_data[,c('preg', 'gluc', 'blood', 'skin',
                        'ins', 'bmi', 'diab', 'age')] %>%
  as.matrix()
y_train <- train_data$class
y_test <- test_data$class

# Fit the (LASSO) model on training data using cross-validation
cvfit <- cv.glmnet(X_train, y_train, family = 'binomial', alpha = 1)

# Predict probabilities on test data
test_probs <- predict(cvfit, newx = X_test, type = 'response', s = "lambda.min")

# Plot prediction results against actuals
testing <- tibble(probs = test_probs, 
                  actuals = as.factor(test_data$class))

ggplot(testing, aes(x = actuals, y = probs, color = actuals)) +
  geom_point(position = position_jitter(0.1)) +
  xlab('Actual class') + ylab('Predicted probabilities') +
  ggtitle('Diabetes predictions vs actuals (LASSO model)')

ggplot(testing, aes(x = probs, fill = actuals)) +
  geom_histogram(color = 'black', position = 'dodge', binwidth = 0.1) +
  ggtitle('Diabetes predictions vs actuals') +
  xlab('Predicted probabilities') + ylab('Count') +
  ggtitle('Diabetes predictions vs actuals (LASSO model)')

# Plot ROC curve and compute AUC
roc_output <- roc(testing$actuals, testing$probs)
plot.roc(roc_output)
roc_output$auc

# Compute precision-recall curve and plot
precisions <- 1:101
recalls <- 1:101
thresholds <- seq(0,1,0.01)

test_actuals <- testing$actuals == 1

for (i in 1:101){
  test_preds <- testing$probs > thresholds[i]
  tp <- sum(test_actuals & test_preds)
  fp <- sum(!test_actuals & test_preds)
  tn <- sum(!test_actuals & !test_preds)
  fn <- sum(test_actuals & !test_preds)
  prec <- tp / (tp + fp)
  recall <- tp / (tp + fn)
  precisions[i] <- prec
  recalls[i] <- recall
}

precisions[is.na(precisions)] <- 1

ggplot() +
  geom_line(aes(x = recalls, y = precisions)) +
  xlab('Recall') + ylab('Precision') +
  ggtitle('Precision-recall curve (LASSO model)')
