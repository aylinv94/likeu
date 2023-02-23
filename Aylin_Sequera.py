# Importar libreria
import pymysql
import pandas as pd
import warnings

warnings.simplefilter(action='ignore', category=FutureWarning)

def ETL():

  def extraer_data(archivo):
      return pd.read_json(archivo,encoding='utf-8', orient= 'record')

  clientes = extraer_data('Clientes.json')
  gestiones = extraer_data('Gestiones.json')
  ventas = extraer_data('Ventas.json')

  #Funciones
  def validate(df, column_name):
      '''Funcion para validar que el campo es obligatorio y unico'''
      if  not df[column_name].all():
          raise ValueError("El campo '{}' es obligatorio".format(column_name))
      if df[column_name].duplicated().any():
          raise ValueError("El campo '{}' tiene valores duplicados".format(column_name))

  def validate_telefono(df):
      # Crear un nuevo dataframe para almacenar las filas inválidas
      invalid_rows = pd.DataFrame(columns=df.columns)
      
      # Recorrer cada fila del dataframe
      for index, row in df.iterrows():
          telefono = str(row['Telefono'])
          
          # Validar la longitud del número de teléfono
          if len(telefono) not in [10,7]:
              # Agregar la fila a la lista de filas inválidas
              invalid_rows = pd.concat([invalid_rows, row.to_frame().T], ignore_index=False)
              # Reemplazar el número de teléfono inválido con una cadena vacía
              df.at[index, 'Telefono'] = ''
      return df, invalid_rows


  #Clientes.json
  #Normalizacion de 'Nombre'
  clientes['Nombre']= clientes['Nombre'].str.title()

  #Normalizacion de 'Direccion'
  clientes['Direccion'] = clientes['Direccion'].apply(lambda x: x.lower() if type(x) == str else x)

  #Normalizacion de la columna 'Tipo de documento' a los tipos permitidos
  clientes = clientes.replace({'Tipo de documento':{
                          'c.e':'Cedula De Extranjeria',
                          'ce':'Cedula De Extranjeria',
                          'c:e':'Cedula De Extranjeria',
                          'c.c':'Cedula De Ciudadania',
                          'CC':'Cedula De Ciudadania',
                          'Cedula':'Cedula De Ciudadania',
                          'Ced�la':'Cedula De Ciudadania',
                          'TI': 'Tarjeta De Identidad',
                          'Tarjeta': 'Tarjeta De Identidad',
                          'Passporte': 'Pasaporte',
                          'Pass': 'Pasaporte'}})

  #Normalizacion de 'Documento'
  '''Debido a valores repetidos en 'Documento', se creo una clave subrogada 'id_Cliente'
  tomando las inicales del 'tipo de documento', y como continuan habiando
  duplicados se elimino el ultimo registro,ademas se creo la tabla
  'duplicados' con dichos valores para su consideracion.'''
  clientes['TD'] = clientes['Tipo de documento'].apply(lambda x: "".join([palabra[0] for palabra in x.split()]).replace('D',''))
  clientes.insert(0, 'id_Cliente', clientes['TD'].apply(str) + clientes['Documento'].apply(str))

  duplicados = clientes[clientes.duplicated(['Documento'], keep=False)].sort_values(by='Documento')
  clientes = clientes.drop_duplicates(clientes.columns[clientes.columns.isin(['Documento'])],keep='first')

  validate(clientes,'id_Cliente')



  #Normalizacion de 'Telefono'
  '''Se crea un nueva tabla "phone_invalid" para guardar los registros de
  los telefonos invalidos para su consideracion'''
  clientes['Telefono'] = clientes['Telefono'].apply(lambda x: x.replace(" ", "") if type(x) == str else x)
  clientes,phone_invalid = validate_telefono(clientes)



  #Ventas.json
  #Validacion de 'No de Venta'
  validate(ventas,'No de venta')

  #Normalizacion de 'Fecha' formato YYYY-MM-DD
  ventas['Fecha'] =pd.to_datetime(ventas['Fecha']).dt.strftime('%Y-%m-%d')

  #Nomalizacion de 'Valor'
  ventas['Valor'] = ventas['Valor'].apply(lambda x: x.replace('$','').replace('.','').replace(',','.') if type(x) == str else x).astype(float)

  #Clave Subrogada Clientes
  cliente = clientes[['Documento','TD']]
  ventas = pd.merge(left=ventas,right=cliente, how='left',left_on='Cliente', right_on='Documento', left_index=False, right_index=False)
  ventas['id_Cliente'] = ventas['TD'].apply(str) + ventas['Documento'].apply(str)
  ventas.drop(['Documento','TD'],axis=1, inplace=True)

  #Validacion y normalizacion de datos Gestiones.json
  #Validacion de 'Id'
  validate(gestiones,'Id')

  #Normalizacion de 'Fecha' formato YYYY-MM-DD y 'Hora' HH:MM:SS
  gestiones['Hora'] = pd.to_datetime(gestiones['Fecha']).dt.strftime('%H:%M:%S')
  gestiones['Fecha'] = pd.to_datetime(gestiones['Fecha']).dt.strftime('%Y-%m-%d')

  #Clave Subrogada Clientes
  gestiones = pd.merge(left=gestiones,right=cliente, how='left',left_on='Cliente', right_on='Documento', left_index=False, right_index=False)
  gestiones['id_Cliente'] = gestiones['TD'].apply(str) + gestiones['Documento'].apply(str)
  gestiones.drop(['Documento','TD'],axis=1, inplace=True)


  #BASE DE DATOS
  #conexion con el servidor
  conexion = pymysql.connect(
      host = "localhost",
      user = "root",
      password = "tupassword",
  )

  #creación del cursor
  cursor = conexion.cursor()

  #creación de nueva base de datos
  cursor.execute("CREATE DATABASE IF NOT EXISTS prueba_aS;")

  select_bd = "USE prueba_aS;"
  cursor.execute(select_bd)

  #Crear tablas
  table_create_cliente = '''CREATE TABLE IF NOT EXISTS cliente
  (id_cliente VARCHAR (32),
  documento BIGINT (32) NOT NULL,
  tipo_documento 		VARCHAR (40),
  nombre		 		VARCHAR (60),
  telefono			VARCHAR (15),
  direccion			VARCHAR (200),
  PRIMARY KEY (id_cliente)
  );'''

  table_create_venta = ''' CREATE TABLE IF NOT EXISTS `venta` (
    `id_venta`	INTEGER (32) NOT NULL,
    `cliente`		BIGINT (30),
    `fecha`		DATE,
    `valor`		DECIMAL (15,2),
    `id_cliente` VARCHAR (15),
    PRIMARY KEY (id_venta),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) 
    );'''

  table_create_gestion = '''CREATE TABLE IF NOT EXISTS `gestion` (
    `id_gestion`	VARCHAR (40) NOT NULL,
    `cliente`		BIGINT (32),
    `fecha`		DATE,
    `hora`		TIME,
    `id_cliente` VARCHAR (15),
    PRIMARY KEY (id_gestion),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
    );'''

  table_create_duplicado = '''  CREATE TABLE IF NOT EXISTS `duplicado` (
    `id_cliente` VARCHAR (15),
    `documento` 	BIGINT (32) NOT NULL,
    `tipo_documento` 		VARCHAR (40),
    `nombre`		 		VARCHAR (60),
    `telefono`			VARCHAR (15),
    `direccion`			VARCHAR (100)
    );'''

  table_create_telefono_invalido = ''' CREATE TABLE IF NOT EXISTS `telefono_invalido` (
    `documento` 	BIGINT (32) NOT NULL,
    `tipo_documento` 		VARCHAR (40),
    `nombre`		 		VARCHAR (60),
    `telefono`			VARCHAR (15),
    `direccion`			VARCHAR (200),
    `id_cliente` VARCHAR (15),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
    );'''

  cursor.execute(table_create_cliente)
  cursor.execute(table_create_venta)
  cursor.execute(table_create_gestion)
  cursor.execute(table_create_duplicado)
  cursor.execute(table_create_telefono_invalido)

  #Insertar valores CLIENTE
  query_cliente = '''INSERT INTO cliente(id_cliente, documento, tipo_documento, nombre, telefono, direccion) 
  VALUES (%s,%s,%s,%s,%s,%s)'''
  values_cliente = [tuple(x)for x in clientes[["id_Cliente","Documento","Tipo de documento","Nombre","Telefono","Direccion"]].values]
  cursor.executemany(query_cliente, values_cliente)
  conexion.commit()

  #Insertar valores VENTA
  query = '''INSERT INTO venta(id_venta, cliente, fecha, valor, id_cliente) 
  VALUES (%s,%s,%s,%s,%s)'''
  values = [(row['No de venta'], row['Cliente'], row['Fecha'], row['Valor'], row['id_Cliente']) for i, row in ventas.iterrows()]
  cursor.executemany(query, values)
  conexion.commit()

  #Insertar valores GESTION
  query_gestion = '''INSERT INTO gestion(id_gestion, cliente, fecha, hora, id_cliente) 
  VALUES (%s,%s,%s,%s,%s)'''
  values_gestion = [tuple(x)for x in gestiones[["Id","Cliente","Fecha","Hora", "id_Cliente"]].values]
  cursor.executemany(query_gestion, values_gestion)
  conexion.commit()

  #Insertar valores DUPLICADO
  query_duplicado = '''INSERT INTO duplicado(id_cliente, documento, tipo_documento, nombre, telefono, direccion) 
  VALUES (%s,%s,%s,%s,%s,%s)'''
  values_duplicado = [tuple(x)for x in duplicados[["id_Cliente","Documento","Tipo de documento","Nombre","Telefono","Direccion"]].values]
  cursor.executemany(query_duplicado, values_duplicado)
  conexion.commit()

  #Insertar valores TELEFONO_INVALIDO
  query_telefono = '''INSERT INTO telefono_invalido(id_cliente, documento, tipo_documento, nombre, telefono, direccion) 
  VALUES (%s,%s,%s,%s,%s,%s)'''
  values_telefono = [tuple(x)for x in phone_invalid[["id_Cliente","Documento","Tipo de documento","Nombre","Telefono","Direccion"]].values]
  cursor.executemany(query_telefono, values_telefono)
  conexion.commit()

  # Crear VISTA
  create_view_DESC = '''CREATE VIEW vista_totales_desc AS
  SELECT v.id_cliente, COUNT(v.id_venta) AS cantidad_ventas, SUM(v.valor) AS valor_total, COUNT(g.id_gestion) AS cantidad_gestiones
  FROM venta v
  JOIN gestion g ON (v.id_cliente = g.id_cliente)
  GROUP BY id_cliente
  ORDER BY 3 DESC;'''
  cursor.execute(create_view_DESC)

  create_view = '''CREATE VIEW vista_totales AS
  SELECT v.id_cliente, COUNT(v.id_venta) AS cantidad_ventas, SUM(v.valor) AS valor_total, COUNT(g.id_gestion) AS cantidad_gestiones
  FROM venta v
  JOIN gestion g ON (v.id_cliente = g.id_cliente)
  GROUP BY id_cliente;'''
  cursor.execute(create_view)

  # Verificar que la vista se haya creado correctamente
  check_view_DESC = '''SHOW CREATE VIEW vista_totales_desc'''
  check_view = '''SHOW CREATE VIEW vista_totales'''
  cursor.execute(check_view)
  print(cursor.fetchall())

  cursor.close()
  conexion.close()

if __name__ == '__main__':
  ETL()
