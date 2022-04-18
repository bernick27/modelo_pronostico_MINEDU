import pandas as pd
import pyodbc
import warnings
import numpy as np

warnings.filterwarnings('ignore')

conn = pyodbc.connect(DRIVER='{ODBC Driver 17 for SQL Server}', SERVER='MED000008696', DATABASE='Difods_Analytics', Trusted_Connection='yes')
cursor = conn.cursor()

df_data_curso_foro_pres = pd.DataFrame(columns=['NOMBRE_CURSO','FORO_PRESENTACION'])

list_cursos = pd.read_sql_query("SELECT DISTINCT CURSO FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS", conn)

for curso in list_cursos.CURSO:
    
    sql_query_foro_presentacion = str("SELECT COUNT(*) AS FORO_PRESENTACION FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND NOMBRE_ACTIVIDAD='Foro de presentación')")
    foro = pd.read_sql_query(sql_query_foro_presentacion, conn)
    
    new_row = {'NOMBRE_CURSO': curso,
    'FORO_PRESENTACION': np.array(foro.FORO_PRESENTACION)[0]}
    
    df_data_curso_foro_pres = df_data_curso_foro_pres.append(new_row, ignore_index=True)

print(df_data_curso_foro_pres)

sql_query_insert = "INSERT INTO [Difods_Analytics].dbo.DATA_CURSO_FORO_PRESENTACION (NOMBRE_CURSO,FORO_PRESENTACION) VALUES (?,?)"
val = df_data_curso_foro_pres[['NOMBRE_CURSO','FORO_PRESENTACION']].values.tolist()

cursor.executemany(sql_query_insert, val)
conn.commit()