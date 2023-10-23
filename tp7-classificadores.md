Colocar un archivo con el nombre tp7-classificadores.md que contenga:
1. La matriz de confusión para el clasificador aleatorio y las métricas correspondientes. (tabla)
2. La matriz de confusión para el clasificador por clase mayoritaria y las métricas correspondientes. (tabla)

# Matriz de Confusión y Métricas
<div style="text-align:center">
    <img src="pics/confusionMatrixUpdated.jpg"/>
</div>

# Clasificador Aleatorio

|                     | Predictive Positive   | Predictive Negative          |                         |
|---------------------|-----------------------|------------------------------|-------------------------|
| **Actual Positive** | 342                   | 353                          | **Sensitivity** =  0.49 |
| **Actual Negative** | 2832                  | 2855                         | **Specificity** =  0.50 |
|                     | **Precision** =  0.11 | **Neg. Pred. Value** =  0.89 | **Accuracy** =  0.50    |

# Clasificador por Clase Mayoritaria

|                     | Predictive Positive | Predictive Negative          |                         |
|---------------------|---------------------|------------------------------|-------------------------|
| **Actual Positive** | 0                   | 695.0                        | **Sensitivity** =  0.00 |
| **Actual Negative** | 0                   | 5687                         | **Specificity** =  1.00 |
|                     | **Precision** =  NA | **Neg. Pred. Value** =  0.89 | **Accuracy** =  0.89    |

