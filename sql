-- Crear base de datos
CREATE DATABASE RecursosHumanos;
GO

-- Usar la base de datos
USE RecursosHumanos;
GO

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1), -- ID autoincremental
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) UNIQUE NOT NULL,
    FechaNacimiento DATE,
    FechaUnion DATETIME DEFAULT GETDATE() -- Fecha en que se unió el usuario
);
GO

-- Tabla de Contrasenias
CREATE TABLE Contrasenias (
    ContraseniaID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    HashContrasenia NVARCHAR(255) NOT NULL, -- Encriptada
    FechaCambio DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID) ON DELETE CASCADE
);
GO

-- Tabla de Fechas (eventos, marcaciones)
CREATE TABLE Fechas (
    FechaID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    Fecha DATE NOT NULL,
    Descripcion NVARCHAR(255),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID) ON DELETE CASCADE
);
GO

-- Tabla de Tiempos (entrada/salida por fecha)
CREATE TABLE Tiempos (
    TiempoID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    FechaID INT NOT NULL,
    HoraEntrada TIME,
    HoraSalida TIME,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID) ON DELETE CASCADE,
    FOREIGN KEY (FechaID) REFERENCES Fechas(FechaID) ON DELETE CASCADE
);
GO

-- Tabla de Tiempos de Uso (tiempo total o por sesión)
CREATE TABLE TiemposDeUso (
    TiempoUsoID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT NOT NULL,
    FechaUso DATETIME DEFAULT GETDATE(), -- Fecha de la sesión
    MinutosUsados INT NOT NULL, -- Tiempo en minutos o segundos (según el diseño)
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID) ON DELETE CASCADE
);
GO
