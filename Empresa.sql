-- Eliminar la base de datos si existe
DROP DATABASE IF EXISTS Empresa;

-- Crear una base de datos 
CREATE DATABASE Empresa;

-- Posicionarnos en nuestra BD 
USE Empresa;

-- Crear tabla de empleado
CREATE TABLE Empleados (
EmpleadoID INT PRIMARY KEY auto_increment,
Nombre VARCHAR(50) NOT NULL,
Apellido VARCHAR(50) NOT NULL,
FechaNacimiento DATE,
Genero ENUM('Masculino', 'Femenino', 'Otro'),
Salario DECIMAL(10,2)
);

-- Insercion basica 
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, FechaNacimiento, Genero, Salario) VALUES
(1,'Juan','Perez','2003-05-15','Masculino', 13500.00);

-- Visualizar insercion 
SELECT * FROM Empresa.Empleados;

-- Crear tabla de sucursales
CREATE TABLE Sucursales (
SucursalID INT PRIMARY KEY AUTO_INCREMENT,
NombreSucursal VARCHAR(50) NOT NULL,
Direccion VARCHAR(100) NOT NULL
);

-- Modificar la tabla Empleados 
ALTER TABLE Empleados
ADD COLUMN SucursalID INT,
ADD FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID); -- Incluir relacion con Sucursales

-- Insercion de una sucursal 
INSERT INTO Sucursales (NombreSucursal, Direccion) VALUES 
('Sucursal A', 'Estado de México, Galerias 123');

-- Asignar la sucursal al empleado Juan Perez
UPDATE Empleados SET SucursalID = 1 WHERE EmpleadoID = 1;

-- Insercion de un nuevo empleado 
INSERT INTO Empleados (Nombre, Apellido, FechaNacimiento, Genero, Salario, SucursalID) VALUES
('Luis', 'Garcia', '1988-07-23', 'Masculino', 15800.00, 1),
('Maria', 'Lopez', '2000-11-03', 'Femenino', 17500.00, 1);

-- Visualizar todos mis empleados
SELECT * FROM Empleados;

-- Insercion de 2 sucursales mas
INSERT INTO Sucursales (NombreSucursal, Direccion) VALUES 
('Sucursal B', 'CDMX, Coyoacan 300'),
('Sucursal C', 'Guadalajara, Centro 11');

-- Visualizar mis sucursales
SELECT * FROM Sucursales;

-- Insercion de nuevos empleados para sucursales 2 y 3
INSERT INTO Empleados (Nombre, Apellido, FechaNacimiento, Genero, Salario, SucursalID) VALUES
('Ana', 'Villanueva', '1998-12-23', 'Masculino', 19850.00, 2),
('Miguel', 'Torres', '2001-11-03', 'Masculino', 13590.00, 3),
('Diego', 'Gallegos', '1999-09-27', 'Masculino', 11800.00, 2),
('Diego', 'Lechuga', '2003-12-03', 'Masculino', 10540.00, 3);

-- Consultas / SELECT columnas FROM tabla WHERE condicion ---

-- Empleados que tienen un salario superior a 15000
SELECT * FROM Empleados WHERE Salario > 15000.00;

-- Obtener la informacion de una sucursal especifica 
SELECT * FROM Sucursales WHERE NombreSucursal = 'Sucursal A';

-- Seleccionar empleados que trabajan en una sucursal en especifico 
SELECT * FROM Empleados WHERE SucursalID = 3;

-- Empleados femeninos que tienen un salario mayor a 16,000
SELECT * FROM Empleados WHERE Genero = 'Femenino' AND SALARIO > 16000.00;

-- Actualizacion del genero de Ana Villanueva 
UPDATE Empleados SET Genero = 'Femenino' WHERE EmpleadoID = 4;

-- Eliminacion de un empleado
DELETE FROM Empleados WHERE EmpleadoID = 6;

-- Crear tabla departamentos 
CREATE TABLE Departamentos(
DepartamentoID INT PRIMARY KEY AUTO_INCREMENT,
NombreDepartamento VARCHAR(50) NOT NULL, 
Descripcion VARCHAR(100), 
SucursalID INT, 
FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID)
);

-- Insercion de departamentos 
INSERT INTO Departamentos(NombreDepartamento, Descripcion, SucursalID) VALUES
('Ventas', 'Departamento interno de ventas mayoreo', 1),
('RH', 'Recursos Humanos y Gestion del personal', 2),
('Contabilidad', 'Gestion financiera', 3),
('Marketing', 'Estrategias de marketing y ventas', 1);

SELECT * FROM Empresa.empleados;

SELECT * FROM Empresa.departamentos;

