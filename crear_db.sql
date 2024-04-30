-- TABLAS
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Usuario')
BEGIN
	CREATE TABLE [dbo].[Usuario]
	(
		[dni] NVARCHAR(9) NOT NULL,
		[email] NVARCHAR(50) NOT NULL,
		[nombre] NVARCHAR(33) NOT NULL,
		[apellidos] NVARCHAR(55) NOT NULL,
		[telefono] NVARCHAR(15),
		[cod_postal] NVARCHAR(5),
		[admin] BIT,
		CONSTRAINT pk_usuario PRIMARY KEY ([dni])
	);
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Direccion')
BEGIN
	CREATE TABLE [dbo].[Direccion]
	(
		[id] INT IDENTITY(1,1),
		[calle] NVARCHAR(100) NOT NULL,
		[cod_postal] NVARCHAR(5) NOT NULL,
		[ciudad] NVARCHAR(40),
		[provincia] NVARCHAR(25),
		[pais] NVARCHAR(50),
		constraint pk_direccion PRIMARY KEY([id])
	)
END;
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Direccion_en')
BEGIN
	CREATE TABLE [dbo].[Direccion_en]
	(
		[usuario] NVARCHAR(9),
		[direccion] INT,
		CONSTRAINT pk_direccion_en PRIMARY KEY([usuario],[direccion]),
		CONSTRAINT fk_direccion_en_1 FOREIGN KEY([usuario]) REFERENCES Usuario,
		CONSTRAINT fk_direccion_en_2 FOREIGN KEY([direccion]) REFERENCES Direccion
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Locker')
BEGIN
	CREATE TABLE [dbo].[Locker]
	(
		[id] INT IDENTITY(1,1),
		[nombre] NVARCHAR(50),
		[calle] NVARCHAR(100),
		[cod_postal] NVARCHAR(25),
		CONSTRAINT pk_locker PRIMARY KEY ([id]),
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Carrito')
BEGIN
	CREATE TABLE [dbo].[Carrito]
	(
		[num_carrito] INT IDENTITY(1,1),
		[fecha] DATE,
		CONSTRAINT pk_carrito PRIMARY KEY ([num_carrito])
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Carrito_de')
BEGIN
	CREATE TABLE [dbo].[Carrito_de]
	(
		[usuario] NVARCHAR(9), 
		[carrito] int UNIQUE,
		CONSTRAINT pk_carrito_de PRIMARY KEY([usuario]),
		CONSTRAINT fk_carrito_de_1 FOREIGN KEY ([usuario]) REFERENCES Usuario,
		CONSTRAINT fk_carrito_de_2 FOREIGN KEY ([carrito]) REFERENCES Carrito
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Locker_en')
BEGIN
	CREATE TABLE [dbo].[Locker_en]
	(
		[direccion] INT,
		[locker] INT UNIQUE,
		CONSTRAINT pk_locker_en PRIMARY KEY([direccion]),
		CONSTRAINT fk_locker_en_1 FOREIGN KEY ([direccion]) REFERENCES Direccion,
		CONSTRAINT fk_locker_en_2 FOREIGN KEY ([locker]) REFERENCES Locker
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Pedido')
BEGIN
	CREATE TABLE [dbo].[Pedido]
	(
		[num_pedido] INT IDENTITY(1,1),
		[fecha] DATE NOT NULL,
		[usuario] NVARCHAR(9),
		CONSTRAINT pk_pedido PRIMARY KEY ([num_pedido]),
		CONSTRAINT fk_pedido_1 FOREIGN KEY ([usuario]) REFERENCES Usuario
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Promocion')
BEGIN
	CREATE TABLE [dbo].[Promocion]
	(
		[id] INT IDENTITY(1,1),
		[descuento] INT NOT NULL,
		[disponibilidad] BIT,
		CONSTRAINT pk_promocion PRIMARY KEY ([id])
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Categoria')
BEGIN
	CREATE TABLE [dbo].[Categoria]
	(
		[tipo] NVARCHAR(30),
		[descripcion] NVARCHAR(100),
		CONSTRAINT pk_categoria PRIMARY KEY([tipo])
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Producto')
BEGIN
	CREATE TABLE [dbo].[Producto]
	(
		[id] INT IDENTITY(1,1),
		[nombre] NVARCHAR(33),
		[pvp] DECIMAL(3, 2),
		[url_image] NVARCHAR(30),
		[descripcion] VARCHAR(100),
		[stock] INT,
		[popularidad] INT,
		[promocion] INT,
		[categoria] NVARCHAR(30),
		CONSTRAINT pk_producto PRIMARY KEY ([id]),
		CONSTRAINT fk_producto_1 FOREIGN KEY ([promocion]) REFERENCES Promocion,
		CONSTRAINT fk_producto_2 FOREIGN KEY ([categoria]) REFERENCES Categoria
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Valora')
BEGIN
	CREATE TABLE [dbo].[Valora]
	(
		[usuario] NVARCHAR(9),
		[producto] INT UNIQUE,
		[puntuacion] INT NOT NULL,
		[descripcion] NVARCHAR(100),
		CONSTRAINT pk_valora PRIMARY KEY ([usuario]),
		CONSTRAINT fk_valora_1 FOREIGN KEY ([usuario]) REFERENCES Usuario,
		CONSTRAINT fk_valora_2 FOREIGN KEY ([producto]) REFERENCES Producto
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Linea_pedido')
BEGIN
	CREATE TABLE [dbo].[Linea_pedido]
	(
		[id] INT IDENTITY(1, 1),
		[cantidad] INT,
		[pedido] INT,
		[producto] INT,
		CONSTRAINT pk_linea_pedido PRIMARY KEY([id], [pedido]),
		CONSTRAINT fk_linea_pedido_1 FOREIGN KEY([pedido]) REFERENCES Pedido,
		CONSTRAINT fk_linea_pedido_2 FOREIGN KEY ([producto]) REFERENCES Producto
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Linea_carrito')
BEGIN
	CREATE TABLE [dbo].[Linea_carrito]
	(
		[id] INT IDENTITY(1, 1),
		[cantidad] INT,
		[carrito] INT,
		[producto] INT,
		CONSTRAINT pk_linea_carrito PRIMARY KEY([id], [carrito]),
		CONSTRAINT fk_linea_carrito_1 FOREIGN KEY([carrito]) REFERENCES Carrito,
		CONSTRAINT fk_linea_carrito_2 FOREIGN KEY([producto]) REFERENCES Producto
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Testimonial')
BEGIN
	CREATE TABLE [dbo].[Testimonial]
	(
		[id] INT IDENTITY(1,1),
		[mensaje] NVARCHAR(30),
		CONSTRAINT pk_testimonial PRIMARY KEY([id])
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Califica')
BEGIN
	CREATE TABLE [dbo].[Califica]
	(
		[testimonial] INT,
		[usuario] NVARCHAR(9) UNIQUE,
		CONSTRAINT pk_califica PRIMARY KEY([testimonial]),
		CONSTRAINT fk_califica_1 FOREIGN KEY ([testimonial]) REFERENCES Testimonial,
		CONSTRAINT fk_califica_2 FOREIGN KEY ([usuario]) REFERENCES Usuario
	)
END;


