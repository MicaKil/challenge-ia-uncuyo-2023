# library(caret)
# library(randomForest)
# library(dplyr)
# library(ROSE)

# train_data <- read.csv("data/data-parte-b/arbolado-mza-dataset.csv")
# train_data$ultima_modificacion <- NULL
# train_data$area_seccion <- NULL
# train_data$nombre_seccion <- NULL
# train_data$seccion <- NULL
#
# test_data <- read.csv("data/data-parte-b/arbolado-mza-dataset-test.csv")
# test_data$ultima_modificacion <- NULL
# test_data$area_seccion <- NULL
# test_data$nombre_seccion <- NULL
# test_data$seccion <- NULL

# feature engineering --------------------------------------------------------------------------------------------------
# peligrosidad_encoding <- function(data, column, new_column) {
#     peligrosidad <- data %>%
#         dplyr::group_by(!!sym(column)) %>%
#         dplyr::summarize(peligrosa_count = sum(inclinacion_peligrosa == 1), total_count = n()) %>%
#         dplyr::mutate({{new_column}} := peligrosa_count / total_count)
#
#     return(peligrosidad)
# }
#
# # especies peligrosas
# especies_peligrosas <- peligrosidad_encoding(train_data, "especie", "peligrosidad_especie")
#
# train_data <- train_data %>%
#     left_join(especies_peligrosas %>% select(especie, peligrosidad_especie), by = "especie")
#
# train_data$especie <- NULL
#
# test_data <- test_data %>%
# 	left_join(especies_peligrosas %>% select(especie, peligrosidad_especie), by = "especie")
#
# test_data$especie <- NULL
#
# # diametro peligroso
# diametro_peligroso <- peligrosidad_encoding(train_data, "diametro_tronco", "peligrosidad_diametro")
#
# train_data <- train_data %>%
#     left_join(diametro_peligroso %>% select(diametro_tronco, peligrosidad_diametro), by = "diametro_tronco")
#
# train_data$diametro_tronco <- NULL
#
# test_data <- test_data %>%
# 	left_join(diametro_peligroso %>% select(diametro_tronco, peligrosidad_diametro), by = "diametro_tronco")
#
# test_data$diametro_tronco <- NULL
#
# # altura peligrosa
# altura_peligrosa <- peligrosidad_encoding(train_data, "altura", "peligrosidad_altura")
#
# train_data <- train_data %>%
# 	left_join(altura_peligrosa %>% select(altura, peligrosidad_altura), by = "altura")
#
# train_data$altura <- NULL
#
# test_data <- test_data %>%
# 	left_join(altura_peligrosa %>% select(altura, peligrosidad_altura), by = "altura")
#
# test_data$altura <- NULL
#
# # guardar con feature engineering
# write.csv(train_data, "data/data-parte-b/train-data-FE.csv", row.names = FALSE)
# write.csv(test_data, "data/data-parte-b/test-data-FE.csv", row.names = FALSE)

train_data <- read.csv("data/data-parte-b/train-data-FE.csv")
test_data <- read.csv("data/data-parte-b/test-data-FE.csv")

# balanceo de clases ---------------------------------------------------------------------------------------------------
train_data <- ovun.sample(inclinacion_peligrosa ~ ., data = train_data, method = "under")$data  # default p = 0.5

# class_distribution <- table(train_data$inclinacion_peligrosa)
# class_probability <- class_distribution / sum(class_distribution)
# class_weights <- class_distribution[2] / class_distribution

# random forest --------------------------------------------------------------------------------------------------------

# pasar a factor para hacerlo de clasificación
# train_data$inclinacion_peligrosa <- factor(train_data$inclinacion_peligrosa)

formula <- inclinacion_peligrosa ~ circ_tronco_cm + lat + long + peligrosidad_especie + peligrosidad_diametro + peligrosidad_altura
rf_model <- randomForest(formula,
                         data = train_data,
                         do.trace = TRUE,
                         mtry = 3,  # Number of variables randomly sampled at each split. Default values: for classification sqrt(p) and regression p/3
                         # classwt = class_probability,
                         importance = TRUE,
                         proximity = TRUE,
                         ntree = 600
)

predictions <- predict(rf_model, test_data)
predictions_numeric <- as.numeric(as.character(predictions)) # predictions es un factor, hay que pasarlo a numeric

result_dataset <- data.frame(id = test_data$id, inclinacion_peligrosa = predictions_numeric)
write.csv(result_dataset, "data/submissions/submission_48.csv", row.names = FALSE)

# comparación con el mejor valor
# print("Comparación con el mejor valor")
# sub <- read.csv("data/submissions/submission_38.csv")
# percent <- sum(sub$inclinacion_peligrosa == 1) / nrow(sub) * 100
# print(percent)
#
# percent_prediction <- sum(predictions_numeric == 1) / length(predictions_numeric) * 100
# print(percent_prediction)
