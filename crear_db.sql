-- TABLAS
CREATE TABLE [dbo].[Usuario]
(
	[dni] NVARCHAR(9) NOT NULL,
	[email] NVARCHAR(50) NOT NULL,
	[nombre] NVARCHAR(33) NOT NULL,
	[apellidos] NVARCHAR(55) NOT NULL,
	[telefono] NVARCHAR(15),
	[nacido] DATE,
	[calle] NVARCHAR(100),
	[cod_postal] NVARCHAR(25),
	PRIMARY KEY CLUSTERED ([dni]),
	CONSTRAINT usuario_direccion_calle FOREIGN KEY(calle) REFERENCES Direccion(calle),
	CONSTRAINT usuario_direccion_cod_postal FOREIGN KEY(cod_postal) REFERENCES Direccion(cod_postal)
	
)
CREATE TABLE [dbo].[Direccion]
(
	[calle] NVARCHAR(100) NOT NULL,
	[cod_postal] NVARCHAR(5) NOT NULL,
	[ciudad] NVARCHAR(40),
	[provincia] NVARCHAR(25),
	[pais] NVARCHAR(50),
	constraint d_pk PRIMARY KEY([calle],[cod_postal])
)
CREATE TABLE [dbo].[Locker]
(
	[id] INT IDENTITY(1,1),
	[nombre] NVARCHAR(50),
	[calle] NVARCHAR(100),
	[cod_postal] NVARCHAR(25),
	PRIMARY KEY CLUSTERED ([id]),
	CONSTRAINT usuario_direccion_calle FOREIGN KEY(calle) REFERENCES Direccion(calle),
	CONSTRAINT usuario_direccion_cod_postal FOREIGN KEY(cod_postal) REFERENCES Direccion(cod_postal)
)








