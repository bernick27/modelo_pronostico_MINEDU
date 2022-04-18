import pandas as pd
import numpy as np
import pyodbc
import warnings
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split

from sklearn.metrics import accuracy_score
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
from sklearn.metrics import f1_score
from sklearn.metrics import confusion_matrix

from sklearn.neural_network import MLPClassifier

warnings.filterwarnings('ignore')

conn = pyodbc.connect(DRIVER='{ODBC Driver 17 for SQL Server}', SERVER='MED000008696', DATABASE='Difods_Work', Trusted_Connection='yes')
cursor = conn.cursor()

conn2 = pyodbc.connect(DRIVER='{ODBC Driver 17 for SQL Server}', SERVER='MED000008696', DATABASE='Difods_GOld', Trusted_Connection='yes')
cursor2 = conn2.cursor()

datos_estructurados_exitoso = pd.read_sql_query("SELECT TOP(25000) * FROM [Difods_Work].mooc.DATA_TRAIN_RNA_4 WHERE RENDIMIENTO='EXITOSO'", conn)
datos_estructurados_no_exitoso = pd.read_sql_query("SELECT TOP(25000) * FROM [Difods_Work].mooc.DATA_TRAIN_RNA_4 WHERE RENDIMIENTO='NO EXITOSO'", conn)

'''
datos_estructurados_exitoso = pd.read_sql_query("SELECT * FROM [Difods_Work].mooc.DATA_TRAIN_RNA_4 WHERE RENDIMIENTO='EXITOSO'", conn)
datos_estructurados_no_exitoso = pd.read_sql_query("SELECT * FROM [Difods_Work].mooc.DATA_TRAIN_RNA_4 WHERE RENDIMIENTO='NO EXITOSO'", conn)
'''
datos_estructurados_total = datos_estructurados_exitoso.append(datos_estructurados_no_exitoso, ignore_index=True)

print(datos_estructurados_total)

print(datos_estructurados_total.info())

le_rendimiento = LabelEncoder()
datos_estructurados_total['RENDIMIENTO'] = le_rendimiento.fit_transform(datos_estructurados_total['RENDIMIENTO'])

le_cargo = LabelEncoder()
datos_estructurados_total['Descripcion_Cargo'] = le_cargo.fit_transform(datos_estructurados_total['Descripcion_Cargo'])

le_subtipo_trabajador = LabelEncoder()
datos_estructurados_total['Descripcion_Subtipo_trabajador'] = le_subtipo_trabajador.fit_transform(datos_estructurados_total['Descripcion_Subtipo_trabajador'])

le_condicion_laboral = LabelEncoder()
datos_estructurados_total['condicion_laboral'] = le_condicion_laboral.fit_transform(datos_estructurados_total['condicion_laboral'])

le_dniv = LabelEncoder()
datos_estructurados_total['D_NIV_MOD'] = le_dniv.fit_transform(datos_estructurados_total['D_NIV_MOD'])

le_dcodcar = LabelEncoder()
datos_estructurados_total['D_COD_CAR'] = le_dcodcar.fit_transform(datos_estructurados_total['D_COD_CAR'])

le_dareacenso = LabelEncoder()
datos_estructurados_total['DAREACENSO'] = le_dareacenso.fit_transform(datos_estructurados_total['DAREACENSO'])

le_region = LabelEncoder()
datos_estructurados_total['D_REGION'] = le_region.fit_transform(datos_estructurados_total['D_REGION'])

le_nivel = LabelEncoder()
datos_estructurados_total['nivel'] = le_nivel.fit_transform(datos_estructurados_total['nivel'])

le_atencion_EIB = LabelEncoder()
datos_estructurados_total['Forma de atención EIB'] = le_atencion_EIB.fit_transform(datos_estructurados_total['Forma de atención EIB'])

le_lengua = LabelEncoder()
datos_estructurados_total['Nombre de lengua originaria 1 - 2019'] = le_lengua.fit_transform(datos_estructurados_total['Nombre de lengua originaria 1 - 2019'])

le_lengua2 = LabelEncoder()
datos_estructurados_total['Lengua Originaria sin variante'] = le_lengua2.fit_transform(datos_estructurados_total['Lengua Originaria sin variante'])

le_situacion_laboral = LabelEncoder()
datos_estructurados_total['Situación_Laboral'] = le_situacion_laboral.fit_transform(datos_estructurados_total['Situación_Laboral'])

le_sexo = LabelEncoder()
datos_estructurados_total['sexo'] = le_sexo.fit_transform(datos_estructurados_total['sexo'])

le_plaza = LabelEncoder()
datos_estructurados_total['Estado_plaza'] = le_plaza.fit_transform(datos_estructurados_total['Estado_plaza'])

le_forma = LabelEncoder()
datos_estructurados_total['d_forma'] = le_forma.fit_transform(datos_estructurados_total['d_forma'])

