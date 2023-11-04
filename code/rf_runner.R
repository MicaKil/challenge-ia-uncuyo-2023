library(caret)
library(randomForest)
library(dplyr)
library(ROSE)

train_data <- readRDS("data/data-parte-b/train_data_fe.rds")
test_data <- readRDS("data/data-parte-b/test_data_fe.rds")

# balanceo de clases
#train_data <- ovun.sample(inclinacion_peligrosa ~ ., data = train_data, method = "under")$data  # default p = 0.5

class_distribution <- table(train_data$inclinacion_peligrosa)
class_probability <- class_distribution / sum(class_distribution)
class_weights <- class_distribution[2] / class_distribution

# random forest
train_data$inclinacion_peligrosa <- factor(train_data$inclinacion_peligrosa)

formula <- inclinacion_peligrosa ~ circ_tronco_cm + lat + long + peligrosidad_especie + peligrosidad_diametro + peligrosidad_altura + peligrosidad_seccion
rf_model <- randomForest(formula,
                         data = train_data,
                         ntree = 600,
                         do.trace = TRUE,
                         mtry = 3,  # Number of variables randomly sampled at each split. Default values: for classification sqrt(p) and regression p/3
                         classwt = class_probability,
                         importance = TRUE,
                         proximity = TRUE,
                         )

predictions <- predict(rf_model, test_data)
predictions_numeric <- as.numeric(as.character(predictions)) # predictions es un factor, hay que pasarlo a numeric

result_dataset <- data.frame(id = test_data$id, inclinacion_peligrosa = predictions_numeric)
write.csv(result_dataset, "data/submissions/submission_40.csv", row.names = FALSE)

# comparación con el mejor valor
print("Comparación con el mejor valor")
sub <- read.csv("data/submissions/submission_38.csv")
percent <- sum(sub$inclinacion_peligrosa == 1) / nrow(sub) * 100
print(percent)

percent_prediction <- sum(predictions_numeric == 1) / length(predictions_numeric) * 100
print(percent_prediction)
