**Estudiante:** Del Longo, Micaela (11653)

# Ejercicio 2
A partir del archivo arbolado-mendoza-dataset-train.csv responder las siguientes preguntas:

## Ejercicio 2.1
¿Cuál es la distribución de la clase inclinacion_peligrosa?

La distribución de la clase inclinacion_peligrosa es la siguiente:

<div align="center">
    <img src="pics/2_1_distribucion_inclinacion_peligrosa.png"/>
</div>

## Ejercicio 2.2
¿Se puede considerar alguna sección más peligrosa que otra?

<div align="center">
    <img src="pics/2_2_peligrosidad_secciones.png"/>
</div>

Dónde:
- Sección 1: Parque Central
- Sección 2: Barrio Cívico
- Sección 3: Parque O'Higgins
- Sección 4: 
  - Cuarta Oeste
  - Cuarta Este - Área Fundacional
- Sección 5: Residencial Sur
- Sección 6: Residencial Norte
- Sección 7: Residencial Parque
- Sección 8: Aeroparque
- Sección 11: San Agustín

Considerando el gráfico anterior, las secciones más peligrosas son 3 y 2 en ese orden.

### Separación de sección 4

<div align="center">
    <img src="pics/2_2_peligrosidad_nombre_secciones.png"/>
</div>

Considerando el gráfico anterior, las secciones más peligrosas son "Parque O'Higgins" y "Barrio Cívico" en ese orden.

## Ejercicio 2.3
¿Se puede considerar alguna especie más peligrosa que otra?

<div align="center">
    <img src="pics/2_3_peligrosidad_especies.png"/>
</div>

Considerando el gráfico anterior, las especies más peligrosas son "Algarrobo", "Morera" y "Acacia SP" en ese orden.

# Ejercicio 3

A partir del archivo arbolado-mendoza-dataset-train.csv:

## Ejercicio 3.1
Generar un histograma de frecuencia para la variable circ_tronco_cm. Probar con diferentes números de bins.

<div align="center">
    <img src="pics/3_1_histograma_circ_tronco_bins_10.png"/>
</div>

<div align="center">
    <img src="pics/3_1_histograma_circ_tronco_bins_20.png"/>
</div>

<div align="center">
    <img src="pics/3_1_histograma_circ_tronco_bins_30.png"/>
</div>

<div align="center">
    <img src="pics/3_1_histograma_circ_tronco_bins_40.png"/>
</div>

<div align="center">
    <img src="pics/3_1_histograma_circ_tronco_bins_50.png"/>
</div>

## Ejercicio 3.2
Repetir el punto 1) pero separando por la clase de la variable inclinación_peligrosa.

<div align="center">
    <img src="pics/3_2_histograma_circ_tronco_separado_por_inclinacion_bins_10.png"/>
</div>

<div align="center">
    <img src="pics/3_2_histograma_circ_tronco_separado_por_inclinacion_bins_20.png"/>
</div>

<div align="center">
    <img src="pics/3_2_histograma_circ_tronco_separado_por_inclinacion_bins_30.png"/>
</div>

<div align="center">
    <img src="pics/3_2_histograma_circ_tronco_separado_por_inclinacion_bins_40.png"/>
</div>

<div align="center">
    <img src="pics/3_2_histograma_circ_tronco_separado_por_inclinacion_bins_50.png"/>
</div>

## Ejercicio 3.3
Crear una nueva variable categórica de nombre circ_tronco_cm_cat a partir circ_tronco_cm, en donde puedan asignarse solo 4 posibles valores \[muy alto, alto, medio, bajo]. Utilizar la información del punto b para seleccionar los puntos de corte para cada categoría. 

Como criterio de corte se utilizó como referencia a los cuartiles de la variable circ_tronco_cm.

## Ejercicio 3.4
Guardar el nuevo dataframe bajo el nombre de arbolado-mendoza-dataset-circ_tronco_cm-train.csv

El nuevo dataframe se guardó en el archivo [arbolado-mendoza-dataset-circ_tronco_cm-train.csv](data/data-parte-a/arbolado-mendoza-dataset-circ_tronco_cm-train.csv)