SELECT * FROM Empresa.sucursales;

-- Consultas con funciones de agregacion

-- Contar el numero total de empleados que tengo 
SELECT COUNT(EmpleadoID) AS TotalEmpleados FROM Empleados;

-- Calcular la suma total de los salarios 
SELECT SUM(Salario) AS SalarioTotal
FROM Empleados;

-- Salario minimo 
SELECT MIN(Salario) AS SalarioMinimo
FROM Empleados;

-- Salario maximo 
SELECT MAX(Salario) AS SalarioMaximo
FROM Empleados;

-- Numero de empleados por genero y ordenarlos de manera descendente
SELECT Genero, COUNT(EmpleadoID) AS TotalEmpleados
FROM Empleados 
GROUP BY Genero
Order BY TotalEmpleados DESC;

-- Cantidad de empleados por año de nacimiento y ordenarlos de manera descendente
SELECT YEAR(FechaNacimiento) AS AñoNacimiento, COUNT(EmpleadoID) AS TotalEmpleados
FROM Empleados 
GROUP BY AñoNacimiento
ORDER BY AñoNacimiento DESC;

-- Consulta INNER JOIN 

-- Obtener informacion de empleados (nombre, apellido, salario) y de la sucursal a la que pertenecen 
SELECT Empleados.Nombre, Empleados.Apellido, Empleados.Salario, Sucursales.NombreSucursal
FROM Empleados 
INNER JOIN Sucursales ON Empleados.SucursalID = Sucursales.SucursalID;

-- Utilizando AS de tablas 
SELECT e.Nombre, e.Apellido, e.Salario, s.NombreSucursal
FROM Empleados AS e
INNER JOIN Sucursales AS s ON e.SucursalID = s.SucursalID;

-- INNER JOIN: Devuelve las filas que tienen coincidencias en ambas tablas 
SELECT Empleados.*, Sucursales.NombreSucursal
FROM Empleados 
INNER JOIN Sucursales ON Empleados.SucursalID = Sucursales.SucursalID;

-- Insercion de empleadas sin sucursal asignada
INSERT INTO Empleados (Nombre, Apellido, FechaNacimiento, Genero, Salario, SucursalID) VALUES
('Maria', 'Vazques', '1988-07-23', 'Femenino', 13800.00, NULL),
('Alejandra', 'Garcia', '1998-11-23', 'Femenino', 5800.00, NULL),
('Brenda', 'Torres', '1978-07-23', 'Femenino', 19850.00, NULL);

-- LEFT JOIN: Devuelve todas las filas de la tabla izquierda y las coincidentes de la tabla derecha 
SELECT Empleados.*, Sucursales.NombreSucursal
FROM Empleados 
LEFT JOIN Sucursales ON Empleados.SucursalID = Sucursales.SucursalID;

-- Insercion de sucursales, no tienen empleados asignados
INSERT INTO Sucursales (NombreSucursal, Direccion) VALUES 
('Sucursal D', 'Veracruz Playa Blanca 55'),
('Sucursal E', 'Morelia, T');

-- RIGHT JOIN: Devuelve todas las filas de la tabla derecha y las coincidentes de la tabla izquierda 
SELECT Empleados.*, Sucursales.NombreSucursal
FROM Empleados 
RIGHT JOIN Sucursales ON Empleados.SucursalID = Sucursales.SucursalID;

-- FULL JOIN: Devuelve todas las filas cuando hay una coincidencia en alguna de las tablas 
-- SELECT Empleados.*, Sucursales.NombreSucursal
-- FROM Empleados 
-- FULL JOIN Sucursales ON Empleados.SucursalID = Sucursales.SucursalID;

-- CROSS JOIN: Producto cartesiano de ambas 
SELECT Empleados.*, Sucursales.NombreSucursal
FROM Empleados 
CROSS JOIN Sucursales;

-- Creacion de vista 
CREATE VIEW VistaSucursalesConDepto AS 
SELECT 
	S.SucursalID, 
    S.NombreSucursal,
    COUNT(D.DepartamentoID) AS CantidadDeptos,
    GROUP_CONCAT(D.NombreDepartamento SEPARATOR ', ') AS NombresDeptos
FROM
	Sucursales AS S 
LEFT JOIN 
	Departamentos AS D ON S.SucursalID = D.SucursalID
GROUP BY 
	S.SucursalID, S.NombreSucursal;
    
SELECT * FROM VistaSucursalesConDepto;

-- Vista: Mostrar empleados con el nombre de su sucursal asignada (Nombre)
-- Vista: Resumen del salario total por departamento (Nombre del departamento, salario total) 

USE empresa;

