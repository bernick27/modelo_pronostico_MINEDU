/*
DROP TABLE [Difods_Work].mooc.DATA_TRAIN_RNA;
DROP TABLE [Difods_Work].mooc.DATA_TRAIN_RNA_2;
DROP TABLE [Difods_Work].mooc.DATA_TRAIN_RNA_3;
DROP TABLE [Difods_Work].mooc.DATA_TRAIN_RNA_4;

DROP TABLE [Difods_Work].mooc.DATA_CARACT_CURSOS;
DROP TABLE [Difods_Work].mooc.DATA_CARACT_CURSOS_MOD;
*/

--Creaci�n de la primera parte de la tabla con datos del 2021
SELECT * INTO [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 FROM [Difods_Work].mooc.MOOC_DIFODS_USUARIOCOMPLETADOS2021_DATA_FINAL_CERRADOS;

ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 DROP COLUMN fullname;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 DROP COLUMN userid;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 DROP COLUMN FECHA_CULMINARON;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 DROP COLUMN USUARIODIAREPORTE;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 DROP COLUMN ponderado;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 DROP COLUMN nota_ponderado;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 DROP COLUMN USUARIO;

ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 ADD RENDIMIENTO VARCHAR(255);

UPDATE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 SET RENDIMIENTO='NO EXITOSO';
UPDATE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1 SET RENDIMIENTO='EXITOSO' WHERE (CUMPLIMIENTO='CULMINARON' AND CONDICION='APROBADO');


--Creaci�n de la primera parte de la tabla con datos del 2022
SELECT * INTO [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 FROM [Difods_Work].[acfm].[sistema.mooc_carga_cumplimiento]

ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN FULLNAME;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN USERID;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN FECHA_CULMINARON;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN USUARIODIAREPORTE;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN PONDERADO;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN NOTA_PONDERADO;

ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN ID;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN CANAL;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN GRUPONUM;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN STATUS;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN TIPO_DOCUMENTO;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN CARACTERIZADO;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN ID_OFERTA_FORMATIVA;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN ID_GRUPO;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN ID_CURSO;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN FECHA_CREACION;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN USUARIO_CREACION;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN IP_CREACION;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN FECHA_MODIFICACION;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN USUARIO_MODIFICACION;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 DROP COLUMN IP_MODIFICACION;

ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 ADD RENDIMIENTO VARCHAR(255);

UPDATE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 SET RENDIMIENTO='NO EXITOSO';
UPDATE [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 SET RENDIMIENTO='EXITOSO' WHERE (CUMPLIMIENTO='CULMINARON' AND CONDICION='APROBADO');


-- Creaci�n de la tabla completa
SELECT * INTO [Difods_Analytics].dbo.DATA_TRAIN_RNA FROM [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 UNION ALL SELECT * FROM [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1

-----------------------------------------------------------------
SELECT * FROM [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1
-- 1 607 454
SELECT * FROM [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2
-- 169 750
SELECT * FROM [Difods_Analytics].dbo.DATA_TRAIN_RNA_p2 UNION ALL SELECT * FROM [Difods_Analytics].dbo.DATA_TRAIN_RNA_p1
-- 1 777 204

-----------------------------------------------------------------

-- Creaci�n de tabla general con cruce de informaci�n del padr�n docente
SELECT * INTO [Difods_Analytics].dbo.DATA2_TRAIN_RNA FROM [Difods_Analytics].dbo.DATA_TRAIN_RNA INNER JOIN [Difods_Gold].padron.docente ON [Difods_Analytics].dbo.DATA_TRAIN_RNA.IDNUMBER = [Difods_Gold].padron.docente.DNI;

SELECT * FROM [Difods_Analytics].dbo.DATA2_TRAIN_RNA
-- 1 543 326

--Eliminaci�n de columnas
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN Apellido_Paterno;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN Apellido_Materno;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN Nombres;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN DNI;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN Descripci�n_Ley;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN rango_edad;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN Fecha;

--Columnas con todas las filas nulas
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN Tipo_AP;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN pid_2020;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN programa_tablet;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN programa_contratados;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN ap_2020;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN CdD;

--Columnas con poca informaci�n
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN tipodeservicio_semipresen;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN estado_semipresen;
ALTER TABLE [Difods_Analytics].dbo.DATA2_TRAIN_RNA DROP COLUMN anexo;

----------------------------------------------------------------------------------------

-- Creaci�n de la primera parte de la tabla caracterizaci�n de cursos (2021)
SELECT DISTINCT CAMPUS, curid, fullname, CURSO, SECCION, NOMBRE_ACTIVIDAD, TIPO_ACTIVIDAD INTO [Difods_Analytics].dbo.DATA_CARACT_CURSOS_p1 FROM [Difods_Work].mooc.MOOC_DIFODS_USUARIOACTIVIDAD2021_DATA_FINAL_CERRADOS

-- Creaci�n de la segunda parte de la tabla caracterizaci�n de cursos (2022)
SELECT DISTINCT CAMPUS, CURID, FULLNAME, CURSO, SECCION, NOMBRE_ACTIVIDAD, TIPO_ACTIVIDAD INTO [Difods_Analytics].dbo.DATA_CARACT_CURSOS_p2 FROM [Difods_Work].[acfm].[sistema.mooc_carga_actividad]

-- Creaci�n de la tabla completa
SELECT * INTO [Difods_Analytics].dbo.DATA_CARACT_CURSOS FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS_p2 UNION ALL SELECT * FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS_p1

CREATE TABLE [Difods_Analytics].dbo.DATA_CARACT_CURSOS_MOD (
    NOMBRE_CURSO nvarchar(254),
    FEEDBACK bigint,
	FORUM bigint,
	RESOURCE bigint,
	LABEL bigint,
	QUIZ bigint,
	CHOICE bigint,
	PAGE bigint,
	ASSIGN bigint,
	URL bigint,
	PRUEBA_ENTRADA int,
);

-------------------------------------------------------------------

-- Creaci�n de tabla general con cruce de informaci�n
SELECT * INTO [Difods_Analytics].dbo.DATA3_TRAIN_RNA FROM [Difods_Analytics].dbo.DATA2_TRAIN_RNA INNER JOIN [Difods_Analytics].dbo.DATA_CARACT_CURSOS_MOD ON [Difods_Analytics].dbo.DATA2_TRAIN_RNA.curso = [Difods_Analytics].dbo.DATA_CARACT_CURSOS_MOD.NOMBRE_CURSO;

SELECT * FROM [Difods_Analytics].dbo.DATA3_TRAIN_RNA
-- 1 543 326
-------------------------------------------------------------------

-- Creaci�n de una copia de la tabla general donde se eliminan nuevas variables
SELECT * INTO [Difods_Analytics].dbo.DATA4_TRAIN_RNA FROM [Difods_Analytics].dbo.DATA3_TRAIN_RNA

--Eliminaci�n de columnas
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN NOMBRE_CURSO;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN CUMPLIMIENTO;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN CONDICION;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN Modular_IE;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN Descripcion_Tipo_Trabajador;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN CODGEO;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN D_DPTO;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN D_PROV;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN D_DIST;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN CODOOII;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN D_DREUGEL;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN cen_edu;
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN [a�o entrante_CFI];
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN CANTIDAD;--�CANTIDAD?

ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN sector;--Solo Publico
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN doc_eb;--Solo 1

ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN [Nombre de lengua originaria 1 - 2019];
ALTER TABLE [Difods_Analytics].dbo.DATA4_TRAIN_RNA DROP COLUMN Estado_plaza;

--------------------------------------------------------------------

-- Inserci�n de nuevas variables como la nota de la prueba de entrada del curso
SELECT curid, CURSO, NOMBRE_ACTIVIDAD, TIPO_ACTIVIDAD, idnumber, finalgrade INTO [Difods_Analytics].dbo.DATA_PRUEBA_ENTRADA_p1 FROM [Difods_Work].mooc.MOOC_DIFODS_USUARIOACTIVIDAD2021_DATA_FINAL_CERRADOS WHERE TIPO_ACTIVIDAD='quiz'

SELECT CURID, CURSO, NOMBRE_ACTIVIDAD, TIPO_ACTIVIDAD, IDNUMBER, FINALGRADE INTO [Difods_Analytics].dbo.DATA_PRUEBA_ENTRADA_p2 FROM [Difods_Work].[acfm].[sistema.mooc_carga_actividad] WHERE TIPO_ACTIVIDAD='quiz'

SELECT CURID AS CURSO_ID, CURSO AS NOMBRE_CURSO, NOMBRE_ACTIVIDAD, TIPO_ACTIVIDAD, IDNUMBER AS ID_NUMBER, FINALGRADE INTO [Difods_Analytics].dbo.DATA_PRUEBA_ENTRADA FROM [Difods_Analytics].dbo.DATA_PRUEBA_ENTRADA_p2 UNION ALL SELECT * FROM [Difods_Analytics].dbo.DATA_PRUEBA_ENTRADA_p1

---------------------------------------------------------------------

SELECT * INTO [Difods_Analytics].dbo.DATA5_TRAIN_RNA FROM [Difods_Analytics].dbo.DATA4_TRAIN_RNA LEFT JOIN [Difods_Analytics].dbo.DATA_PRUEBA_ENTRADA ON ([Difods_Analytics].dbo.DATA4_TRAIN_RNA.CURSO=[Difods_Analytics].dbo.DATA_PRUEBA_ENTRADA.NOMBRE_CURSO AND [Difods_Analytics].dbo.DATA4_TRAIN_RNA.IDNUMBER=[Difods_Analytics].dbo.DATA_PRUEBA_ENTRADA.ID_NUMBER AND [Difods_Analytics].dbo.DATA4_TRAIN_RNA.RENDIMIENTO='EXITOSO' AND [Difods_Analytics].dbo.DATA_PRUEBA_ENTRADA.NOMBRE_ACTIVIDAD IN ('Cuestionario de entrada', 'Evaluaci�n de Entrada', 'Cuestionario de entrada.', 'Cuestionario Entrada', 'Prueba de Entrada', 'Prueba de entrada'));

SELECT * FROM [Difods_Analytics].dbo.DATA5_TRAIN_RNA
-- 1 543 326

-- Obs: solo 70 docentes al parecer llevaron este curso
--SELECT * FROM [Difods_Analytics].dbo.DATA5_TRAIN_RNA WHERE CURSO='PFM2021-2';

--Eliminaci�n de columnas
ALTER TABLE [Difods_Analytics].dbo.DATA5_TRAIN_RNA DROP COLUMN CURSO_ID;
ALTER TABLE [Difods_Analytics].dbo.DATA5_TRAIN_RNA DROP COLUMN NOMBRE_CURSO;
ALTER TABLE [Difods_Analytics].dbo.DATA5_TRAIN_RNA DROP COLUMN NOMBRE_ACTIVIDAD;
ALTER TABLE [Difods_Analytics].dbo.DATA5_TRAIN_RNA DROP COLUMN TIPO_ACTIVIDAD;
ALTER TABLE [Difods_Analytics].dbo.DATA5_TRAIN_RNA DROP COLUMN ID_NUMBER;

-----------------------------------------------------------------------

SELECT DNI, Puntaje AS PUNTAJE_PUN, condicion AS CONDICION_PUN INTO [Difods_Analytics].dbo.DATA_PUN FROM [Difods_Gold].[padron].[PUN] WHERE (TIPO='PUN' and a�o>= Convert(datetime,'2019-01-01'))

SELECT * FROM [Difods_Analytics].dbo.DATA_PUN
-- 212 506

------------------------------------------------------------------------

SELECT * INTO [Difods_Analytics].dbo.DATA6_TRAIN_RNA FROM [Difods_Analytics].dbo.DATA5_TRAIN_RNA LEFT JOIN [Difods_Analytics].dbo.DATA_PUN ON ([Difods_Analytics].dbo.DATA5_TRAIN_RNA.IDNUMBER=[Difods_Analytics].dbo.DATA_PUN.DNI)

SELECT * FROM [Difods_Analytics].dbo.DATA6_TRAIN_RNA
-- 1 543 326

--Eliminaci�n de columnas
ALTER TABLE [Difods_Analytics].dbo.DATA6_TRAIN_RNA DROP COLUMN DNI;

------------------------------------------------------------------------

-- Creaci�n de la tabla de existencia de foro de presentacion en los cursos
CREATE TABLE [Difods_Analytics].dbo.DATA_CURSO_FORO_PRESENTACION (
    NOMBRE_CURSO nvarchar(254),
	FORO_PRESENTACION int,
);

SELECT * INTO [Difods_Analytics].dbo.DATA7_TRAIN_RNA FROM [Difods_Analytics].dbo.DATA6_TRAIN_RNA INNER JOIN [Difods_Analytics].dbo.DATA_CURSO_FORO_PRESENTACION ON [Difods_Analytics].dbo.DATA6_TRAIN_RNA.CURSO = [Difods_Analytics].dbo.DATA_CURSO_FORO_PRESENTACION.NOMBRE_CURSO;

SELECT * FROM [Difods_Analytics].dbo.DATA7_TRAIN_RNA
-- 1 543 326

--Eliminaci�n de columnas
ALTER TABLE [Difods_Analytics].dbo.DATA7_TRAIN_RNA DROP COLUMN NOMBRE_CURSO;

------------------------------------------------------------------------

-- Creaci�n de la tabla de resultados del modelo de percepci�n de comentarios de foros
CREATE TABLE [Difods_Analytics].dbo.DATA_PUNTUACION_MODELO_PERCEPCION (
    campus_mp int,
	curid_mp int,
    idnumber_mp nvarchar(254),
	PUNTUACION_FORO float,
);

SELECT * INTO [Difods_Analytics].dbo.DATA8_TRAIN_RNA FROM [Difods_Analytics].dbo.DATA7_TRAIN_RNA LEFT JOIN [Difods_Analytics].dbo.DATA_PUNTUACION_MODELO_PERCEPCION ON ([Difods_Analytics].dbo.DATA7_TRAIN_RNA.CAMPUS=[Difods_Analytics].dbo.DATA_PUNTUACION_MODELO_PERCEPCION.campus_mp AND [Difods_Analytics].dbo.DATA7_TRAIN_RNA.CURID=[Difods_Analytics].dbo.DATA_PUNTUACION_MODELO_PERCEPCION.curid_mp AND [Difods_Analytics].dbo.DATA7_TRAIN_RNA.IDNUMBER=[Difods_Analytics].dbo.DATA_PUNTUACION_MODELO_PERCEPCION.idnumber_mp AND [Difods_Analytics].dbo.DATA7_TRAIN_RNA.FORO_PRESENTACION=1);

--Eliminaci�n de columnas
ALTER TABLE [Difods_Analytics].dbo.DATA8_TRAIN_RNA DROP COLUMN campus_mp;
ALTER TABLE [Difods_Analytics].dbo.DATA8_TRAIN_RNA DROP COLUMN curid_mp;
ALTER TABLE [Difods_Analytics].dbo.DATA8_TRAIN_RNA DROP COLUMN idnumber_mp;

SELECT * FROM [Difods_Analytics].dbo.DATA8_TRAIN_RNA
-- 1 569 534

------------------------------------------------------------------------

-- Imputaci�n de datos
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET escala=0 WHERE escala IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET Jornada_Laboral=40 WHERE Jornada_Laboral IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET JEC=0 WHERE JEC IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET EIB=0 WHERE EIB IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET [Forma de atenci�n EIB]='No aplica' WHERE [Forma de atenci�n EIB] IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET Discapacidad=0 WHERE Discapacidad IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET [Numero de limitaciones]=0 WHERE [Numero de limitaciones] IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET registro_bilingue_2019=0 WHERE registro_bilingue_2019 IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET [Lengua Originaria sin variante]='NO DISPONIBLE' WHERE [Lengua Originaria sin variante] IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET cfi=0 WHERE cfi IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET Conectividad=0 WHERE Conectividad IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET ruralidad_2021='Otro' WHERE ruralidad_2021 IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET calidad_cobertura_2t2020='SIN INFORMACION' WHERE calidad_cobertura_2t2020 IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET calidad_cobertura_internet_fijo='SIN INFORMACION' WHERE calidad_cobertura_internet_fijo IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET iieesemipresencialidad2106=0 WHERE iieesemipresencialidad2106 IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET asignacion_tableta270721=0 WHERE asignacion_tableta270721 IS NULL;

UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET FINALGRADE=0 WHERE FINALGRADE IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET PUNTAJE_PUN=0 WHERE PUNTAJE_PUN IS NULL;
UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET CONDICION_PUN='Otro' WHERE CONDICION_PUN IS NULL;

UPDATE [Difods_Analytics].dbo.DATA8_TRAIN_RNA SET PUNTUACION_FORO=0 WHERE PUNTUACION_FORO IS NULL;


SELECT distinct PUNTUACION_FORO FROM [Difods_Analytics].dbo.DATA8_TRAIN_RNA

------------------------------------------------------------------------

SELECT * INTO [Difods_Analytics].dbo.DATA_TRAIN_RNA_FINAL FROM [Difods_Analytics].dbo.DATA8_TRAIN_RNA

ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_FINAL  DROP COLUMN CAMPUS;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_FINAL  DROP COLUMN CURID;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_FINAL  DROP COLUMN CURSO;
ALTER TABLE [Difods_Analytics].dbo.DATA_TRAIN_RNA_FINAL  DROP COLUMN IDNUMBER;

------------------------------------------------------------------------

-- Creaci�n de la tabla de resultados
CREATE TABLE [Difods_Analytics].dbo.DATA_RESULTADOS_PREDICCION (
    CURSO nvarchar(254),
    IDNUMBER nvarchar(254),
	RENDIMIENTO nvarchar(254),
	PROBA_REND_PRED float,
	RENDIMIENTO_PRED nvarchar(254),
);

-- Creaci�n de nueva tabla de resultados
CREATE TABLE [Difods_Analytics].dbo.DATA2_RESULTADOS_PREDICCION (
    CURSO nvarchar(254),
    IDNUMBER nvarchar(254),
	RENDIMIENTO nvarchar(254),
	PROBA_REND_PRED float,
	RENDIMIENTO_PRED nvarchar(254),
);
