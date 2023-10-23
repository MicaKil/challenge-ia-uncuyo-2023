**Estudiante:** Del Longo, Micaela (11653)

# Implementación de Cross Validation

Crear una función de nombre create_folds() que reciba como parámetro un dataframe y la cantidad de folds y devuelva
una lista de R con la siguiente estructura: `list(Fold1=c(...), Fold2=c(..),... Fold10=c())`. Donde Fold1 va a contender 
los índices del dataframe que fueron seleccionados para el primer fold, y así con los demás.

```R
create_folds <- function (data, num_folds) {
  num_rows <- nrow(data)

  # mezcla aleatoriamente los índices de las filas
  set.seed(123)  # para hacer la mezcla reproducible
  shuffled_indices <- sample(1:num_rows)

  # tamaño de cada fold
  fold_size <- floor(num_rows / num_folds)

  # lista para almacenar los índices de los folds
  folds_list <- list()

  # crea los folds
  for (i in 1:num_folds) {
    # calcula los índices del fold actual
    start_index <- (i - 1) * fold_size + 1
    end_index <- min(i * fold_size, num_rows)
    fold_indices <- shuffled_indices[start_index:end_index]

    # almacena los índices
    fold_name <- paste0("Fold", i)
    folds_list[[fold_name]] <- fold_indices
  }

  return(folds_list)
}
```

Crear una función de nombre cross_validation() que reciba como parámetro un data frame y un número de folds y entrene 
un modelo de árbol de decisión (utilizar paquete rpart) para cada uno de los posibles conjuntos de entrenamiento y 
calcule las métricas: _Accuracy, Precision, Sensitivity, Specificity_ para cada uno de los posibles conjuntos de tests. 
Devolver media y desviación estándar.

```R
cross_validation <- function(data, num_folds) {
    folds <- create_folds(data, num_folds)

    # almacenar las métricas
    accuracy_vector <- NULL
    precision_vector <- NULL
    sensitivity_vector <- NULL
    specificity_vector <- NULL

    for (i in 1:num_folds) {
        train_indices <- setdiff(seq_len(nrow(data)), folds[[i]])
        train_data <- data[train_indices, ]
        test_data <- data[folds[[i]], ]

        train_data$inclinacion_peligrosa <- factor(train_data$inclinacion_peligrosa)

        train_data$especie <- factor(train_data$especie, levels = levels(data$especie))
        test_data$especie <- factor(test_data$especie, levels = levels(data$especie))

        train_formula <- formula(inclinacion_peligrosa ~ altura + circ_tronco_cm + lat + long + seccion + especie)
        model <- rpart(train_formula, data = train_data)
        predictions <- predict(model, test_data, type = "class")
	  
        # cálculo de métricas
        confusion_matrix <- confusionMatrix(predictions, as.factor(test_data$inclinacion_peligrosa))
        accuracy_vector <- c(accuracy_vector, confusion_matrix$overall["Accuracy"])
        precision_vector <- c(precision_vector, confusion_matrix$byClass["Pos_Prediction"])
        sensitivity_vector <- c(sensitivity_vector, confusion_matrix$byClass["Sensitivity"])
        specificity_vector <- c(specificity_vector, confusion_matrix$byClass["Specificity"])
    }

    # media y desviación estándar
    metrics_mean <- c(
    Accuracy = mean(accuracy_vector),
    Precision = mean(precision_vector),
    Sensitivity = mean(sensitivity_vector),
    Specificity = mean(specificity_vector)
    )

    metrics_sd <- c(
        Accuracy = sd(accuracy_vector),
        Precision = sd(precision_vector),
        Sensitivity = sd(sensitivity_vector),
        Specificity = sd(specificity_vector)
    )

    return(list(Mean = metrics_mean, SD = metrics_sd))
}
```

# Resultados

Tras ejecutar el siguiente código:

```R
data_train <- read.csv("data/arbolado-mendoza-dataset-train.csv")
data_train$ultima_modificacion <- NULL
data_train$area_seccion <- NULL
metrics <- cross_validation(data_train, 10)
```

Obtuve los siguientes resultados:

## Media
| Accuracy  | Precision | Sensitivity | Specificity |
|-----------|-----------|-------------|-------------|
| 0.8870349 | NA        | 1.0000000   | 0.0000000   |

## Desviación Estándar

| Accuracy   | Precision | Sensitivity | Specificity |
|------------|-----------|-------------|-------------|
| 0.00503041 | NA        | 0.00000000  | 0.00000000  |

## Análisis

Como siempre como predicción obtuve '0', no peligroso, entonces obtuve los mismos resultados que los de el 'Clasificador 
por Clase Mayoritaria'. 