-- Agregar nuestra tabla registro de empleado 
CREATE TABLE RegistroEmpleados(
RegistroID INT PRIMARY KEY AUTO_INCREMENT, 
Accion VARCHAR(20) NOT NULL, 
Fecha TIMESTAMP NOT NULL, 
EmpleadoID INT, 
FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID) 
);

-- Crear trigger: Registrar cada que inserte un nuevo empleado 
DELIMITER // 
CREATE TRIGGER despues_insertar_empleado
AFTER INSERT 
ON Empleados 
FOR EACH ROW 
BEGIN 
	INSERT INTO RegistroEmpleados(Accion, Fecha, EmpleadoID)
    VALUES ('Inserción', NOW(), NEW.EmpleadoID);
END;
// 
DELIMITER ;

-- Insercion de un nuevo empleado 
INSERT INTO Empleados (Nombre, Apellido, FechaNacimiento, Genero, Salario, SucursalID) VALUES
('Guadalupe', 'Villanueva', '1968-10-20', 'Femenino', 12500.00, 3);

-- Agregar columna de Fecha de cuando se modifica el salario 
ALTER TABLE Empleados
ADD COLUMN FechaCambioSalario TIMESTAMP;

-- Crear trigger de actualizar la fecha de modificacion si se actualiza el salario de un empleado
-- Crear trigger de actualizar la fecha de modificacion si se actualiza el salario de un empleado
DELIMITER // 
CREATE TRIGGER antes_update_salario
BEFORE UPDATE
ON Empleados 
FOR EACH ROW 
BEGIN 
    IF NEW.Salario <> OLD.Salario THEN
        SET NEW.FechaCambioSalario = NOW();
    END IF;
END;
// 
DELIMITER ;


-- Actualizamos un salario de empleado
UPDATE Empleados SET Salario = 12000 WHERE EmpleadoID = 1;

-- Mostramos la informacion de nuestros triggers
SHOW TRIGGERS;


-- Desactivando el autocommit
SET autocommit = 0;

-- Iniciar transaccion 
START TRANSACTION;
-- Creando un savepoint al que podemos regresar
SAVEPOINT savepoint1;
UPDATE Empleados SET Salario = Salario * 1.1 WHERE SucursalID = 1;
DELETE FROM Departamentos WHERE DepartamentoID = 1;
-- Reviertiendo los cambios al savepoint1
ROLLBACK TO savepoint1;
SAVEPOINT savepoint2;
-- Operaciones de mi transaccion
INSERT INTO Sucursales (NombreSucursal,Direccion) VALUES ('Nueva sucursal', 'Ciudad universitaria');
UPDATE Empleados SET Salario = Salario * 1.2 WHERE SucursalID = 2;
-- Confirmar transaccion
COMMIT;

USE EMPRESA;

-- Crear usuarios sin contraseña
DROP USER 'gerente'@'localhost';
CREATE USER 'gerente'@'localhost' IDENTIFIED BY '';
ALTER USER 'gerente'@'localhost' IDENTIFIED BY '';

 -- Contraseña vacía
CREATE USER 'supervisor'@'localhost' IDENTIFIED BY ''; -- Contraseña vacía


-- Crear roles 
CREATE ROLE 'rol_gerente1'; 
CREATE ROLE 'rol_supervisor1';

-- Asignar roles a los usuarios
GRANT 'rol_gerente1' TO 'gerente'@'localhost';
GRANT 'rol_supervisor1' TO 'supervisor'@'localhost';

-- Otorgar permisos 
GRANT SELECT, INSERT, UPDATE ON Empleados TO 'rol_gerente1';
GRANT SELECT ON Empleados TO 'rol_supervisor1';

-- Quito/Revoco el privilegio de UPDATE
REVOKE UPDATE ON Empleados FROM 'rol_gerente1';
CREATE USER 'supervisor'@'localhost' IDENTIFIED BY ''

+-----------------+            +------------------+
|   Empleados     |            |    Sucursales    |
+-----------------+            +------------------+
| EmpleadoID      |------------| SucursalID       |
| Nombre          |            | NombreSucursal   |
| Apellido        |            | Direccion        |
| FechaNacimiento |            +------------------+
| Genero          |
| Salario         |
| SucursalID      |
+-----------------+
        |
        |
        v
+------------------+
|  Departamentos   |
+------------------+
| DepartamentoID   |
| NombreDepartamento|
| Descripcion      |
| SucursalID       |
+------------------+
        |
        |
        v
+---------------------+
| RegistroEmpleados   |
+---------------------+
| RegistroID          |
| Accion              |
| Fecha               |
| EmpleadoID          |
+---------------------+
