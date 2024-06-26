<div align="center">
  <h1 align="center">
    Análisis de datos sobre los Siniestros Viales
      <br />
      <img src="./img/siniestro_vial.jpg" alt="Siniestros Viales">
      <br />
  </h1>
</div>

# Contenido

* [Introducción](#Introducción)

* [Propuesta](#Propuesta)

* [Los Datos](#Los-Datos)

* [Tecnologías utilizados](#Tecnologías-utilizados)

* [Análisis Exploratorio de Datos](#Análisis-Exploratorio-de-Datos)

* [El Modelo de Datos](#El-Modelo-de-Datos)

* [Indicador clave de rendimiento](#Indicador-clave-de-rendimiento)

* [Conclusiones](#Conclusiones)

* [Recomendaciones](#Recomendaciones)

* [Recursos](#Recursos)

* [Créditos](#Créditos)

# Introducción

Los siniestros viales, conocidos también como accidentes de tránsito, son un problema de salud pública que impacta de manera negativa a ciudades de todo el mundo, incluyendo Buenos Aires. Estos eventos, que involucran a vehículos en las vías públicas, pueden tener consecuencias que van desde daños materiales hasta lesiones graves o fatales para los involucrados.

En una ciudad densamente poblada y con un alto volumen de tráfico como Buenos Aires, los siniestros viales representan una preocupación importante. Estos hechos no solo afectan la seguridad de los residentes y visitantes, sino que también pueden tener un efecto significativo en la infraestructura vial, los servicios de emergencia y la calidad de vida en general.

# Propuesta

### Limpieza y preparación de datos:

* Se realizará una búsqueda exhaustiva de valores faltantes, outliers y registros duplicados. Se aplicarán las técnicas adecuadas para tratar estos casos, como la eliminación de registros incompletos o la imputación de valores faltantes.
* Se verificará la consistencia y validez de los datos, asegurando que los valores estén dentro de rangos razonables y que no existan incoherencias.

### Análisis descriptivo:

- Se utilizarán medidas de resumen como la **media**, **mediana**, **moda**, **desviación estándar**, **rango** y **cuartiles** para describir las variables numéricas.
- Para las variables categóricas, se calcularán frecuencias y porcentajes, además de medidas de asociación como el chi-cuadrado o el índice de correlación de Cramer.
- Se elaborarán gráficos y tablas adecuados para visualizar la distribución de las variables y las relaciones entre ellas. Se utilizarán histogramas, diagramas de cajas, gráficos de barras y dispersión, entre otros.

### Conclusiones y recomendaciones:

- Se sintetizarán los hallazgos más importantes del EDA, destacando las características principales del conjunto de datos, los patrones identificados y las posibles anomalías.

- Se formularán recomendaciones para el tratamiento posterior de los datos, en función de los resultados obtenidos. Esto puede incluir la transformación de variables, la selección de subconjuntos de datos o la aplicación de técnicas de reducción de dimensionalidad.

# Los Datos

El conjunto de datos entregado para el estudio, consta de un archivo Excel que puede descargarlo [aquí](datasets/homicidios.xlsx), este se encuentra estructurado en cuatro hojas, dos de las las cuales vienen organizados en columnas y las otras dos es información que describen los mismos. La primera hoja llamada **HECHOS**, contiene 20 columnas de datos representados entre datos cualitativos (nominales y categoricos) y numericos, este conjunto suman **696 registros**, luego la hoja siguiente **DICCIONARIO_HECHOS**, como fue mencionado es informativa, describe las 20 variables de la hoja de **HECHOS**. Y tenemos la hoja de **VICTIMAS** que contiene 10 columnas y **717 registros**, de manera similar tiene asociado una hoja de **DICCIONARIO_VICTIMAS** que describe sus campos

En relación al tipo de datos se pueden observar las siguientes imágenes

de HECHOS 

![Tipo de datos de HECHOS](img/tipo_datos_hechos.png)

y de VICTIMAS

![Tipo de datos de VICTIMAS](img/tipo_datos_victimas.png)


Finalmente los datos fueron entregado por nuestro cliente **Observatorio de Movilidad y Seguridad Vial (OMSV)**, centro de estudios que se encuentra bajo la órbita de la **Secretaría de Transporte del Gobierno de la Ciudad Autónoma de Buenos Aires**.



# Tecnologías utilizados

Ambiente de base de datos 

- Ambiente de base de Datos<br><center>
![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql)
</center>
<br>

- Ambiente de Desarrollo<br><center>
![Python](https://img.shields.io/badge/-Python-333333?style=flat&logo=python)
![Pandas](https://img.shields.io/badge/-Pandas-333333?style=flat&logo=pandas)
![Numpy](https://img.shields.io/badge/-Numpy-333333?style=flat&logo=numpy)
![Matplotlib](https://img.shields.io/badge/Matplotlib-333333?style=flat&logo=WordCloud)
![Seaborn](https://img.shields.io/badge/Seaborn-333333?style=flat&logo=Seaborn)
![Visual Studio Code](https://img.shields.io/badge/-Visual%20Studio%20Code-333333?style=flat&logo=visual-studio-code&logoColor=007ACC)
![Jupyter Notebooks](https://img.shields.io/badge/-Jupyter_Notebook-333333?style=flat&logo=jupyter)
</center>
<br>

- Desarrollo del Dashboard<br><center>
![Power BI](https://img.shields.io/badge/PowerBI-333333?style=flat&logo=powerbi)
![DAX](https://img.shields.io/badge/-DAX-333333?style=flat&logo=powerbi)
</center>


# Análisis Exploratorio de Datos

A través de este proceso que corresponde al EDA, obtendremos una visión general de la estructura de los datos, la calidad y las relaciones entre las variables. Este conocimiento fundamental será esencial para guiar nuestros pasos posteriores del análisis, que va desde la limpieza, la preparación o tratamiento, hasta la construcción de un modelo de datos y la toma de decisiones informadas.

Entonces a continuación mostraremos algunas características de los datos, patrones y tendencias, incluyendo anomalías.

**Tipos de datos**
 <br />
- Dataframe homicidios_hechos 
<br />

![Estructura de datos del dataframe homicidios_hechos](img/hechos_estructura.png) 

- Dataframe homicidios_victimas 
<br />

![Estructura de datos del dataframe homicidios_victimas](img/victimas_estructura.png) 

### Outliers
Busquemos valores atipicos en nuestros datos, utilizando el metodo **describe()**

```bash
# Buscando outliers en la variables cantidad_victimas
siniestros["cantidad_victimas"].describe()
```


![Valores atipicos en victimas](img/outliers_victimas.png) 

Estamos observando en estos datos que existen valores atipicos, pero existe una razón de valor y es que en la mayoria de los siniestros registrado, la cantidad de victimas fatales no pasan de uno o dos, y algunos casos se registran 3 victimas fatales, entonces considerar estos numeros aportan valor a nuestro estudio.

Con algo de codigo, detectemos outliers utilizando la regla de 3 desviaciones estándar

```bash
# Calcular media y la desviación estándar
media = victimas['edad_victima'].mean()
desviacion_estandar = victimas['edad_victima'].std()

# Definamos los límite para outliers (3σ)
limite_outlier = 3 * desviacion_estandar

# Detectemos los outliers aplicando la formula 
outliers = victimas[abs(victimas['edad_victima'] - media) > limite_outlier]

# Observemos los resultados 
print(f"Outliers detectados: {outliers}")
```

![Valores atipicos en victimas](img/outliers_victimas_2.png) 

Para el caso de la variable **edad_victima**, esta fue tratada de lado de PostgreSQL, se ejecuto la siguiente sentencia sql  para imputar todo valor SD

```bash
-- Se calcula la media para imputar donde no tenemos valores, luego la media es 42 años 
SELECT ROUND(AVG(cast(edad_victima  AS integer)),0) FROM victimas v
WHERE edad_victima != 'SD' AND cast(edad_victima  AS integer) < 100
```
Obtenida la media, se ejecuto la sentencia de actualización sobe los registros con valor **SD**

```bash
-- El 42 viene de calcular la media 
UPDATE victimas
SET edad_victima = '42'
WHERE edad_victima = 'SD'
```
Continuamos desde python el analisis para generar la siguiente gráfica buscando outliers

```bash
# Ajustar el tamaño de la figura
plt.figure(figsize=(6, 4))

# Crear subplots para los gráficos 
plt.subplot(1, 1, 1) 
sns.boxplot(data=victimas, y='edad_victima', color = "#FA8072")
plt.ylabel('Edad')
# Ajustar espaciado entre subplots
plt.tight_layout()

plt.show()
```

![Valores atipicos en victimas](img/outliers_siniestros_2.png) 

Y observamos que poedmeos llegar a la conclusión que para esta variable edad_victima se encuentra limpia y sin valores sucios.

### Gráficas de Variables Continua

Esta gráficas nos permite observar la distribución de los datos, puede evidenciarse que las victimas estaban cerca de los 40 años.

![Distribución de los datos](img/grafica_1.png)

Estamos observando un patrón en la que baja el numero de victimas despues del año 2018, esto pudiera deberse a la concientización de la ciudadania en relación a la prevención vial, otra razon del punto mas bajo para el año 2021 fue causado por la epidemia del **COVID19**  luego de esto los indices de siniestros viales van en aumento.

![Distribución de los datos](img/grafica_3.png)

### Gráficas de Variables Cualitativa

Encontramos que existe un porcentaje alto de victimas altos, en la que pudieramos indicar que por la naturaleza de tomar riesgos conductuales, biologia, entre otros aspecto

![Distribución de los datos](img/grafica_4.png)

Se creo una nueva variable edad_etaria para agrupar las edades y hemos encontrado que las victimas se encuentra en el rango de los 26 hasta 40 años

![Distribución de los datos](img/edad_rango.png)


Utilizando una gráfica de nube de palabras observamos con letras mas grandes el nombre de la calle que mas siniestros tiene.

![Distribución de los datos](img/nube_palabras.png)



# El Modelo de Datos

Para el desarrollo del modelo de datos se utilizó **PostgreSQL**, una base de datos relacional robusta y escalable. Se emplearon contenedores **Docker** sobre un sistema operativo linux, especificamente **Debian** para aislar el entorno de desarrollo y garantizar la reproducibilidad del modelo.

En una primera etapa, se analizaron archivos csv suministrados por el cliente, luego, a partir de ellos se crearon tablas de dimensión y de hechos, esta estructura de base de datos nos permitiría almacenar información relevante del tema en estudio. Posteriormente, se conectó el modelo de datos a la herramienta de **Power BI**, una herramienta de visualización de datos, para generar reportes interactivos y paneles de control.

Adicionalmente, se utilizó la base de datos para generar conjuntos de datos especificos en formato csv que luego se cargaron en Python, con el propósito de facilitar el analisis del tema en estudio, y generar graficas en el EDA.

Este enfoque basado en utilizar una base de datos PostgreSQL, Docker, permitió crear un modelo de datos robusto, flexible y escalable, que a su vez sirvió como base para la generación de reportes, y la obtención de insights valiosos para el negocio.

![Modelo de Datos](img/modelo_datos.png)

Un ejemplo de como se exporto a csv, informacion a partir de una consulta
 que luego sería utilizada en Python

```bash
-- Exporta la tabla siniestros
COPY (SELECT v.codigo_siniestro, v.fecha, v.sexo_victima, v.edad_victima, v.fecha_fallecimiento FROM victimas v 
      INNER JOIN tipo_rol tr ON v.id_tiporol = tr.id_tiporol ) TO '/tmp/victimas.csv' DELIMITER ';' CSV HEADER;

```
Aca la estructura sql de la [base de datos](sql/2_base_de_datos_siniestros_viales.sql) 

Y el [diccionario de datos](sql/diccionario_datos.csv) en formato csv

De igual modo junto un backup de la base de datos [base de datos](sql/siniestros_viales-202406021035.sql)

Ya el paso siguiente es conectar Power BI a la base de datos PostgreSQL, coloque en servidor la direccion IP y el puerto (Ejemplo **196.81.221.106:5433**), nombre de la base de datos (Ejemplo **siniestros_viales**) y haz clic al botón **Aceptar**

![Conexión de Power BI a la base de datos](img/conexion_postgres.png)

# Indicador clave de rendimiento

**KPI 1**
Reducir en un 10% la tasa de homicidios en siniestros viales de los últimos seis meses, en CABA, en comparación con la tasa de homicidios en siniestros viales del semestre anterior.

Se define la tasa de homicidios en siniestros viales como el número de víctimas fatales en accidentes de tránsito por cada 100,000 habitantes en un área geográfica durante un período de tiempo específico. Su fórmula es: (Número de homicidios en siniestros viales / Población total) * 100,000

- Formula 
**Tasa de homicidio en siniestros viales=(Numero de homicidio en siniestros viales/Poblacion total) * 100**

Para este indicador concluimos que fue exitosos el conseguir alcanzar la meta que es reducir la tasa de homicidios en siniestros en el ultimo semestre

**KPI 2**
Reducir en un 7% la cantidad de accidentes mortales de motociclistas en el último año, en CABA, respecto al año anterior.

Se define la cantidad de accidentes mortales de motociclistas en siniestros viales como el número absoluto de accidentes fatales en los que estuvieron involucradas víctimas que viajaban en moto en un determinado periodo temporal. Su fórmula para medir la evolución de los accidentes mortales con víctimas en moto es: (Número de accidentes mortales con víctimas en moto en el año anterior - Número de accidentes mortales con víctimas en moto en el año actual) / (Número de accidentes mortales con víctimas en moto en el año anterior) * 100

- Formula
**Cantidad de accidentes mortales de motociclista en siniestros viales = Valor Absoluto (Número de accidentes mortales en moto en el año anterior - Numero de accidentes mortales con victimas en moto en el año actual) / Numero de accidentes mortales con victimas en moto en el año anterior * 100**

![Conexión de Power BI a la base de datos](img/kpi.png)

# Conclusiones 

Sobre el análisis exploratorio realizado en datos historico que comprende los periodos 2016 hasta el 2021, registraron 696 siniestros, sumando un total de 717 victimas fatales, lo cual obtuvimos los siguientes hallazgo :

* La comuna número 1, que agrupa a Constitucion - Montserrat - Puerto Madero - Retiro - San Nicolas - San Telmo, es el área de mayor porcentaje de siniestros registrados con víctimas fatales.
* Las avenidas como principales vías de acceso concentran un mayor registro de siniestros viales en la que se puede incluso evidenciar un alto porcentaje de peatones y conductores que suman como víctimas fatales.
* Un porcentaje alto de las víctimas las representan el género masculino con edades comprendidas entre los 26 y 42 años.
* En cuanto a los tipos de usuario, se pudo observar que la mayor parte de siniestros fatales siguen siendo los motorizados.

# Recomendaciones

* Crear programas de educación a niños y jóvenes para la movilidad segura y su prevención.
* Preparar talleres de capacitación para ciudadanos con la importancia de reforzar la prevención y la seguridad vial.
* Instalar dispositivos de control y prevención en Avenidas con mayor incidencias de siniestros fatales.
* Concientizar a la población a través de medios televisivos y redes digitales lo importante del uso de cinturones de seguridad, sistemas de retención infantil, en el caso de motorizados utilización de cascos, chalecos reflectivos.
* Mantener los vehiculos al dia con sus chequeos, neumáticos, motor y demas componentes que lo requeira
* Verifica el estado de vias, avenidas y carreteras en cuanto a asfalto y señalización
* Evitar ingerir alcohol, tomar un adecuado descanso.


# Recursos

* [Campaña francesa de concienciación para peatones | Subtitulado español](https://www.youtube.com/watch?v=ufxg_FghFAc)

* [¿Cuáles son las principales causas de accidentes de tránsito?](https://satrack.com/ec/blog/cuales-son-las-principales-causas-de-accidentes-de-transito/)

* [11 medidas para la prevención de accidentes de tráfico](https://www.alimentatubienestar.es/prevencion-de-accidentes-de-trafico/)* [Análisis exploratorio de datos (EDA)](https://es.r4ds.hadley.nz/07-eda.html)

# Créditos
Copyright (c) 2024 [Ing. Jesús parra] parra.jesus@gmail.com