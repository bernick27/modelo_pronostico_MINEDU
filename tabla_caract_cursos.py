import pandas as pd
import pyodbc
import warnings
import numpy as np

warnings.filterwarnings('ignore')

#conn = pyodbc.connect(DRIVER='{ODBC Driver 17 for SQL Server}', SERVER='MED000008696', DATABASE='Difods_Work', Trusted_Connection='yes')
conn = pyodbc.connect(DRIVER='{ODBC Driver 17 for SQL Server}', SERVER='MED000008696', DATABASE='Difods_Analytics', Trusted_Connection='yes')
cursor = conn.cursor()

df_data_caract_cursos_mod = pd.DataFrame(columns=['NOMBRE_CURSO','FEEDBACK', 'FORUM', 'RESOURCE', 'LABEL', 'QUIZ', 'CHOICE', 'PAGE', 'ASSIGN', 'URL'])

list_cursos = pd.read_sql_query("SELECT DISTINCT CURSO FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS", conn)

for curso in list_cursos.CURSO:
    
    sql_query_feedback = str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND TIPO_ACTIVIDAD='feedback')")
    nro_feedback = pd.read_sql_query(sql_query_feedback, conn)
    
    sql_query_forum = str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND TIPO_ACTIVIDAD='forum')")
    nro_forum = pd.read_sql_query(sql_query_forum, conn)
    
    sql_query_resource = str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND TIPO_ACTIVIDAD='resource')")
    nro_resource = pd.read_sql_query(sql_query_resource, conn)
    
    sql_query_label = str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND TIPO_ACTIVIDAD='label')")
    nro_label = pd.read_sql_query(sql_query_label, conn)
    
    sql_query_quiz = str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND TIPO_ACTIVIDAD='quiz')")
    nro_quiz = pd.read_sql_query(sql_query_quiz, conn)
    
    sql_query_choice = str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND TIPO_ACTIVIDAD='choice')")
    nro_choice = pd.read_sql_query(sql_query_choice, conn)
    
    sql_query_page = str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND TIPO_ACTIVIDAD='page')")
    nro_page = pd.read_sql_query(sql_query_page, conn)
    
    sql_query_assign = str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND TIPO_ACTIVIDAD='assign')")
    nro_assign = pd.read_sql_query(sql_query_assign, conn)
    
    sql_query_url = str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND TIPO_ACTIVIDAD='url')")
    nro_url = pd.read_sql_query(sql_query_url, conn)
    
    sql_query_prueba_entrada = str("SELECT COUNT(*) AS PRUEBA_ENTRADA FROM [Difods_Analytics].dbo.DATA_CARACT_CURSOS WHERE (CURSO='"+curso+"' AND NOMBRE_ACTIVIDAD IN ('Cuestionario de entrada', 'Evaluación de Entrada', 'Cuestionario de entrada.', 'Cuestionario Entrada', 'Prueba de Entrada', 'Prueba de entrada'))")
    pe = pd.read_sql_query(sql_query_prueba_entrada, conn)
    
    new_row = {'NOMBRE_CURSO': curso,
    'FEEDBACK': np.array(nro_feedback.NRO_ACTIVIDADES)[0], 
    'FORUM': np.array(nro_forum.NRO_ACTIVIDADES)[0], 
    'RESOURCE': np.array(nro_resource.NRO_ACTIVIDADES)[0], 
    'LABEL': np.array(nro_label.NRO_ACTIVIDADES)[0], 
    'QUIZ': np.array(nro_quiz.NRO_ACTIVIDADES)[0], 
    'CHOICE': np.array(nro_choice.NRO_ACTIVIDADES)[0], 
    'PAGE': np.array(nro_page.NRO_ACTIVIDADES)[0], 
    'ASSIGN': np.array(nro_assign.NRO_ACTIVIDADES)[0], 
    'URL': np.array(nro_url.NRO_ACTIVIDADES)[0],
    'PRUEBA_ENTRADA': np.array(pe.PRUEBA_ENTRADA)[0]}
    
    df_data_caract_cursos_mod = df_data_caract_cursos_mod.append(new_row, ignore_index=True)

'''
curso0="CD-PCDG6"
sql_query=str("SELECT COUNT(*) AS NRO_ACTIVIDADES FROM [Difods_Work].mooc.DATA_CARACT_CURSOS WHERE (CURSO='"+curso0+"' AND TIPO_ACTIVIDAD='quiz')")
nro_actividades_curso = pd.read_sql_query(sql_query, conn)

print(np.array(nro_actividades_curso.NRO_ACTIVIDADES)[0])
'''

print(df_data_caract_cursos_mod)

sql_query_insert = "INSERT INTO [Difods_Analytics].dbo.DATA_CARACT_CURSOS_MOD (NOMBRE_CURSO,FEEDBACK,FORUM,RESOURCE,LABEL,QUIZ,CHOICE,PAGE,ASSIGN,URL,PRUEBA_ENTRADA) VALUES (?,?,?,?,?,?,?,?,?,?,?)"
val = df_data_caract_cursos_mod[['NOMBRE_CURSO','FEEDBACK', 'FORUM', 'RESOURCE', 'LABEL', 'QUIZ', 'CHOICE', 'PAGE', 'ASSIGN', 'URL', 'PRUEBA_ENTRADA']].values.tolist()

cursor.executemany(sql_query_insert, val)
conn.commit()