le_gestion = LabelEncoder()
datos_estructurados_total['d_gestion'] = le_gestion.fit_transform(datos_estructurados_total['d_gestion'])

le_ges_dep = LabelEncoder()
datos_estructurados_total['d_ges_dep'] = le_ges_dep.fit_transform(datos_estructurados_total['d_ges_dep'])

le_ruralidad = LabelEncoder()
datos_estructurados_total['ruralidad_2021'] = le_ruralidad.fit_transform(datos_estructurados_total['ruralidad_2021'])

le_calidad_cobertura1 = LabelEncoder()
datos_estructurados_total['calidad_cobertura_2t2020'] = le_calidad_cobertura1.fit_transform(datos_estructurados_total['calidad_cobertura_2t2020'])

le_calidad_cobertura2 = LabelEncoder()
datos_estructurados_total['calidad_cobertura_internet_fijo'] = le_calidad_cobertura2.fit_transform(datos_estructurados_total['calidad_cobertura_internet_fijo'])


### Estandarización de datos
scaler_jl = MinMaxScaler()
datos_estructurados_total['Jornada_Laboral'] = scaler_jl.fit_transform(np.array(datos_estructurados_total['Jornada_Laboral']).reshape(-1, 1))

scaler_ndl = MinMaxScaler()
datos_estructurados_total['Numero de limitaciones'] = scaler_ndl.fit_transform(np.array(datos_estructurados_total['Numero de limitaciones']).reshape(-1, 1))

scaler_edad = MinMaxScaler()
datos_estructurados_total['edad'] = scaler_edad.fit_transform(np.array(datos_estructurados_total['edad']).reshape(-1, 1))

scaler1 = MinMaxScaler()
datos_estructurados_total['FEEDBACK'] = scaler1.fit_transform(np.array(datos_estructurados_total['FEEDBACK']).reshape(-1, 1))

scaler2 = MinMaxScaler()
datos_estructurados_total['FORUM'] = scaler2.fit_transform(np.array(datos_estructurados_total['FORUM']).reshape(-1, 1))

scaler3 = MinMaxScaler()
datos_estructurados_total['RESOURCE'] = scaler3.fit_transform(np.array(datos_estructurados_total['RESOURCE']).reshape(-1, 1))

scaler4 = MinMaxScaler()
datos_estructurados_total['LABEL'] = scaler4.fit_transform(np.array(datos_estructurados_total['LABEL']).reshape(-1, 1))

scaler5 = MinMaxScaler()
datos_estructurados_total['QUIZ'] = scaler5.fit_transform(np.array(datos_estructurados_total['QUIZ']).reshape(-1, 1))

scaler6 = MinMaxScaler()
datos_estructurados_total['CHOICE'] = scaler6.fit_transform(np.array(datos_estructurados_total['CHOICE']).reshape(-1, 1))

scaler7 = MinMaxScaler()
datos_estructurados_total['PAGE'] = scaler7.fit_transform(np.array(datos_estructurados_total['PAGE']).reshape(-1, 1))

scaler8 = MinMaxScaler()
datos_estructurados_total['ASSIGN'] = scaler8.fit_transform(np.array(datos_estructurados_total['ASSIGN']).reshape(-1, 1))

scaler9 = MinMaxScaler()
datos_estructurados_total['URL'] = scaler9.fit_transform(np.array(datos_estructurados_total['URL']).reshape(-1, 1))

print(datos_estructurados_total)

y = datos_estructurados_total['RENDIMIENTO']
X = datos_estructurados_total.drop(columns=['RENDIMIENTO'])

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=123, stratify=y)



### Implementación del modelo
modelo_rna1 = MLPClassifier((100, 100), random_state=1, max_iter=300).fit(X_train, y_train)

y_pred_train = modelo_rna1.predict(X_train)
y_pred_test = modelo_rna1.predict(X_test)

acc_train = accuracy_score(y_train, y_pred_train)
acc_test = accuracy_score(y_test, y_pred_test)

prec_train = precision_score(y_train, y_pred_train)
prec_test = precision_score(y_test, y_pred_test)

rec_train = recall_score(y_train, y_pred_train)
rec_test = recall_score(y_test, y_pred_test)

f1_train = f1_score(y_train, y_pred_train)
f1_test = f1_score(y_test, y_pred_test)

cm_train = confusion_matrix(y_train, y_pred_train)
cm_test = confusion_matrix(y_test, y_pred_test)

df_resultados = pd.DataFrame([[acc_train, acc_test], [prec_train, prec_test], [rec_train, rec_test], [f1_train, f1_test]], columns=['Entrenamiento','Prueba'], index=['Accuracy', 'Precision', 'Recall', 'F1-score'])

print('Matriz de confusión del dataset de entrenamiento:')
print(cm_train)
print('Matriz de confusión del dataset de prueba:')
print(cm_test)

print('Tabla de resultados:')
print(df_resultados)

