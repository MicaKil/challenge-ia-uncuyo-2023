Colocar un archivo con el nombre tp7-classificadores.md que contenga:
1. La matriz de confusión para el clasificador aleatorio y las métricas correspondientes. (tabla)
2. La matriz de confusión para el clasificador por clase mayoritaria y las métricas correspondientes. (tabla)

## Ejercicio 4.4
A partir de la columna recientemente generada y la columna con la clase (inclinación peligrosa) calcular utilizando
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

|                     | Predictive Positive | Predictive Negative |
|---------------------|---------------------|---------------------|
| **Actual Positive** | 342                 | 353                 |
| **Actual Negative** | 2832                | 2855                |

