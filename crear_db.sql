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
	PRIMARY KEY ([dni]),
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
)

CREATE TABLE [dbo].[Carrito]
(
	[num_carrito] INT IDENTITY(1,1),
	[fecha] DATE,
	PRIMARY KEY ([num_carrito])
)

CREATE TABLE [dbo].[Carrito_De]
(
	[usuario] NVARCHAR(9), 
	[carrito] int UNIQUE,
	CONSTRAINT d_pk PRIMARY KEY([usuario])
	CONSTRAINT fk_1 FOREIGN KEY ([usuario]) REFERENCES Usuario
	CONSTRAINT fk_2 FOREIGN KEY ([carrito]) REFERENCES Carrito
)

CREATE TABLE [dbo].[Locker_En]
(
	[calle] NVARCHAR(100),
	[cod_postal] NVARCHAR(5),
	[locker] INT UNIQUE,
	CONSTRAINT d_pk PRIMARY KEY([calle], [cod-postal])
	CONSTRAINT fk_1 FOREIGN KEY ([calle],[cod-postal]) REFERENCES Direccion
	CONSTRAINT fk_2 FOREIGN KEY ([locker]) REFERENCES Locker
)

CREATE TABLE [dbo].[Pedido]
(
	[num_pedido] INT IDENTITY(1,1),
	[fecha] DATE NOT NULL,
	[usuario] NVARCHAR(9),
	CONSTRAINT pk PRIMARY KEY ([num_pedido])
	CONSTRAINT fk_1 FOREIGN KEY ([usuario]) REFERENCES Usuario
)

CREATE TABLE [dbo].[Producto]
(
	[id] INT IDENTITY(1,1),
	[nombre] NVARCHAR(33),
	[pvp] DECIMAL(3, 2),
	[url_image] NVARCHAR(30),
	[descripcion] VARCHAR()
	[stock] INT,
	[popularidad] INT,
	[promocion] INT,
	[categoria] NVARCHAR(30),
	CONSTRAINT pk PRIMARY KEY ([id])
	CONSTRAINT fk_1 FOREIGN KEY ([promocion]) REFERENCES Promocion,
	CONSTRAINT fk_2 FOREIGN KEY ([categoria]) REFERENCES Categoria
)	

CREATE TABLE [dbo].[Promocion]
(
	[id] INT IDENTITY(1,1),
	[descuento] INT NOT NULL,
	[disponibilidad] BOOLEAN,
	CONSTRAINT pk PRIMARY KEY ([id])
)

CREATE TABLE [dbo].[Valora]
(
	[usuario] NVARCHAR(9),
	[producto] INT UNIQUE,
	[puntuacion] INT NOT NULL,
	[descripcion] NVARCHAR(100),
	CONSTRAINT pk PRIMARY KEY ([usuario]),
	CONSTRAINT fk_1 FOREIGN KEY ([usuario]) REFERENCES Usuario,
	CONSTRAINT fk_2 FOREIGN KEY ([producto]) REFERENCES Producto
)

CREATE TABLE [dbo].[Linea_Pedido]
(
	[id] INT IDENTITY(1, 1),
	[cantidad] INT,
	[pedido] INT,
	[producto] INT,
	CONSTRAINT d_pk PRIMARY KEY([id], [pedido]),
	CONSTRAINT fk_1 FOREIGN KEY([pedido]) REFERENCES Pedido,
	CONSTRAINT fk_2 FOREIGN KEY ([producto]) REFERENCES Producto
)

CREATE TABLE [dbo].[Linea_Carrito]
(
	[id] INT IDENTITY(1, 1),
	[cantidad] INT,
	[carrito] INT,
	[producto] INT,
	CONSTRAINT d_pk PRIMARY KEY([id], [carrito]),
	CONSTRAINT fk_1 FOREIGN KEY([pedido]) REFERENCES Carrito
	CONSTRAINT fk_2 FOREIGN KEY([producto]) REFERENCES Producto
)

CREATE TABLA [dbo].[Categoria]
(
	[tipo] NVARCHAR(30),
	[descripcion] NVARCHAR(50)
)

CREATE TABLE [dbo].[Testimonial]
(
	[id] INT IDENTITY(1,1),
	[mensaje] NVARCHAR(30),
	CONSTRAINT pk PRIMARY KEY([id])
)

CREATE TABLE [dbo].[Califica]
(
	[testimonial] INT,
	[usuario] NVARCHAR(9) UNIQUE,
	CONSTRAINT pk PRIMARY KEY([testimonial])
	CONSTRAINT fk_1 FOREIGN KEY ([testimonial]) REFERENCES Testimonial,
	CONSTRAINT fk_2 FOREIGN KEY ([usuario]) REFERENCES Usuario
)


