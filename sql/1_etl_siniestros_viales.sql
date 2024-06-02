/*
 * Autor : Jesus Parra
 * Academia : Henry
 * Proyecto de Data Analityc
 * Contacto : parra.jesus@gmail.com
 */

-- DROP TABLE homicidios_hechos

/*
 * Se crea una tabla la cual se utilizara para cargar la data tratada en el ETL con Python
 */

CREATE TABLE siniestros (
	codigo_siniestro  varchar,
	cantidad_victimas integer, 
	fecha date,
	hora varchar,
	lugar_hecho varchar,
	tipo_calle varchar,
	direccion_siniestro varchar,
	comuna integer,
	longitud varchar,
	latitud varchar,
	tipo_participantes varchar,
	tipo_victima varchar,
	tipo_acusado varchar
)

-- Importar registros a la tabla siniestros
COPY siniestros FROM '/tmp/homicidios_hechos.csv' DELIMITER ';' CSV HEADER;

-- DROP TABLE homicidios_victimas

/*
 * Se crea una tabla la cual se utilizara para cargar la data tratada en el ETL con Python
 */

CREATE TABLE victimas (
	codigo_siniestro varchar,
	fecha date,
	rol varchar,
	sexo_victima varchar,
	edad_victima varchar,
	fecha_fallecimiento varchar
)

-- Importar registros a la tabla victimas
COPY homicidios_victimas FROM '/tmp/homicidios_victimas.csv' DELIMITER ';' CSV HEADER;

-- Agregar un indentificador primario de registro a siniestros
ALTER TABLE siniestros ADD COLUMN id_siniestro serial PRIMARY KEY;

-- Segmentacion de de la columna tipo_calle
CREATE TABLE tipo_calle AS SELECT DISTINCT (tipo_calle) FROM siniestros

-- Se agrega un identificador primario a la nueva tabla
ALTER TABLE tipo_calle ADD COLUMN id_tipocalle serial PRIMARY KEY;

-- Se agrega un identificador foraneo
ALTER TABLE siniestros ADD COLUMN id_tipocalle INTEGER DEFAULT 0;

-- Actualizacion de la columna id_tipocalle a partir de la tabla tipo_calle
UPDATE siniestros h
SET id_tipocalle = t.id_tipocalle
FROM  tipo_calle t
WHERE h.tipo_calle = t.tipo_calle

-- Se crea una restriccion en la tabla siniestro
ALTER  TABLE  siniestros
    ADD CONSTRAINT fk_siniestro_tipocalle FOREIGN KEY (id_tipocalle) REFERENCES tipo_calle(id_tipocalle);

-- Segmentacion de de la columna tipo_participante
CREATE TABLE tipo_participante AS
	SELECT DISTINCT tipo_participantes FROM homicidios_hechos hh 

-- Agregar un indentificador primario de registro a tipo_participante	
ALTER TABLE tipo_participante ADD COLUMN id_tipoparticipante serial PRIMARY KEY;

-- Se agrega un identificador foraneo
ALTER TABLE siniestros ADD COLUMN id_tipoparticipante INTEGER DEFAULT 0;

-- Actualizacion de la columna id_tipoparticipante
UPDATE siniestros h
SET id_tipoparticipante = t.id_tipoparticipante
FROM  tipo_participante t
WHERE h.tipo_participantes = t.tipo_participantes

-- Se crea una restriccion en la tabla siniestro
ALTER  TABLE  siniestros
    ADD CONSTRAINT fk_siniestro_tipo_participante FOREIGN KEY (id_tipoparticipante) REFERENCES tipo_participante(id_tipoparticipante);

-- Segmentacion de la columna tipo_victima
CREATE TABLE tipo_victima AS
	SELECT DISTINCT tipo_victima FROM siniestros hh 

-- Se crea una restriccion en la tabla tipo_victima	
ALTER TABLE tipo_victima ADD COLUMN id_tipovictima serial PRIMARY KEY;

-- Se agrega un identificador foraneo
ALTER TABLE siniestros ADD COLUMN id_tipovictima INTEGER DEFAULT 0;

-- Actualizacion de la columna id_tipovictima
UPDATE siniestros h
SET id_tipovictima = t.id_tipovictima
FROM  tipo_victima t
WHERE h.tipo_victima = t.tipo_victima

