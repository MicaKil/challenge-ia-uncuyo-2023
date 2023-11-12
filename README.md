# Desafío IA I 2023

**Estudiante:** Del Longo, Micaela
**Legajo:** 11653

- Link TP: https://docs.google.com/document/d/1BpjICpzWI0zChph9r5vi9_ldnphmD3h2uB4qLGwc0O4/edit#heading=h.5k87ni494szy
- Link Kaggle: https://www.kaggle.com/competitions/arbolado-publico-mendoza-2023

## PARTE A
Antes de realizar un primer envío se deben realizar las siguientes actividades:

### Ejercicio 1

1. Bajar el archivo arbolado-mendoza-dataset.csv, el mismo se encuentra en formato CSV (comma separated values).

2. Seleccionar de manera uniformemente aleatoria el 20% del conjunto de datos y crear un nuevo archivo con el nombre de 
  arbolado-mendoza-dataset-validation.csv y el 80% restante con el nombre de arbolado-mendoza-dataset-train.csv

### Ejercicio 2
A partir del archivo arbolado-mendoza-dataset-train.csv responder las siguientes preguntas:

1. ¿Cuál es la distribución de la clase inclinacion_peligrosa?

2. ¿Se puede considerar alguna sección más peligrosa que otra?

3. ¿Se puede considerar alguna especie más peligrosa que otra?

**IMPORTANTE:** para responder cada una de estas preguntas se deberá generar una visualización/gráfico que justifique la 
respuesta.

### Ejercicio 3

A partir del archivo arbolado-mendoza-dataset-train.csv:

1. Generar un histograma de frecuencia para la variable circ_tronco_cm. Probar con diferentes números de bins.

2. Repetir el punto 1) pero separando por la clase de la variable inclinación_peligrosa.

3. Crear una nueva variable categórica de nombre circ_tronco_cm_cat a partir circ_tronco_cm, en donde puedan asignarse
solo 4 posibles valores \[muy alto, alto, medio, bajo]. Utilizar la información del punto b para seleccionar los puntos de 
corte para cada categoría. 

4. Guardar el nuevo dataframe bajo el nombre de arbolado-mendoza-dataset-circ_tronco_cm-train.csv

### Ejercicio 4: Clasificador Aleatório

1. Implementar una función que dado un conjunto de observaciones (data.frame) genere una nueva columna de nombre 
prediction_prob con un valor aleatorio entre 0 y 1. 

2. Implementar una función de nombre random_classifier, que reciba como parámetro el dataframe generado con anterioridad 
y a partir de la columna predictions_prob genere una nueva columna prediction_class bajo el siguiente criterio: `If 
predictions_prob > 0.5 then prediction_class=1 else prediction_class=0`

   La función deberá devolver el dataframe original junto a la nueva columna generada.

3. Cargar el archivo arbolado-mendoza-dataset-validation.csv como un data.frame y aplicarle la función random_classifier.

4. A partir de la columna recientemente generada y la columna con la clase (inclinación peligrosa) calcular utilizando 
lenguaje R (dplyr) el número de:

   1. Número de árboles CON inclinación peligrosa que fueron correctamente predichos como peligrosos por el
     modelo/algoritmo. (True Positive)

   2. Número de árboles SIN inclinación peligrosa que fueron correctamente predichos como no peligrosos por el
  modelo. (True Negative)

   3. Número de árboles SIN inclinación peligrosa que fueron incorrectamente predichos como peligrosos según el 
  modelo. (False Positives)

   4. Número de árboles CON inclinación peligrosa que fueron incorrectamente predichos como no peligrosos según el
  modelo. (False Negatives)
  
    El resultado es una tabla que se conoce como matriz de confusión. 


### Ejercicio 5: Clasificador por clase Mayoritaria

1. Implementar una función de nombre biggerclass_classifier, que reciba como parámetro el dataframe generado con 
anterioridad y genere una nueva columna de nombre prediction_class en donde se asigne siempre de la clase mayoritaria 

    La función deberá devolver el dataframe original junto a la nueva columna generada.

2. Repetir los puntos 4.c y 4.d pero aplicando la nueva función biggerclass_classifier

### Ejercicio 6

A partir de una matriz de confusión es posible calcular distintas métricas que nos permiten determinar la calidad del 
modelo de clasificación. 

Utilizar la siguiente imagen como guía crear funciones para calcular: _Accuracy, Precision, Sensitivity, Specificity_ y 
calcularlas para las matrices de confusión generadas en los puntos 4 y 5.

<div align="center">
    <img src="pics/confusionMatrixUpdated.jpg"/>
</div>

### Ejercicio 7: Validación Cruzada (Cross Validation) (k-folds)

