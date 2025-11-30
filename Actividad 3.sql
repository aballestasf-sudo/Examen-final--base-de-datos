
CREATE DATABASE CEA_v2;
USE CEA_v2;


CREATE TABLE Estudiantes (
    id_estudiante INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    fecha_nacimiento DATE
);


CREATE TABLE Programa (
    id_programa INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    duracion INT CHECK (duracion > 0),
    facultad VARCHAR(100) NOT NULL
);


CREATE TABLE Docente (
    id_docente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    especialidad VARCHAR(100)
);


CREATE TABLE Matricula (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_estudiante INT NOT NULL,
    id_programa INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_programa) REFERENCES Programa(id_programa)
);


CREATE TABLE Evaluacion (
    id_evaluacion INT PRIMARY KEY AUTO_INCREMENT,
    id_matricula INT NOT NULL,
    id_docente INT NOT NULL,
    nota DECIMAL(4,2) CHECK (nota >= 0 AND nota <= 5),
    observaciones TEXT,
    FOREIGN KEY (id_matricula) REFERENCES Matricula(id_matricula),
    FOREIGN KEY (id_docente) REFERENCES Docente(id_docente)
);
INSERT INTO Estudiantes VALUES (NULL, 'Ana Torres', 'ana.torres@udec.edu.co', '2000-05-12');
INSERT INTO Estudiantes VALUES (NULL, 'Luis Gómez', 'luis.gomez@udec.edu.co', '1999-08-20');
INSERT INTO Estudiantes VALUES (NULL, 'Pedro Ruiz', 'pedro.ruiz@udec.edu.co', '2001-01-15');
INSERT INTO Programa (nombre, duracion, facultad) VALUES ('Ingeniería de Software', 10, 'Ingeniería');
INSERT INTO Programa (nombre, duracion, facultad) VALUES ('Matemáticas', 8, 'Ciencias');
INSERT INTO Programa (nombre, duracion, facultad) VALUES ('Administración', 9, 'Económicas');
INSERT INTO Docente (nombre, correo, especialidad) VALUES
('Carlos Díaz', 'carlos.diaz@udec.edu.co', 'Bases de Datos'),
('María Pérez', 'maria.perez@udec.edu.co', 'Matemáticas'),
('Juan Herrera', 'juan.herrera@udec.edu.co', 'Administración');
INSERT INTO Matricula (id_estudiante, id_programa, fecha)
SELECT id_estudiante, 1 , CURDATE() FROM Estudiantes WHERE ciudad IS NULL;
LOAD DATA INFILE 'evaluaciones.csv'
INTO TABLE Evaluacion
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
(id_matricula, id_docente, nota, observaciones);
UPDATE Estudiantes SET correo='ana.torres2025@udec.edu.co' WHERE id_estudiante=1;
UPDATE Programa SET facultad='Facultad de Ingeniería' WHERE facultad='Ingeniería';
UPDATE Evaluacion e
JOIN Docente d ON e.id_docente = d.id_docente
SET e.nota = 5.0
WHERE d.especialidad='Bases de Datos';
DELETE FROM Estudiantes WHERE id_estudiante=2;
DELETE FROM Programa WHERE id_programa=1;
DELETE FROM Estudiantes WHERE id_estudiante=1;
TRUNCATE TABLE Evaluacion;