-- Se crea una restriccion en la tabla siniestro
ALTER  TABLE  siniestros
    ADD CONSTRAINT fk_siniestro_tipo_victima FOREIGN KEY (id_tipovictima) REFERENCES tipo_victima(id_tipovictima);

-- Segmentacion de la columna tipo_acusado
CREATE TABLE tipo_acusado AS
	SELECT DISTINCT tipo_acusado FROM siniestros hh 

-- Se crea una restriccion en la tabla tipo_acusado
ALTER TABLE tipo_acusado ADD COLUMN id_tipoacusado serial PRIMARY KEY;

-- Se agrega un identificador foraneo
ALTER TABLE siniestros ADD COLUMN id_tipoacusado INTEGER DEFAULT 0;

-- Actualizacion de la columna id_tipoacusado
UPDATE siniestros h
SET id_tipoacusado = t.id_tipoacusado
FROM  tipo_acusado t
WHERE h.tipo_acusado = t.tipo_acusado

-- Se crea una restriccion en la tabla siniestro
ALTER  TABLE  siniestros
    ADD CONSTRAINT fk_siniestro_tipo_acusado FOREIGN KEY (id_tipoacusado) REFERENCES tipo_acusado(id_tipoacusado);

-- Luego de segmentar y actualizar las tablas se eliminan los atributos
ALTER TABLE siniestros DROP COLUMN tipo_calle;
ALTER TABLE siniestros DROP COLUMN tipo_participantes;
ALTER TABLE siniestros DROP COLUMN tipo_victima;
ALTER TABLE siniestros DROP COLUMN tipo_acusado;


-- Agregar un indicador primario 
ALTER TABLE victimas  ADD COLUMN id_victima serial PRIMARY KEY;

-- Segmentacion de la columna tipo_acusado
CREATE TABLE tipo_rol AS  
    SELECT DISTINCT (rol) FROM victimas hv 

-- Agregar un indicador primario 
ALTER TABLE tipo_rol ADD COLUMN id_tiporol serial PRIMARY KEY;

-- Se agrega un identificador foraneo
ALTER TABLE victimas ADD COLUMN id_tiporol INTEGER DEFAULT 0;

-- Actualizacion de la columna id_tiporol
UPDATE homicidios_victimas h
SET id_tiporol = t.id_tiporol
FROM  tipo_rol t
WHERE h.rol = t.rol

-- Se crea una restriccion en la tabla victimas
ALTER  TABLE  victimas
    ADD CONSTRAINT fk_victimas_tipo_rol FOREIGN KEY (id_tiporol) REFERENCES tipo_rol(id_tiporol);

-- Luego de segmentar y actualziar se elimina el atributo
ALTER TABLE victimas DROP COLUMN rol;


-- Se agrega un identificador foraneo
ALTER TABLE siniestros ADD COLUMN id_victima INTEGER DEFAULT 0;

-- Actualizacion de la columna id_victima
UPDATE siniestros h
SET id_victima = t.id_victima
FROM  victimas  t
WHERE h.codigo_siniestro  = t.codigo_siniestro

-- Se crea una restriccion en la tabla siniestro
ALTER  TABLE  siniestros
    ADD CONSTRAINT fk_siniestros_victimas FOREIGN KEY (id_victima) REFERENCES victimas(id_victima);

-- Luego de segmentar y actualziar se elimina el atributo   
ALTER TABLE siniestros  DROP COLUMN codigo_siniestro;

-- Se agrega un atributo para el rango etario de edad
ALTER TABLE siniestros  ADD COLUMN edad_etario varchar DEFAULT '-';

-- Se actualzia segun la condcion 
-- 1_Menor a 18 años
UPDATE siniestros h SET edad_etaria = '1_Menor a 18 años'
FROM  victimas  t
WHERE h.id_victima = t.id_victima  AND t.edad_victima < '18'

-- 2_De 18 a 25 años
UPDATE siniestros h SET edad_etaria = '2_De 18 a 25 años'
FROM  victimas  t
WHERE h.id_victima = t.id_victima  AND (t.edad_victima >= '18' AND t.edad_victima <= '25')