La validación cruzada es una técnica para estimar el error de generalización de un algoritmo/modelo de machine learning.
La técnica consiste en (previo realizar una mezcla aleatoria) separar el conjunto de datos en k partes (normalmente 
denominadas folds). Luego en la primera iteración se utilizan k-1 partes para entrenar E1 y se utiliza la restante 
para test. El proceso se repite por k iteraciones utilizando en cada una diferentes conjuntos de entrenamiento y test. 

<div align="center">
    <img src="pics/Diagram-of-k-fold-cross-validation-with-k-10-Image-from-Karl-Rosaen-Log.ppm"/>
</div>

1. Crear una función de nombre create_folds() que reciba como parámetro un dataframe y la cantidad de folds y devuelva 
una lista de R con la siguiente estructura: `list(Fold1=c(...), Fold2=c(..),... Fold10=c())`. Donde Fold1 va a contender 
los índices del dataframe que fueron seleccionados para el primer fold, y así con los demás.

2. Crear una función de nombre cross_validation() que reciba como parámetro un data frame y un número de folds y entrene 
un modelo de árbol de decisión (utilizar paquete rpart) para cada uno de los posibles conjuntos de entrenamiento y 
calcule las métricas: _Accuracy, Precision, Sensitivity, Specificity_ para cada uno de los posibles conjuntos de tests. 
Devolver media y desviación estándar.

Ejemplo de uso de rpart:

```R
# seleccionamos la clase y las variables que nos interesan
library(rpart)
train_formula<-formula(inclinacion_peligrosa~altura+
    Circ_tronco_cm+
    Lat+long+
    Seccion+
    especie)
# generamos el modelo 
tree_model<-rpart(train_formula,data=data_train)
# obtenemos la predicción
p<-predict(tree_model,data_val,type='class')
```

#### Forma de entrega:

1. Dentro del repositorio en github con el nombre de ia-uncuyo-2023 crear una carpeta con el nombre tp7-ml.
2. Colocar dentro de una carpeta data/ los archivos:
   1. arbolado-mendoza-dataset-train.csv
   2. arbolado-mendoza-dataset-validation.csv
   3. arbolado-publico-mendoza-2021-circ_tronco_cm-train.csv
3. Colocar un archivo con el nombre tp7-eda.md que contenga:
   1. Las respuestas a las preguntas del punto 2 junto a sus correspondientes visualizaciones. 
   2. Las visualizaciones(histogramas) generadas en el punto 3  
   3. Los criterios de corte seleccionados en el punto 3.
4. Colocar un archivo con el nombre tp7-classificadores.md que contenga:
   1. La matriz de confusión para el clasificador aleatorio y las métricas correspondientes. (tabla)
   2. La matriz de confusión para el clasificador por clase mayoritaria y las métricas correspondientes. (tabla)
5. Colocar en un archivo con el nombre tp7-cv.md:
   1. El código (en un bloque de código) de las funciones create_folds() y cross_validation()
   2. Una tabla con los resultados (media y desviación estándar de las métricas seleccionadas) de aplicar el 
   clasificador un árbol de decisión en los distintos conjuntos.

## PARTE B

Proponer una estrategia para predecir la peligrosidad del arbolado público de Mendoza con un resultado superior al 0.69 
en la métrica AUC en kaggle.

#### Forma de entrega:

1. Colocar un archivo con el nombre tp7-reporte-arbolado.md que contenga:
   1. Descripción del proceso de preprocesamiento (si es que lo hubiera). Como por ejemplo:
      1. ¿Se eliminaron variables? 
      2. ¿Se crearon nuevas? 
      3. Se normalizaron valores (0,1)
      4. otras...
   2. Resultados obtenidos sobre el conjunto de validación 
   3. Resultados obtenidos en Kaggle 
   4. Descripción detallada del algoritmo propuesto
2. Dentro de dicha carpeta (tp7-ml/) crear una nueva carpeta code/ donde se va a incluir TODO el código utilizado para el 
envío.

## PARTE C

1. Implementar un algoritmo para construir un árbol de decisión de acuerdo al pseudocódigo provisto en AIMA (Se puede 
implementar en Python).
   1. El algoritmo solo deberá considerar variables discretas. 
   2. Se deberá comprobar su correcto funcionamiento de manera empírica sobre el dataset tennis.csv 
2. Investigar sobre las estrategias de los árboles de decisión para datos de tipo real y elaborar un breve resumen.

#### Forma de entrega:

1. Colocar un archivo con el nombre tp7-reporte-id3.md que contenga:
   1. Resultados sobre la evaluación sobre tennis.csv 
   2. Información sobre las estrategias para datos de tipo real
2. Dentro de la carpeta (tp7-ml/code) crear una nueva carpeta id3/ donde se va a incluir el código utilizado para la 
implementación del árbol de decisión.
