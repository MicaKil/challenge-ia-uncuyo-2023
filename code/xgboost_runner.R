library(xgboost)
library(dplyr)
library(h2o)

h2o.init(nthreads = -1, enable_assertions = FALSE) # -1 use all available cores

# Load and preprocess the data
data <- h2o.importFile("data/data-parte-b/train_data_fe.csv")
test_data <- h2o.importFile("data/data-parte-b/test_data_fe.csv")

predictors <- c("circ_tronco_cm", "lat", "long", "peligrosidad_especie", "peligrosidad_diametro", "peligrosidad_altura", "peligrosidad_seccion")
response <- "inclinacion_peligrosa"

# Split the dataset into a training and validation set (modify ratios and seed as needed)
splits <- h2o.splitFrame(data = data, ratios = 0.8, seed = 1234)
train_data <- h2o.assign(splits[[1]], "train_data")
valid_data <- h2o.assign(splits[[2]], "valid_data")

# Build and train the XGBoost model (modify parameters as needed)
xgb_model <- h2o.xgboost(
  backend = "gpu",
  x = predictors,
  y = response,
  training_frame = train_data,
  validation_frame = valid_data,
  booster = "gbtree",
  colsample_bynode = 0.8, # Adjust parameters as needed
  eval_metric = "logloss", # Specify the evaluation metric
  nthread = -1, # Use all available threads
  seed = 1234
)

# Evaluate model performance
xgb_perf <- h2o.performance(xgb_model, newdata = valid_data)

# Extract feature interactions
feature_interactions <- h2o.feature_interaction(xgb_model)

h2o.shutdown()