-- 3_De 26 a 40 años
UPDATE siniestros h SET edad_etaria = '3_De 26 a 40 años'
FROM  victimas  t
WHERE h.id_victima = t.id_victima  AND (t.edad_victima >= '26' AND t.edad_victima <= '40')

-- 4_De 41 a 60 años
UPDATE siniestros h SET edad_etaria = '4_De 41 a 60 años'
FROM  victimas  t
WHERE h.id_victima = t.id_victima  AND (t.edad_victima >= '41' AND t.edad_victima <= '60')

-- 5_De 61 a 99 años
UPDATE siniestros h SET edad_etaria = '5_De 61 a 99 años'
FROM  victimas  t
WHERE h.id_victima = t.id_victima  AND (t.edad_victima >= '61' AND t.edad_victima <= '99')

/*
 * Imputaciones  a valores nulos
 */

-- sexo_victima
SELECT * FROM victimas v 
WHERE fecha_fallecimiento  = 'SD'; 

-- Imputacion, se asigna la misma fecha del siniestro
UPDATE victimas 
SET fecha_fallecimiento = fecha 
WHERE fecha_fallecimiento = 'SD';

SELECT * FROM victimas v
WHERE edad_victima = 'SD'

-- Se calcula la media para imputar donde no tenemos valores, luego la media es 42 años 
SELECT ROUND(AVG(cast(edad_victima  AS integer)),0) FROM victimas v
WHERE edad_victima != 'SD' AND cast(edad_victima  AS integer) < 100

-- El 42 viene de calcular la media 
UPDATE victimas
SET edad_victima = '42'
WHERE edad_victima = 'SD'

-- Se elimina la fecha en 3 registros
SELECT * FROM siniestros s
WHERE id_siniestro IN (423,481,425)

-- 6 registros imputados (3 MASCULINO o 3 FEMENINO)
SELECT * FROM victimas v 
WHERE sexo_victima = 'SD'; -- 6 registros imputados (3 MASCULINO o 3 FEMENINO)

-- Consultar la tabla de hechos con sus dimensiones
SELECT s.cantidad_victimas, s.fecha, s.hora, s.lugar_hecho, s.direccion_siniestro, s.comuna, s.longitud, s.latitud, s.edad_etaria, ta.tipo_acusado, tc.tipo_calle , tp.tipo_participantes  FROM siniestros s 
INNER JOIN tipo_acusado ta ON s.id_tipoacusado = ta.id_tipoacusado 
INNER JOIN tipo_calle tc ON s.id_tipocalle = tc.id_tipocalle  
INNER JOIN tipo_participante tp ON s.id_tipoparticipante = tp.id_tipoparticipante 
INNER JOIN victimas v ON s.id_victima = v.id_victima  

-- Exporta la tabla siniestros
COPY (
	SELECT s.cantidad_victimas, s.fecha, s.hora, s.lugar_hecho, s.direccion_siniestro, s.comuna, s.longitud, s.latitud, s.edad_etaria, ta.tipo_acusado, tc.tipo_calle , tp.tipo_participantes  FROM siniestros s 
	INNER JOIN tipo_acusado ta ON s.id_tipoacusado = ta.id_tipoacusado 
	INNER JOIN tipo_calle tc ON s.id_tipocalle = tc.id_tipocalle  
	INNER JOIN tipo_participante tp ON s.id_tipoparticipante = tp.id_tipoparticipante 
	INNER JOIN victimas v ON s.id_victima = v.id_victima) TO '/tmp/siniestros.csv' DELIMITER ';' CSV HEADER;

-- Consultar la tabla siniesrro
SELECT v.codigo_siniestro, v.fecha, v.sexo_victima, v.edad_victima, v.fecha_fallecimiento FROM victimas v 
INNER JOIN tipo_rol tr ON v.id_tiporol = tr.id_tiporol 

-- Exporta la tabla siniestros
COPY (SELECT v.codigo_siniestro, v.fecha, v.sexo_victima, v.edad_victima, v.fecha_fallecimiento FROM victimas v 
      INNER JOIN tipo_rol tr ON v.id_tiporol = tr.id_tiporol ) TO '/tmp/victimas.csv' DELIMITER ';' CSV HEADER;

