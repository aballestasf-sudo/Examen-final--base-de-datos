from sqlite3 import Cursor
import mysql.connector

conexion = mysql.connector.connect(user='root', password='',
                                   host='localhost', database='CEA_v2', 
                                   port='3306')
print(conexion)

# CREATE
def insertar_estudiante(nombre, correo, fecha_nacimiento):
    sql = "INSERT INTO Estudiantes (nombre, correo, fecha_nacimiento) VALUES (%s, %s, %s)"
    valores = (nombre, correo, fecha_nacimiento)
    Cursor.execute(sql, valores)
    conexion.commit()

# READ
def listar_estudiantes():
    Cursor.execute("SELECT * FROM Estudiantes")
    return Cursor.fetchall()

# UPDATE
def actualizar_correo_estudiante(id_estudiante, nuevo_correo):
    sql = "UPDATE Estudiantes SET correo = %s WHERE id_estudiante = %s"
    valores = (nuevo_correo, id_estudiante)
    Cursor.execute(sql, valores)
    conexion.commit()

# DELETE
def eliminar_estudiante(id_estudiante):
    sql = "DELETE FROM Estudiantes WHERE id_estudiante = %s"
    Cursor.execute(sql, (id_estudiante,))
    conexion.commit()

