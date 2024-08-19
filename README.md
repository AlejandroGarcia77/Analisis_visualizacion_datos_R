# Proyecto: Análisis y Visualización de Datos con R

Este proyecto demuestra el uso de R para realizar análisis de datos y crear visualizaciones informativas centradas en indicadores socioeconómicos y criminales en España. El análisis incluye el uso de bibliotecas especializadas para manipular datos, generar gráficos y realizar comparaciones a nivel de comunidades autónomas y países de la Unión Europea.

## Contenido del Proyecto

### 1. **Configuración Inicial**
   - **Carga de Librerías**: Se configuran las bibliotecas `tidyverse`, `mapSpain` y `eurostat`, necesarias para el análisis y la visualización de datos geoespaciales y socioeconómicos.
   - **Funciones de Temas Personalizados**: Se definen tres temas personalizados (`tema_1`, `tema_2`, `tema_3`) para unificar el estilo gráfico en las visualizaciones.

### 2. **Análisis de la Tasa de Empleo por Comunidad Autónoma**
   - **Carga y Preparación de Datos**: Se importan y limpian los datos de la tasa de empleo para las comunidades autónomas y la Unión Europea para el año 2019.
   - **Visualización**: Se crea un gráfico de barras que ordena las comunidades autónomas por su tasa de empleo, con un diseño personalizado utilizando `ggplot2`.

### 3. **Análisis de la Tasa de Criminalidad por Comunidad Autónoma**
   - **Carga y Preparación de Datos**: Se importan los datos de la tasa de criminalidad por comunidad autónoma para el año 2019.
   - **Visualización Geoespacial**: Se genera un mapa de España que muestra la tasa de criminalidad por comunidad autónoma, utilizando la biblioteca `mapSpain` para obtener la geometría de las regiones.

### 4. **Comparación de la Renta Mediana entre Comunidades Autónomas y Países de la UE**
   - **Carga de Datos**: Se obtienen datos de la renta mediana de Eurostat para los países de la UE y de fuentes nacionales para las comunidades autónomas de España.
   - **Visualización Comparativa**: Se crea un gráfico de barras que compara la renta mediana entre comunidades autónomas y países de la UE para el año 2019.

## Herramientas y Lenguajes de Programación Utilizados

- **R**: Lenguaje principal utilizado para el análisis y la visualización de datos.
- **Tidyverse**: Conjunto de paquetes para la manipulación y visualización de datos.
- **MapSpain**: Biblioteca para trabajar con datos geoespaciales de España.
- **Eurostat**: Paquete para acceder a datos estadísticos de Eurostat.
- **ggplot2**: Utilizado para crear gráficos y personalizar visualizaciones.

## Propósito del Proyecto

Este proyecto tiene como objetivo demostrar habilidades en el análisis de datos socioeconómicos y la creación de visualizaciones avanzadas en R. Es una muestra de cómo manejar datos complejos y presentarlos de manera clara y efectiva para la toma de decisiones y el análisis comparativo.

---