-- DROP TABLE comuna      
     
-- Creacion de una tabla comuna para almacenar datos de comunas
CREATE TABLE comuna (
	id_comuna serial PRIMARY KEY,
	objeto varchar,
	comuna integer,
	barrios varchar,
	perimetro numeric(16,7),
	area numeric(16,7)
);

-- Importamos dats en la tabla comuna
COPY comuna FROM '/tmp/comunas.csv' DELIMITER ';' CSV HEADER;

-- Se crea una restriccion en la tabla siniestro
ALTER  TABLE  siniestros
    ADD CONSTRAINT fk_siniestros_comuna FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna);


-- select * from siniestros where comuna = 0
SELECT s.comuna, count(*) 
FROM siniestros s 
INNER JOIN victimas v ON s.id_victima = v.id_victima 
GROUP BY 1
ORDER BY 2 DESC 



     
     
/*
 * Consultas
 */

   
-- Victimas Por año
SELECT id_siniestro, v.id_victima, EXTRACT(YEAR FROM s.fecha), count(*) FROM siniestros s
RIGHT JOIN victimas v ON s.id_victima = v.id_victima
GROUP BY 1,2, EXTRACT(YEAR FROM s.fecha)
ORDER BY 1


-- Victimas por rango de edades por año
SELECT EXTRACT(YEAR FROM s.fecha), s.edad_etaria AS rango_edades, count(*) FROM siniestros s
INNER JOIN victimas v ON s.id_victima = v.id_victima
GROUP BY EXTRACT(YEAR FROM s.fecha), rango_edades

SELECT c.barrios, EXTRACT(MONTH  FROM s.fecha), count(v.id_victima) AS cantidad FROM siniestros s 
INNER JOIN victimas v ON s.id_victima = v.id_victima
INNER JOIN comuna c ON s.id_comuna = c.id_comuna
GROUP BY 1,2
ORDER BY 2,3 DESC 

SELECT lugar_hecho, sum(v.id_victima) FROM siniestros s
INNER JOIN victimas v ON s.id_victima = v.id_victima 
GROUP BY 1
HAVING count(*) > 5

-- Victimas por rol
SELECT tr.rol, count(*) FROM siniestros s 
INNER JOIN	victimas v ON s.id_victima = v.id_victima 
INNER JOIN tipo_rol tr ON v.id_tiporol = tr.id_tiporol 
GROUP BY  1

-- Por tipo de calle
SELECT tc.tipo_calle, count(*) FROM siniestros s 
INNER JOIN victimas v ON s.id_victima = v.id_victima 
INNER JOIN tipo_calle tc ON s.id_tipocalle = tc.id_tipocalle 
GROUP BY 1

/*
 * Este script se utilizo para crear un dataset y ser utilizado en el EDA, con el propósito de facilitar la creación de la gráfica
 */
SELECT EXTRACT(YEAR FROM s.fecha) AS anio, EXTRACT(MONTH FROM s.fecha) AS mes , EXTRACT(DAY FROM s.fecha) AS dia, count(*) FROM siniestros s
INNER JOIN victimas v ON s.id_victima = v.id_victima
GROUP BY 1,2,3
ORDER BY 1 ASC 

-- Respalda la información generada en el script anterior en un archivo csv
COPY (
SELECT EXTRACT(YEAR FROM s.fecha) AS anio, EXTRACT(MONTH FROM s.fecha) AS mes , EXTRACT(DAY FROM s.fecha) AS dia, count(*) FROM siniestros s
INNER JOIN victimas v ON s.id_victima = v.id_victima
GROUP BY 1,2,3
ORDER BY 1 ASC 
) TO  '/tmp/victimas_fecha.csv' DELIMITER ';' CSV HEADER;

-- Medida
SELECT tr.rol, count(*)  FROM victimas v
INNER JOIN tipo_rol tr ON v.id_tiporol = tr.id_tiporol 
GROUP BY 1
     
/*
 * Herramientas
 */

-- El siguiente script se puede utilizar para crear un diccionario de datos
   
SELECT 
table_name,
column_name
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE table_name IN ('hechos_lesiones','victimas_pp','hechos_homicidios','victimas_homicidios') 
ORDER BY table_name
