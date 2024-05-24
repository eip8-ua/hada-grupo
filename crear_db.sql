-- TABLAS

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Usuario')
BEGIN
	CREATE TABLE [dbo].[Usuario]
	(
		[id] INT IDENTITY(1,1),
		[dni] NVARCHAR(9) NOT NULL,
		[email] NVARCHAR(50) NOT NULL UNIQUE,
		[nombre] NVARCHAR(33) NOT NULL,
		[contrasena] NVARCHAR(30) NOT NULL,
		[apellidos] NVARCHAR(55) NOT NULL,
		[telefono] NVARCHAR(15),
		[fecha_nac] DATE,
		[admin] BIT,
		CONSTRAINT pk_usuario PRIMARY KEY ([id])
	)
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
		[usuario] INT,
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
		[usuario] INT, 
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
		[usuario] INT,
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
		[descripcion] NVARCHAR(200),
		CONSTRAINT pk_categoria PRIMARY KEY([tipo])
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Producto')
BEGIN
	CREATE TABLE [dbo].[Producto]
	(
		[id] INT IDENTITY(1,1),
		[nombre] NVARCHAR(80),
		[pvp] FLOAT,
		[url_image] NVARCHAR(30),
		[descripcion] VARCHAR(200),
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
		[usuario] INT,
		[producto] INT,
		[puntuacion] INT NOT NULL,
		[descripcion] NVARCHAR(200),
		CONSTRAINT pk_valora PRIMARY KEY ([usuario],[producto]),
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
		[mensaje] NVARCHAR(200),
		CONSTRAINT pk_testimonial PRIMARY KEY([id])
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Califica')
BEGIN
	CREATE TABLE [dbo].[Califica]
	(
		[testimonial] INT,
		[usuario] INT UNIQUE,
		CONSTRAINT pk_califica PRIMARY KEY([testimonial]),
		CONSTRAINT fk_califica_1 FOREIGN KEY ([testimonial]) REFERENCES Testimonial,
		CONSTRAINT fk_califica_2 FOREIGN KEY ([usuario]) REFERENCES Usuario ON DELETE SET NULL
	)
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Contactanos')
BEGIN
	CREATE TABLE [dbo].[Contactanos]
	(
		[id] INT IDENTITY(1,1),
		[nombre] NVARCHAR(33),
		[email] NVARCHAR(50),
		[telefono] NVARCHAR(15),
		[mensaje] NVARCHAR (1000),
		CONSTRAINT pk_contactanos PRIMARY KEY([id])
	)
END;

insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('68870720r', 'admin@ua.es', 'Alberto', 'Sales Paredes', '1234', '607258331', '7/22/1990', '1');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40556862m', 'user@ua.es', 'Filomeno', 'Bueno Prados', '1234', '972583351', '1/1/1959', '0');


insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('60996872i', 'emaylin0@va.gov', 'Elle', 'Maylin', 'vQ8<X<CiZ1', '3107258331', '4/15/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('38481257g', 'jrattenberie1@ameblo.jp', 'Johnathon', 'Rattenberie', 'eG3~A!x6p', '9606954639', '12/25/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82330828n', 'rmcphelimey2@harvard.edu', 'Rozelle', 'McPhelimey', 'iW7|tk|#xc', '5452430414', '5/3/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15418346v', 'sdinsmore3@nasa.gov', 'Sig', 'Dinsmore', 'wG4|Xq/J#', '1464691898', '10/19/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('50804741j', 'naikin4@t.co', 'Nert', 'Aikin', 'lW6}+9~{OQJd9', '9813017484', '7/21/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('50534735l', 'dveldens5@jugem.jp', 'Desi', 'Veldens', 'lP3&KjU>(%+~4k', '2331046675', '11/14/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98052647p', 'cmussen6@gmpg.org', 'Calli', 'Mussen', 'fK2=nN,EEmM9<*i', '6069036335', '8/15/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('42623565b', 'cwoan7@ft.com', 'Carmelia', 'Woan', 'yC7%U&068VaS?O', '4084669166', '6/14/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('77229648k', 'chuntly8@jimdo.com', 'Claudio', 'Huntly', 'lL2.&~/+CN?nQnj', '3012907801', '2/15/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('05135837w', 'apayze9@reference.com', 'Audre', 'Payze', 'dA4>8r|_u', '5695748999', '8/19/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03106580l', 'cscawtona@booking.com', 'Ced', 'Scawton', 'lX4,uoB6DgB7Sbz', '5207079913', '9/13/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45914791n', 'kdendleb@stanford.edu', 'Kym', 'Dendle', 'uI6(5zc~f!', '5661710666', '1/26/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36901732d', 'dtortisc@virginia.edu', 'Dorolice', 'Tortis', 'lC8>@h7)5ag.kxJ', '7679656560', '12/31/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('84797845t', 'hbazelld@hhs.gov', 'Hagen', 'Bazell', 'hO5>=o9_gs,w', '5793523767', '8/10/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54571776a', 'cjoysone@cpanel.net', 'Cecily', 'Joyson', 'pJ8)syWY''k', '7548813949', '2/18/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90729324c', 'dhinkensf@hexun.com', 'Dewitt', 'Hinkens', 'eK8?eVJ{v', '5281444740', '9/24/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09931971t', 'sthorntong@woothemes.com', 'Sheila-kathryn', 'Thornton', 'rN8<D9=h', '1663239374', '5/7/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54939596l', 'kbaileyh@mayoclinic.com', 'Karel', 'Bailey', 'uN9*ra~qODto', '3413169047', '9/16/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08684579v', 'emcenteei@japanpost.jp', 'Evan', 'McEntee', 'kV4`k7k9Sli@0b{', '1102882726', '6/21/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15464828y', 'bcrutj@wunderground.com', 'Bertha', 'Crut', 'aJ0@G(XUPNCN"T!', '6445533264', '3/16/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36751692c', 'dblindtk@wordpress.com', 'Demetri', 'Blindt', 'cI6<$+%T', '6158812674', '6/19/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09356865b', 'atrenearl@wordpress.com', 'Alissa', 'Trenear', 'mY7&Q,rm', '3576673688', '9/10/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00944811a', 'crosthornm@fc2.com', 'Corry', 'Rosthorn', 'mK4%xmfa7/~', '1943946290', '5/4/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08441828i', 'gbarajasn@eventbrite.com', 'Gilles', 'Barajas', 'vG4_VVoT|dKRq`PL', '4409904440', '10/18/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('62588962u', 'jkerkhamo@dmoz.org', 'Joya', 'Kerkham', 'aX2.Yln4ueG~6`y', '5898935076', '5/13/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89719009q', 'fabazip@bloglines.com', 'Forester', 'Abazi', 'fQ7''l4lywM\f`*p', '6891665359', '6/1/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('42281754r', 'mstoodersq@skype.com', 'Marge', 'Stooders', 'hJ8>*E}re4O+&12)', '4307376592', '4/4/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49617253s', 'ztebber@weibo.com', 'Zebedee', 'Tebbe', 'nB6>)!q29zf', '1528638378', '3/4/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55606830j', 'talders@bloglines.com', 'Trixi', 'Alder', 'zQ2.(*J|zTG3+?P$', '9689295776', '6/8/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87022557c', 'ddumphryt@geocities.com', 'Drona', 'Dumphry', 'hZ9.O~MoR', '6976219238', '8/25/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('39002747r', 'asteuartu@uol.com.br', 'Amalia', 'Steuart', 'yX5|QuqrV=%EhR', '7429521871', '6/3/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35309803h', 'fingarfieldv@t.co', 'Fidel', 'Ingarfield', 'dT8+d|v5(HsG9Io', '6267583619', '10/7/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('17024669w', 'tshaudfurthw@ning.com', 'Thomasine', 'Shaudfurth', 'yR2$"`MG>YM2(', '7714705014', '10/5/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31927190r', 'wlouisetx@odnoklassniki.ru', 'Wes', 'Louiset', 'jR1>L4pM8~e?e', '2323213457', '6/20/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('38885048v', 'jskyrmy@sun.com', 'Jasun', 'Skyrm', 'fK7=</hfCM1m!v', '8252826919', '3/6/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('53143375k', 'mcurlisz@go.com', 'Mano', 'Curlis', 'pL8~F9gL&2Po"k/', '8325482744', '9/22/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56070092r', 'lhelix10@php.net', 'Lyndsie', 'Helix', 'bY2_a(g_%s', '9239778119', '1/23/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82497601t', 'ksandwich11@trellian.com', 'Kile', 'Sandwich', 'qI8}K/$Y!,p', '8003292128', '7/14/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37791404s', 'rmettetal12@over-blog.com', 'Rickard', 'Mettetal', 'rL2?zS"8c', '5632883367', '9/19/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40802835u', 'rjerzykiewicz13@cbslocal.com', 'Ricardo', 'Jerzykiewicz', 'jG1<kxPb,vju3eS', '4108747250', '3/22/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41476120m', 'fmquharge14@feedburner.com', 'Fidelio', 'M''Quharge', 'bJ8)QuaTQ', '1455973084', '10/1/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23751075q', 'lpeck15@nih.gov', 'Lilyan', 'Peck', 'cM4~X$Hmd"(F', '2546853490', '2/4/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('32524206x', 'boleszcuk16@blogtalkradio.com', 'Britta', 'Oleszcuk', 'xO6&e~pPRsLh#5l', '8948974784', '6/25/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73464698z', 'tleidl17@goo.gl', 'Timothy', 'Leidl', 'zX6*>7~c', '5015971180', '7/14/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93895466m', 'alownes18@dedecms.com', 'Adaline', 'Lownes', 'sW6''4hLh>e!q', '7421676139', '11/2/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15400466m', 'lbjorkan19@illinois.edu', 'Leoline', 'Bjorkan', 'bW2@/tjGL*7{fmO', '3427486124', '9/22/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19062517p', 'melmhurst1a@howstuffworks.com', 'Marlena', 'Elmhurst', 'sK5~A_zKgP', '8112797814', '5/13/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87293649e', 'fgaenor1b@wordpress.org', 'Fleur', 'Gaenor', 'wN0*Xi=n+w_|<', '1226762010', '7/6/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69276138j', 'ataks1c@mediafire.com', 'Anissa', 'Taks', 'oS6"~TI{', '9042960900', '1/13/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73707176k', 'lwhittuck1d@amazon.co.jp', 'Linell', 'Whittuck', 'bP4.bj~g"S', '3037057626', '7/10/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('60663206y', 'fwittrington1e@japanpost.jp', 'Fulton', 'Wittrington', 'dS3_>FZB5@5s|Y', '2456590380', '10/24/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55893612m', 'ppeltzer1f@lycos.com', 'Pooh', 'Peltzer', 'sA1?c?=1rNW', '3873639223', '4/15/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('11242201z', 'lpaynter1g@china.com.cn', 'Larry', 'Paynter', 'aN7/S?)|', '7488345648', '6/22/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66586314e', 'aborer1h@twitter.com', 'Adelice', 'Borer', 'hV6*I|/wsnXw\T', '5952506749', '1/27/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21700276w', 'emeddick1i@prlog.org', 'Emelita', 'Meddick', 'dM5>K\_&WLObc', '2665717125', '4/14/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89307213k', 'frawlins1j@ucsd.edu', 'Filbert', 'Rawlins', 'zF4#AQ"XL''z', '1046011789', '7/7/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99854160h', 'jjoseph1k@nature.com', 'Josiah', 'Joseph', 'xZ7|Ml#LJOldsfC', '8406711660', '7/22/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40324489p', 'phuyhton1l@cdc.gov', 'Petra', 'Huyhton', 'nD1,kfxr&1"Ez<', '3162053527', '9/7/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08271952c', 'mnickolls1m@imgur.com', 'Micki', 'Nickolls', 'tM2>H\~}@b1s{%b', '4552053605', '11/12/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41912174q', 'esowray1n@free.fr', 'Erhard', 'Sowray', 'iQ5#@W3_%TY', '1123343981', '11/26/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31935342r', 'cfinlator1o@prnewswire.com', 'Colan', 'Finlator', 'jC9''*8OH', '3993961284', '1/12/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45767609l', 'acromer1p@washington.edu', 'Andros', 'Cromer', 'kS5,O4EE`tWaw''~', '7414515164', '9/27/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51439975h', 'mdemcak1q@cnet.com', 'Merwyn', 'Demcak', 'vH9{E!}tN''', '9165932861', '12/19/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73167959e', 'gpatise1r@comcast.net', 'Gaultiero', 'Patise', 'eH8*0m~~', '1348716141', '10/17/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66035845g', 'bhubery1s@yale.edu', 'Bartholomeus', 'Hubery', 'aK6%_1*$nOnm', '2032573296', '8/18/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('11267117o', 'bbernardin1t@dmoz.org', 'Berkly', 'Bernardin', 'tH2+>QJz5L', '8675144786', '7/11/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55814683y', 'apelham1u@macromedia.com', 'Antoinette', 'Pelham', 'jX7@,wxy`', '3125725605', '10/3/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('38327572c', 'cfarmer1v@spiegel.de', 'Currey', 'Farmer', 'gP7~N/fLi372h', '6854352135', '12/6/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51963240q', 'xpadwick1w@usda.gov', 'Xerxes', 'Padwick', 'jE4}LfD)#FzuX', '8216525861', '7/24/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31366178d', 'vlarose1x@hexun.com', 'Vinny', 'Larose', 'rL9%3he%q54JBPN', '9704322289', '9/20/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10817286u', 'mmorland1y@latimes.com', 'Michel', 'Morland', 'uL3)\Vf9', '3342430735', '5/31/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09247115n', 'hskill1z@cnbc.com', 'Hirsch', 'Skill', 'sF9'')P{"L', '7093248283', '2/27/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89828861r', 'dperrycost20@eventbrite.com', 'Denny', 'Perrycost', 'rB8`b=*7V+q`', '8413700309', '6/8/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51833822o', 'mbreckon21@vimeo.com', 'Micki', 'Breckon', 'tU5|O0.j', '1812986484', '1/2/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81465713a', 'mhymus22@sitemeter.com', 'Mordy', 'Hymus', 'aP0=H1eG!@=5`oQ', '5487444781', '3/25/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('83388546k', 'bboarer23@marriott.com', 'Bowie', 'Boarer', 'kS7?QNJT', '9433807527', '9/17/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67523894f', 'ttynemouth24@dropbox.com', 'Thia', 'Tynemouth', 'jT3$hI8.g5l', '3521874652', '3/28/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('53642842s', 'csummerell25@sohu.com', 'Cristionna', 'Summerell', 'iL7>s|<rkAZ/Y(', '7404422681', '12/28/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03126514k', 'lruos26@google.ru', 'Luelle', 'Ruos', 'qK0#gGe{LYn{Ztsh', '9373071864', '2/12/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73339427n', 'dallanson27@eventbrite.com', 'Deane', 'Allanson', 'qQ9"6uW}|g*Mv~pa', '4625975540', '2/23/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47862175a', 'lshimuk28@comsenz.com', 'Linnell', 'Shimuk', 'gR9(!adC2+#1G', '8194770450', '11/12/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93192903p', 'ejeremiah29@opensource.org', 'Etta', 'Jeremiah', 'cU7`R3O<c!W66x@', '9903491788', '10/28/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23666580l', 'tsprulls2a@tumblr.com', 'Thomasina', 'Sprulls', 'nM7/kU`l`', '8802268683', '9/2/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90284889t', 'lbims2b@wikia.com', 'Lothario', 'Bims', 'pU2#y&8!P+''_O7r', '7182043182', '12/5/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('39979800q', 'cgianilli2c@elegantthemes.com', 'Cross', 'Gianilli', 'eS9!"P%_1z', '4037770388', '10/9/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66462200e', 'mayrs2d@gov.uk', 'Missy', 'Ayrs', 'hK6&tJoQN&j', '8066454490', '2/10/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59857527q', 'mhindsberg2e@blogtalkradio.com', 'Meade', 'Hindsberg', 'fS2_FJK7P}))=nL(', '1862817794', '3/20/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('30228193l', 'tbunkle2f@cisco.com', 'Thorstein', 'Bunkle', 'hE1,$Ol2{vYl', '9946060642', '1/3/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59477605r', 'sdooly2g@dropbox.com', 'Sonni', 'Dooly', 'hQ3)>Z"''Wn9,&', '4692938114', '3/28/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('48407044p', 'vfarncombe2h@ucla.edu', 'Vanny', 'Farncombe', 'eO6(d<{|', '8894521035', '4/4/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26239543w', 'agoodsall2i@lulu.com', 'Adolf', 'Goodsall', 'pW1}RbwVIG,~2v', '4392801406', '2/3/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87625898d', 'thewkin2j@free.fr', 'Tedmund', 'Hewkin', 'hJ2(7pOC9', '3984271254', '8/31/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59563355l', 'bquigley2k@google.fr', 'Birgit', 'Quigley', 'iK9''H#zai', '7568662848', '2/20/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21042035x', 'aingham2l@bandcamp.com', 'Ally', 'Ingham', 'vR8_gFDTJRXp/', '9181075522', '9/13/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('13403287f', 'ddawber2m@prlog.org', 'Doralin', 'Dawber', 'eK2''bW.4#', '8591362981', '4/30/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81773047k', 'rdamrell2n@sourceforge.net', 'Rhianon', 'Damrell', 'dG9}`tEW!x', '3074916579', '8/10/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78655307x', 'kmachel2o@about.me', 'Karel', 'Machel', 'fD3$>/S>!''MH,', '7269295771', '10/15/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82496642m', 'madnet2p@angelfire.com', 'Meredithe', 'Adnet', 'sF4?}<9h+O(hxS&', '9758250485', '12/5/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96361174b', 'rlibero2q@gravatar.com', 'Rudd', 'Libero', 'rV2@/i\xZm}', '6267022170', '7/5/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81082168f', 'ceskell2r@dmoz.org', 'Cherice', 'Eskell', 'qR7<0SjCPQ*fC3,0', '7515254833', '7/18/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36868327u', 'rricco2s@posterous.com', 'Rochette', 'Ricco', 'nF5@tCwMZ,x<#%Rn', '4196288872', '12/18/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52438519c', 'pbiscomb2t@theatlantic.com', 'Paten', 'Biscomb', 'mN7*W>h=?C', '4471479325', '3/10/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18392031g', 'ilindbergh2u@goo.gl', 'Ingeberg', 'Lindbergh', 'lC1"}=CK"OVt', '7725927085', '4/19/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70051537h', 'kmccolley2v@cbc.ca', 'Kathlin', 'McColley', 'eP2%1U#Vq1.."Z', '3457999497', '2/22/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('44019439f', 'jshallcroff2w@mayoclinic.com', 'Jeana', 'Shallcroff', 'dG0(ERN$a''''d`f>Q', '9814848807', '2/16/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94497874t', 'oclapham2x@fc2.com', 'Odelle', 'Clapham', 'eV6?R,Pk%d/W''', '6946899880', '3/6/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('72516483c', 'pvampouille2y@msn.com', 'Prudy', 'Vampouille', 'gJ0=tI*~4X', '1381276682', '10/16/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('43224603v', 'holyfat2z@nymag.com', 'Harmonia', 'Olyfat', 'hB8/TD>*q1', '4296151578', '3/9/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49931622q', 'gpiggot30@constantcontact.com', 'Gilbert', 'Piggot', 'bN5''YtWi', '2769554307', '3/6/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64799617y', 'athairs31@tinyurl.com', 'Amy', 'Thairs', 'kY9},3l.ZAFLd+FE', '5879704597', '3/9/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26085095g', 'rewenson32@google.es', 'Rea', 'Ewenson', 'bD3#jtA6FrM`Uk+', '9176834147', '10/10/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08124256z', 'cdurward33@gizmodo.com', 'Clarissa', 'Durward', 'kG1|''&q"XafG', '9635489095', '10/27/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78852311x', 'jgentzsch34@studiopress.com', 'Jeannie', 'Gentzsch', 'tV6%>!"33!', '4424082958', '4/4/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('01316071i', 'kbullant35@i2i.jp', 'Katee', 'Bullant', 'oC1)i?Uf''O0?KwH', '6788972095', '7/12/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69931686d', 'tcuolahan36@t-online.de', 'Tilly', 'Cuolahan', 'uL0(5c&zNI*/y', '3072007614', '9/26/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36607643s', 'erodrigues37@paginegialle.it', 'Eleanore', 'Rodrigues', 'cN1+Ew.l|!drQiW', '8678085241', '3/25/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('39198860e', 'cchastan38@ovh.net', 'Casey', 'Chastan', 'kF8\1}4''aaO', '9545320250', '10/24/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('74938393e', 'hscrewton39@wikispaces.com', 'Harlan', 'Screwton', 'fN2<Xj2G', '5719659601', '3/1/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02675447i', 'ncuffley3a@last.fm', 'Noe', 'Cuffley', 'hS8%7(6cKU)M', '2368956184', '4/14/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('62272079u', 'nsurpliss3b@opensource.org', 'Nathaniel', 'Surpliss', 'mW7=bhyxLu', '4395440046', '5/28/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78994619c', 'aslimm3c@weebly.com', 'Anson', 'Slimm', 'zW6|GNi''De', '1722993685', '8/23/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18834831l', 'mruskin3d@flickr.com', 'Margaretha', 'Ruskin', 'jJ9=7US7Mh{yNX*', '1872488398', '11/15/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00451084r', 'fwalewski3e@earthlink.net', 'Fons', 'Walewski', 'aC2/n*Tc.$f', '3935169812', '9/20/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55136863r', 'bdaws3f@a8.net', 'Batholomew', 'Daws', 'sU7&=''Zu/}', '8145758471', '11/30/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41593153i', 'glotwich3g@ifeng.com', 'Gustaf', 'Lotwich', 'wC6,L,b+QLlvn&k', '2873831613', '7/28/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51604400r', 'mviveash3h@ocn.ne.jp', 'Muire', 'Viveash', 'rQ6+u8UB0%.>T6f', '7482080393', '8/19/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('43672658i', 'hreadman3i@geocities.com', 'Hatti', 'Readman', 'wR9_PFBF{R', '6635356462', '3/15/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76481080r', 'cfaill3j@ucla.edu', 'Charity', 'Faill', 'iA0"lwf.t0U57_', '3685222628', '3/21/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10913633y', 'atampion3k@chicagotribune.com', 'Ariella', 'Tampion', 'tS9&d`Fvd', '5283651689', '6/28/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28975387b', 'tpilbeam3l@fda.gov', 'Tommy', 'Pilbeam', 'iF3,Jtp!hZ', '5241894826', '3/11/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('46597809o', 'ireuter3m@mtv.com', 'Isiahi', 'Reuter', 'iR8{zn`kf.', '1977295728', '6/21/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('46837857k', 'fglyn3n@google.com.br', 'Francois', 'Glyn', 'nH6{P8*/b/NO=eQq', '2365939755', '3/17/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82977557c', 'camar3o@businessweek.com', 'Cody', 'Amar', 'jV0.t?1NACwBi', '5851658887', '11/23/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09311586k', 'lmarten3p@reference.com', 'Loreen', 'Marten', 'xD0*Qz60', '7339114771', '7/11/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91309670f', 'dsolloway3q@reference.com', 'Donnell', 'Solloway', 'bV5~RNMjT9p', '9628640431', '8/24/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('65239034g', 'mallworthy3r@ehow.com', 'Mela', 'Allworthy', 'iP6~M0#''0C"2u90', '1313607782', '6/6/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86896780z', 'atipperton3s@usatoday.com', 'Adolphe', 'Tipperton', 'kT3|eaEEt`hp=,7', '1666512823', '3/20/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('42854216g', 'jlinnane3t@tinypic.com', 'Jacinda', 'Linnane', 'vX8{!B`rm$(J3O<', '1882598132', '3/16/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55110083v', 'mbingle3u@addthis.com', 'Myriam', 'Bingle', 'qL7{g``!lo`', '4374742207', '1/21/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96597553n', 'mmacalinden3v@dedecms.com', 'Moshe', 'MacAlinden', 'rN2`YKPQ', '2211410260', '8/2/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('48494444e', 'revetts3w@yahoo.co.jp', 'Reinwald', 'Evetts', 'lL1<,4)N9H,EbkP/', '2392988306', '10/28/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59870335l', 'fmacgorrie3x@fotki.com', 'Fredra', 'MacGorrie', 'jC9>EAu4YvNUfli', '8032225620', '4/2/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15592063x', 'kdifrancesco3y@ftc.gov', 'Kylynn', 'Di Francesco', 'gA4)U#jy@&Px#', '7084613510', '5/27/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26481342x', 'lphuprate3z@chron.com', 'Lelah', 'Phuprate', 'dA9\)98"Z|H5tq''g', '5238102693', '8/31/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02735691t', 'kgodfery40@163.com', 'Kara', 'Godfery', 'oY6~Wa?6', '4145673756', '12/3/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98954771h', 'lbeaconsall41@princeton.edu', 'Luella', 'Beaconsall', 'bR9_Akhk''', '6858858928', '3/24/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19430510l', 'hsoar42@usa.gov', 'Helge', 'Soar', 'tJ1?StXl,m(faLb', '5496978585', '10/14/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81562219z', 'mdrewry43@lycos.com', 'Millard', 'Drewry', 'vC4?vEOi#sW', '9702532346', '9/28/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('29658676x', 'fmcmillam44@ibm.com', 'Fionna', 'McMillam', 'dT9~/''ZK', '1263304086', '4/9/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52392490b', 'csine45@state.tx.us', 'Cordell', 'Sine', 'lL2~y|c`t', '2192167389', '7/26/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21066057h', 'jcornbill46@posterous.com', 'Johnath', 'Cornbill', 'bC3``@{DQiyeT', '1133092425', '9/13/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('57605686d', 'dsinclaire47@yahoo.co.jp', 'Denys', 'Sinclaire', 'yD7}coyNAUs%1<I', '8312686433', '2/21/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23571843t', 'ksmalridge48@china.com.cn', 'Kaile', 'Smalridge', 'vE7!(bRlP=ykQ', '6322812150', '10/8/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55302109v', 'lalabaster49@51.la', 'Lyssa', 'Alabaster', 'rI4#G%P,e.~', '5524316305', '9/1/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('13346463e', 'tverman4a@thetimes.co.uk', 'Tod', 'Verman', 'jJ8!ieLmWg(!Hb?', '8021925368', '4/10/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55703817z', 'schiswell4b@hibu.com', 'Susie', 'Chiswell', 'rS1\HYMF_V', '9385443996', '3/20/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91636183j', 'ewhittaker4c@nsw.gov.au', 'Emelina', 'Whittaker', 'dK0$#v/GKRgp', '2843688024', '7/4/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('01992086g', 'mpenberthy4d@goodreads.com', 'Melinde', 'Penberthy', 'bH1=y_rZ~n', '7868373197', '8/19/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19076861y', 'broughsedge4e@furl.net', 'Buddy', 'Roughsedge', 'uB7#Oet=\~', '1772512864', '2/21/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('46368511c', 'hkupker4f@wikipedia.org', 'Hakeem', 'Kupker', 'rF2~2ik=+GW,', '2374176394', '7/9/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56512558u', 'daishford4g@wisc.edu', 'Daisy', 'Aishford', 'gS3}?k@GK', '8525496997', '10/23/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93506542m', 'kvedmore4h@lycos.com', 'King', 'Vedmore', 'eY7_SQFX7sU/kY', '2711097490', '9/21/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96196934b', 'jmackriell4i@rakuten.co.jp', 'Joya', 'Mackriell', 'aA0.t3wMl2', '8238535895', '1/13/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23619589h', 'mferreira4j@reddit.com', 'Mollee', 'Ferreira', 'yL4>OF"mi?8$0', '9678991541', '4/14/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52653466w', 'gwhitsey4k@biglobe.ne.jp', 'Gianni', 'Whitsey', 'bF9&Z"h_#i0`', '7716301907', '7/5/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('85165077w', 'ndunridge4l@rakuten.co.jp', 'Nicolai', 'Dunridge', 'uU7}jm5f)SO5bg', '6161792481', '11/1/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23082132v', 'eleversha4m@phoca.cz', 'Edlin', 'Leversha', 'dC9{)3~td{CJrh', '2938890641', '3/13/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('13221223a', 'alarter4n@skype.com', 'Annie', 'Larter', 'zV5<vTrD%iip', '2038810792', '1/2/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08936274o', 'dbendig4o@nasa.gov', 'Dolf', 'Bendig', 'mF2|q`oxdbdABv<E', '4595811650', '10/19/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88782297z', 'tpashby4p@blinklist.com', 'Tamiko', 'Pashby', 'hZ4.vNCjqGZ', '6378715477', '12/30/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21698920g', 'npyser4q@youku.com', 'Niall', 'Pyser', 'bN7|H\~hs.5.W', '3335633933', '1/27/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64793968b', 'riorizzi4r@qq.com', 'Rowney', 'Iorizzi', 'cP5$%G7}s(o&h', '9135024592', '4/5/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37730485q', 'vgiacomasso4s@g.co', 'Virgie', 'Giacomasso', 'uY2`&<*`', '4876848143', '3/30/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52746040z', 'rkrauze4t@irs.gov', 'Ryley', 'Krauze', 'jP7+~<t6h2', '7169792436', '9/27/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09498045v', 'blillgard4u@reddit.com', 'Brennan', 'Lillgard', 'iK7$of)T+j', '5779875783', '8/10/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45030188v', 'kdaubney4v@apache.org', 'Katheryn', 'D''Aubney', 'hH7_/zpaYp2"*', '9896901616', '5/12/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('71311721y', 'gcoppard4w@behance.net', 'Gypsy', 'Coppard', 'lD7~|(+,{NU2<', '9569520275', '10/12/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55947775f', 'lcakebread4x@1und1.de', 'Laverne', 'Cakebread', 'nZ0"B5,Ub`Jw`', '5343575384', '10/24/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('14679304d', 'pmarcos4y@stanford.edu', 'Persis', 'Marcos', 'tB5)W%Dmd4d}(h`', '4764241062', '9/9/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10879080n', 'amacane4z@squidoo.com', 'Alberik', 'MacAne', 'qN2&_1=@\e\\', '9733141201', '4/9/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('60016252d', 'mangier50@twitter.com', 'Morganica', 'Angier', 'bH8{Qs+*sK*Nxi', '1813301439', '6/29/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37654326r', 'rmcguffog51@wordpress.org', 'Rodrick', 'McGuffog', 'wV8)?l)7LlfE7tw', '1773520582', '4/12/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('05974216i', 'hstirton52@squidoo.com', 'Hiram', 'Stirton', 'iH8/%~p9', '4404109892', '4/13/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('20570025v', 'tseifenmacher53@theguardian.com', 'Tessy', 'Seifenmacher', 'bG4@~.!REJ', '8145433265', '5/31/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19582851p', 'wblackah54@joomla.org', 'Wylma', 'Blackah', 'yX0+$_Gso*K"y,Ai', '9185041858', '11/30/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66336205a', 'bdanilevich55@rakuten.co.jp', 'Baillie', 'Danilevich', 'lJ0$nWG$', '2889412018', '3/20/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('65290051m', 'kcorneil56@4shared.com', 'Kingsly', 'Corneil', 'dL4>*rP3', '9358274313', '9/1/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09403300h', 'alording57@pagesperso-orange.fr', 'Ashleigh', 'Lording', 'uM8.h0Hqh', '6396174707', '5/25/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67165567l', 'nmacnalley58@odnoklassniki.ru', 'Nina', 'MacNalley', 'fO7{c1!`#$.', '6007594597', '3/12/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02066660d', 'lkeeping59@mail.ru', 'Lonny', 'Keeping', 'dD7!b%>,3ls=O5', '1705234812', '12/30/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27074830i', 'btrayling5a@techcrunch.com', 'Brooks', 'Trayling', 'lD5\D9?WO3f_$no', '9118723228', '12/31/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21446322b', 'cfirby5b@huffingtonpost.com', 'Chrissie', 'Firby', 'fM4@VIFZ$.', '3962011156', '8/21/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69079785a', 'oockendon5c@taobao.com', 'Odille', 'Ockendon', 'kV8#t2hpZH}', '9253924574', '9/6/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10681230f', 'lstanger5d@cmu.edu', 'Linn', 'Stanger', 'zY9<''QJrDxC''M(m=', '7376205787', '1/24/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('57131271i', 'tronchetti5e@army.mil', 'Tova', 'Ronchetti', 'oN9|.q1v?UMZ', '7979307180', '8/31/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16393001d', 'mthormann5f@yellowbook.com', 'Maressa', 'Thormann', 'xK8!(@/BUt|BlLZG', '6085331451', '11/12/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00784967w', 'sbumphries5g@simplemachines.org', 'Sigvard', 'Bumphries', 'uZ8)MD90/1', '9941177843', '11/7/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87731078v', 'eklisch5h@pbs.org', 'Elinor', 'Klisch', 'cT8''!pD$ZOkGH!/}', '8481515990', '9/21/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('65731786g', 'lwhoolehan5i@opera.com', 'Loren', 'Whoolehan', 'lT0*MK}$RN(A', '8906542839', '11/20/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('68568468k', 'bkevlin5j@cargocollective.com', 'Bryana', 'Kevlin', 'sX0}jP,z)&2', '1553528676', '3/28/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56463173u', 'escowen5k@wordpress.org', 'Eolande', 'Scowen', 'vR7/Vu*uO@%', '5986914967', '4/19/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94377333y', 'yspearing5l@mapy.cz', 'Yancey', 'Spearing', 'sE1#x?NHL>y&bN4', '9629797466', '4/22/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02080724f', 'rrichardin5m@tiny.cc', 'Roddy', 'Richardin', 'tL7{eH_?tk''|gPj', '3812074263', '10/10/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('46688235k', 'bglanfield5n@psu.edu', 'Beltran', 'Glanfield', 'sQ3@SV6<qW~>M', '1844665525', '9/23/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09665904p', 'tmerritt5o@cpanel.net', 'Tripp', 'Merritt', 'nT1%%4?/RQr{rWv', '7384006759', '6/20/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('13813791y', 'mshufflebotham5p@nasa.gov', 'Maximilien', 'Shufflebotham', 'uW2{iG$&', '9417712368', '2/12/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81246692j', 'dtheriot5q@answers.com', 'Dal', 'Theriot', 'fD8"r#{J(kz,=}Q', '6625219139', '12/2/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54716040e', 'lrowan5r@nih.gov', 'Lawrence', 'Rowan', 'cQ1=dnu_u{i', '9271233491', '9/11/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('20445797d', 'cclemmen5s@cmu.edu', 'Court', 'Clemmen', 'gA8''S,%+''', '7338025383', '8/29/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31825332c', 'tmaffulli5t@whitehouse.gov', 'Torr', 'Maffulli', 'tE0''eOw`jzbg*', '5601965698', '1/22/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67288154e', 'hrottenbury5u@ocn.ne.jp', 'Hugibert', 'Rottenbury', 'wH4*?r?Ft@"tFU', '8656142594', '1/24/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('83925966p', 'edrakers5v@biglobe.ne.jp', 'Enoch', 'Drakers', 'iT5=mTPnIIHzJn|''', '2576228584', '1/17/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87435727c', 'oberntsson5w@so-net.ne.jp', 'Orella', 'Berntsson', 'dK9<q})>x*nm+E', '6754636433', '7/26/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78492498u', 'aannetts5x@instagram.com', 'Addia', 'Annetts', 'sD8!ox4QOS.ng', '1057003933', '1/23/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('53840921k', 'dcunrado5y@sfgate.com', 'Deedee', 'Cunrado', 'qY1$8IkL?r', '5607811406', '8/23/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47873459h', 'cbirdsey5z@timesonline.co.uk', 'Cherilynn', 'Birdsey', 'vC1/1<G?B)97', '9145736427', '12/28/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45357327h', 'khimsworth60@hao123.com', 'Kiersten', 'Himsworth', 'nB5,,4''%>w', '4298717279', '2/27/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26075807k', 'llyngsted61@reverbnation.com', 'Lion', 'Lyngsted', 'kE9*"''#C', '2192823527', '11/17/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16414748i', 'jbantick62@statcounter.com', 'Jakie', 'Bantick', 'sF0''_YcM+f', '3664373985', '10/31/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02283415u', 'fmorsey63@qq.com', 'Fabien', 'Morsey', 'oR7>9ko$=5F09#', '3174920318', '3/30/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25136053n', 'bwhittle64@ucoz.ru', 'Berti', 'Whittle', 'dK0?j+icyq"k', '8671766738', '3/20/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78895131k', 'uegiloff65@princeton.edu', 'Upton', 'Egiloff', 'jS7>npYWD9DYm+*', '9589987583', '4/25/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64608445z', 'hcomford66@bloglines.com', 'Haroun', 'Comford', 'iH0<C`?$''w>ork3', '9553088807', '3/14/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89239589f', 'bgerardi67@weebly.com', 'Berty', 'Gerardi', 'lU0.#+$"(', '1436025224', '11/16/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41988154h', 'dcolliar68@webs.com', 'Daile', 'Colliar', 'mD6{2r=EnE', '7593490217', '2/13/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00268442g', 'abrasener69@washington.edu', 'Amara', 'Brasener', 'oZ6+MKbK9CO', '4418839263', '1/10/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40090171k', 'fbruckner6a@imageshack.us', 'Freemon', 'Bruckner', 'wH1?1(mXH', '2925783895', '8/5/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18705371n', 'msalaman6b@cisco.com', 'Minerva', 'Salaman', 'iF2/.Y~J/6wZ&\2,', '5097873304', '9/22/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('50844424r', 'lgiffard6c@ox.ac.uk', 'Lonni', 'Giffard', 'tO4}3~P6J5_4v', '9594048605', '9/25/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('77051852z', 'tsanpher6d@behance.net', 'Tersina', 'Sanpher', 'jI9(x!i`sJOJ', '3851490387', '5/25/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('57610234t', 'phassall6e@seesaa.net', 'Philippe', 'Hassall', 'aH6$u*@aI', '6777478039', '6/14/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28385081f', 'mdunbar6f@theatlantic.com', 'Melicent', 'Dunbar', 'fB1,G=hy', '9438010435', '11/28/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03866684i', 'lstimson6g@aboutads.info', 'Latisha', 'Stimson', 'oY5(e&"K5', '9124199661', '4/20/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49389212y', 'trutherfoord6h@godaddy.com', 'Thom', 'Rutherfoord', 'sI2<_`?D', '9815425358', '8/9/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89787399l', 'fgarlee6i@china.com.cn', 'Federico', 'Garlee', 'jU0}W0J"(aF*1)m`', '1552037553', '6/22/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15399198x', 'agodsal6j@dedecms.com', 'Ailis', 'Godsal', 'bW7!_|#={J%M*', '2705474798', '1/17/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25661387f', 'earrighetti6k@shop-pro.jp', 'Elsey', 'Arrighetti', 'dF1>VBU(Q', '8728644427', '11/23/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49409435i', 'sgallehock6l@techcrunch.com', 'Sophey', 'Gallehock', 'dS2/("7b6sf8,', '9689622405', '3/7/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21906105e', 'dmaccollom6m@stumbleupon.com', 'Dacey', 'MacCollom', 'jE7,L<,|6Q', '2072366852', '7/28/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02745636i', 'jhemshall6n@cmu.edu', 'Jozef', 'Hemshall', 'nB0@#H)*Gp', '1214575094', '5/28/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('12120292b', 'nstollenbeck6o@salon.com', 'Nadeen', 'Stollenbeck', 'pD6~fd2p', '7256980183', '5/15/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('24481100m', 'spollastro6p@ucsd.edu', 'Shanda', 'Pollastro', 'mK4$8nUpZ''avkg4', '3127521938', '10/12/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28224956s', 'bgilluley6q@opensource.org', 'Brynna', 'Gilluley', 'aH4.|,ND<(0gl.', '2282779819', '12/29/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54281538h', 'fosirin6r@mapquest.com', 'Fidelia', 'O''Sirin', 'rF9}4=''Kq+v''L', '7558462668', '9/14/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70037923q', 'sreinbeck6s@google.com.au', 'Sholom', 'Reinbeck', 'fZ6%l2vKJzzzg2Ou', '3226603595', '9/3/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40446908f', 'weede6t@whitehouse.gov', 'Welch', 'Eede', 'eD0~yfwPr', '2899636211', '2/19/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27954857v', 'akedslie6u@cmu.edu', 'Abdul', 'Kedslie', 'kG9/CI1pA', '1727584395', '2/12/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67994970c', 'boven6v@unesco.org', 'Bailie', 'Oven', 'gS4(B_G6', '2635638092', '12/5/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('24292812v', 'hwackett6w@vimeo.com', 'Hailey', 'Wackett', 'vX5?>R1*', '4499774004', '5/17/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26660320c', 'aryam6x@time.com', 'Abbot', 'Ryam', 'dQ2%rZc>qNy', '1845636345', '6/26/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03031031s', 'rmousby6y@sun.com', 'Reggie', 'Mousby', 'aX2`j/itq', '7869898163', '11/22/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35486095p', 'cwhotton6z@nyu.edu', 'Christos', 'Whotton', 'qP1|E)&)y', '8924654115', '1/24/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98959495o', 'jnewgrosh70@cnbc.com', 'Jacky', 'Newgrosh', 'iD8,JfCsT5ech', '6979563736', '3/21/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10256658p', 'dfeather71@hexun.com', 'Demetria', 'Feather', 'wB1,P''qF6_', '3975103067', '10/18/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27914992e', 'srenehan72@epa.gov', 'Shena', 'Renehan', 'lS7`pO5)*', '8271630181', '11/23/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19624670v', 'abilfoot73@msn.com', 'Abagael', 'Bilfoot', 'sJ4%o`Ei!oNir', '8726994163', '10/9/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93399832f', 'jskarman74@google.fr', 'Janaya', 'Skarman', 'cR4=3h2FlU*,', '5857890550', '5/15/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33706945l', 'thebron75@spotify.com', 'Tiena', 'Hebron', 'cI3)l~gBI?oH)6q', '1092889762', '11/5/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('01620488z', 'epibworth76@xrea.com', 'Ermina', 'Pibworth', 'kG2\=\FC', '8138262465', '10/20/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56237787p', 'squarrie77@mediafire.com', 'Shawnee', 'Quarrie', 'hM9&9/wOR*`6', '2315850773', '10/28/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('11797950r', 'cpumfrett78@mysql.com', 'Catherin', 'Pumfrett', 'mH7<QJRY', '2863556373', '5/16/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('48719664s', 'aflag79@amazon.co.uk', 'Abbot', 'Flag', 'fR5(0mag', '6176129186', '8/29/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('83129100m', 'cdeyes7a@cnet.com', 'Cody', 'Deyes', 'mX5,=dW*h', '7243438106', '5/17/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69132313z', 'skineton7b@furl.net', 'Son', 'Kineton', 'uL5`o7/DFk6ByhBi', '6797948607', '11/29/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73349621s', 'bhorsewood7c@weibo.com', 'Boone', 'Horsewood', 'kV5%joo/6v@+h', '4658346844', '5/19/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21677833b', 'bcapoun7d@usgs.gov', 'Benyamin', 'Capoun', 'rA3<n(f+{', '1354205574', '6/20/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76121293n', 'iliversidge7e@illinois.edu', 'Inga', 'Liversidge', 'vN8`B8OzY2,Mw', '2073853946', '12/14/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('11267957o', 'klandell7f@arstechnica.com', 'Kaile', 'Landell', 'wW5&yL1v{<j!2a&%', '2671330996', '2/28/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03262177a', 'wwalenta7g@webeden.co.uk', 'Wendall', 'Walenta', 'aX5<J_2e)Re9', '2915584888', '9/15/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('74789209c', 'zruberry7h@ibm.com', 'Zea', 'Ruberry', 'zU7/bXL\@nU', '2368543492', '4/18/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15694872b', 'balastair7i@hostgator.com', 'Bar', 'Alastair', 'nB5?@lR#T3P6', '2734290760', '4/2/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('79295277v', 'nellgood7j@theatlantic.com', 'Nevil', 'Ellgood', 'uX4&#B`zp\*', '6736273918', '12/11/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41269075l', 'rkrug7k@nps.gov', 'Roland', 'Krug', 'jU3`a8Y~7f2Ep"', '3703466602', '2/12/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10307580x', 'kunwins7l@twitpic.com', 'Kev', 'Unwins', 'nM1|NwWs/cCy.|I', '5261563949', '5/31/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37563104b', 'rwarden7m@odnoklassniki.ru', 'Redd', 'Warden', 'nR8??GbG', '2742480353', '6/28/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86667446e', 'kpecht7n@hud.gov', 'Kiley', 'Pecht', 'xH0=Wd%5`J', '9777790685', '5/31/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16747448t', 'wwicklen7o@t.co', 'Wendall', 'Wicklen', 'qX2?hY<8', '4525363226', '9/27/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('71763167m', 'lduckinfield7p@google.com.br', 'Lloyd', 'Duckinfield', 'yZ8"0xq32', '8367199460', '6/27/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40123893f', 'dbouts7q@angelfire.com', 'Devan', 'Bouts', 'eG7(''C7&<''?y', '8733418756', '2/2/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33852080d', 'cmctavy7r@answers.com', 'Carolus', 'McTavy', 'uO9)6''abFQ6UUL', '6851236023', '3/4/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82705739j', 'ochamberlain7s@rakuten.co.jp', 'Omero', 'Chamberlain', 'iG2'',c5H*3"C)xaU', '2636697435', '9/30/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('48860982s', 'dfockes7t@hexun.com', 'Darrell', 'Fockes', 'eI6*"kv}(Kv5?7', '2163312014', '9/13/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21852335p', 'mbarrett7u@eventbrite.com', 'Martguerita', 'Barrett', 'eI5'',S6*|&|G<Y', '6039869097', '4/17/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67176298z', 'bgusney7v@studiopress.com', 'Beckie', 'Gusney', 'qA8"Cqpz8ESS', '7032408022', '7/25/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19811008t', 'bsmolan7w@washington.edu', 'Binny', 'Smolan', 'aK6/.PurA1L@6P', '1797173821', '2/4/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78242294q', 'mtrolley7x@networksolutions.com', 'Maryjane', 'Trolley', 'hI7!j~5=3y9@B0FH', '1034078263', '8/21/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('53279086h', 'lstitwell7y@mozilla.com', 'Licha', 'Stitwell', 'cR5''\6E*g''b#N', '6225290444', '10/6/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09218864r', 'mwillers7z@quantcast.com', 'Marrilee', 'Willers', 'wJ9),q#QIv', '2076069652', '11/18/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26786647b', 'mfransewich80@ezinearticles.com', 'Melosa', 'Fransewich', 'xH7"(hw`K=t', '9406676902', '11/25/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16761082z', 'cmillar81@pcworld.com', 'Claudetta', 'Millar', 'cK7{"h~MCcZ', '4334053437', '2/8/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40248219u', 'gbaldi82@bravesites.com', 'Gisela', 'Baldi', 'jB5+x/C\R4', '3981948410', '11/27/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('83422189x', 'ctyndall83@jigsy.com', 'Catie', 'Tyndall', 'fJ0>YtWuP', '6706554112', '8/19/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('92575911a', 'bsharrier84@google.ru', 'Barry', 'Sharrier', 'lV9>rT7oH''??', '5526347445', '7/11/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93992290k', 'mshadrach85@wikia.com', 'Michelina', 'Shadrach', 'dN6~?''\qWqd+,tz', '5099634151', '4/28/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('06425679r', 'mmcgeady86@themeforest.net', 'Merrie', 'McGeady', 'mV7#cT*Zw', '7748821073', '2/13/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('80273246z', 'yparkyn87@msu.edu', 'Yankee', 'Parkyn', 'tG1>5CbB#t>', '7782054067', '12/18/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51723730v', 'fthurling88@tinypic.com', 'Fidel', 'Thurling', 'uU3,>s|8KX2', '7448596970', '4/24/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('46179194f', 'halexandersson89@bluehost.com', 'Hillary', 'Alexandersson', 'sY9<XeZAJ!.D', '6092901464', '12/28/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88156090e', 'wlamble8a@tiny.cc', 'Wilt', 'Lamble', 'cP8{0vIpT', '6289591046', '9/25/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25528344p', 'ichatto8b@unesco.org', 'Ilene', 'Chatto', 'sA1&JZr)hoWK', '3098748416', '7/5/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('32214193l', 'nbullas8c@livejournal.com', 'Nonie', 'Bullas', 'zK8>2#EX2', '3325077942', '3/11/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45679438s', 'kyitzhak8d@imdb.com', 'Kaitlynn', 'Yitzhak', 'dI9%cGs6,', '7157515807', '2/23/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('11149983g', 'rknath8e@businesswire.com', 'Rianon', 'Knath', 'mT8#jL$u4', '8729673901', '2/15/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16199692y', 'opegden8f@buzzfeed.com', 'Ollie', 'Pegden', 'iT6?p''j.S6RUu', '4757648444', '2/6/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('85110046z', 'pbomfield8g@mlb.com', 'Patty', 'Bomfield', 'uW3>zaqaM''3', '1613481223', '2/19/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('62213368p', 'mturley8h@thetimes.co.uk', 'Mata', 'Turley', 'iX8#E%9@Kl', '8515153665', '12/23/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('79780866u', 'kesp8i@pbs.org', 'Kym', 'Esp', 'sQ2?`ZnHg', '8651240116', '2/23/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70536650u', 'egobel8j@sogou.com', 'Elwyn', 'Gobel', 'uQ2"s7JFU65@q6', '3048667217', '1/20/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('22240789v', 'rlandrean8k@cdc.gov', 'Robbie', 'Landrean', 'yT5''=EH$#%a6', '5118868724', '5/10/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94173520z', 'mlawty8l@linkedin.com', 'Myranda', 'Lawty', 'oH8?z,TH', '4521689553', '2/11/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82419988y', 'mdwyr8m@oaic.gov.au', 'Mickey', 'Dwyr', 'vL3$j@YkF&)!lj8', '5529551683', '1/15/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21388220w', 'vbelham8n@reuters.com', 'Vern', 'Belham', 'zR6.F@,y', '5307662563', '1/26/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('22953482i', 'whoult8o@odnoklassniki.ru', 'Wes', 'Hoult', 'bZ5?@@!ZbFH,', '3997422858', '2/15/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63003509x', 'kmarkwick8p@artisteer.com', 'Kimble', 'Markwick', 'iE6=}QxEN(E_@|dm', '3232807118', '6/3/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91096329n', 'treisenstein8q@opensource.org', 'Tisha', 'Reisenstein', 'hY9|HIz}t~', '7849255595', '5/27/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25571487d', 'cbromby8r@csmonitor.com', 'Cinda', 'Bromby', 'yI7#J~SBR4', '3193904562', '6/21/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52770797c', 'zthridgould8s@mtv.com', 'Zachary', 'Thridgould', 'pL7(Zw>Kxk9YmUQ''', '2798181749', '8/1/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('29537921l', 'jmclauchlin8t@ifeng.com', 'Jamesy', 'McLauchlin', 'bL1=>=}Zb<2', '6726870453', '5/24/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28321262u', 'ndroghan8u@wunderground.com', 'Neil', 'Droghan', 'dG9%cBgf<`', '8141470796', '5/25/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76850821e', 'psheere8v@usda.gov', 'Phaidra', 'Sheere', 'hU9}#$Vr()N_', '2182868900', '6/29/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63160158i', 'tmoden8w@hatena.ne.jp', 'Terrill', 'Moden', 'aE9}N*VSZKXO', '2317120070', '11/18/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10732990q', 'myeiles8x@usgs.gov', 'Marion', 'Yeiles', 'kM6{FPI=9G.', '7077787074', '6/29/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31763206r', 'wautie8y@newsvine.com', 'Walker', 'Autie', 'oH6{n$Un$e', '9351160366', '4/15/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('04275661o', 'mmackeogh8z@ycombinator.com', 'Michell', 'MacKeogh', 'hF8$yhRCwy)or', '8956579386', '4/30/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('20000721t', 'oburbudge90@behance.net', 'Orbadiah', 'Burbudge', 'rP3&N9AyXPs', '4098676643', '2/11/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('62478054y', 'sbladder91@photobucket.com', 'Sherri', 'Bladder', 'vC2#n8y!pwuF>52m', '1809007914', '12/24/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('39352793p', 'dcollinson92@google.co.uk', 'Datha', 'Collinson', 'tR1|dhXX{VC3tk', '5833165776', '8/27/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25284249g', 'scrayke93@hao123.com', 'Sallee', 'Crayke', 'kU5@zr7Tcv>', '4161427645', '1/12/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16160276y', 'sparffrey94@usatoday.com', 'Sibeal', 'Parffrey', 'hT5`AYDgEF.gq=', '2438087548', '8/11/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45394599h', 'dcatt95@yahoo.com', 'Dannie', 'Catt', 'dW9<a3p`tf', '7696284219', '11/24/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16931690l', 'jfeatenby96@quantcast.com', 'Jacynth', 'Featenby', 'dZ6/PiJP', '8192250978', '1/12/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('07541952e', 'lgildersleaves97@shutterfly.com', 'Linea', 'Gildersleaves', 'aZ7%bi/u', '6621639715', '1/21/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90245894x', 'cduggen98@marketwatch.com', 'Charlton', 'Duggen', 'tH1\MX8uio>4', '3937427418', '5/19/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('34625787e', 'bfugere99@qq.com', 'Baxter', 'Fugere', 'rB4(d5|F\L', '6162633741', '1/17/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('12537475r', 'cpenylton9a@delicious.com', 'Clyde', 'Penylton', 'hM5`$I4Gsty3u', '2055939500', '1/19/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('43397961x', 'nmoran9b@jugem.jp', 'Norrie', 'Moran', 'dR1|I{yN~}''', '5602442290', '12/18/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47389707k', 'calchin9c@japanpost.jp', 'Christi', 'Alchin', 'gN5<UTN*cx&x+,+0', '4098491670', '4/20/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67435572f', 'rschreiner9d@multiply.com', 'Remington', 'Schreiner', 'tW8!#@Tr6', '3186658953', '7/21/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('13934951b', 'pfilipov9e@biglobe.ne.jp', 'Pippy', 'Filipov', 'xT9''6o52GkMtT0sF', '7754908369', '11/29/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('04906997l', 'jbatho9f@fastcompany.com', 'Jedidiah', 'Batho', 'zN6_tMvTy`AHQ', '5658351670', '2/7/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87768988x', 'dpiola9g@indiatimes.com', 'Dal', 'Piola', 'hC3>''7>J\', '9977952302', '3/6/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('53761222n', 'rmcgraffin9h@xing.com', 'Rayner', 'McGraffin', 'bB7<''i%I~n', '9416174584', '6/30/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78948024a', 'cvolant9i@desdev.cn', 'Curcio', 'Volant', 'iW5{v#>5', '1139953245', '5/29/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73122242h', 'sjapp9j@census.gov', 'Shepherd', 'Japp', 'gI4@ogP8dhGm9p', '7895861054', '7/30/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91297515z', 'proom9k@shinystat.com', 'Pace', 'Room', 'eQ8\Y5anuI', '5302310376', '8/8/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33306194h', 'fgabbat9l@51.la', 'Floria', 'Gabbat', 'iS0_+wv65!A!m2|U', '1518255401', '4/18/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73833401d', 'grosas9m@icq.com', 'Guinna', 'Rosas', 'oQ2+zF%T', '1796245157', '12/10/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76405444p', 'hsimonnet9n@microsoft.com', 'Hall', 'Simonnet', 'vG6{EJ(2e$Mlls>4', '9753925695', '11/17/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66665034k', 'chubane9o@archive.org', 'Cammi', 'Hubane', 'rH4,S)feO>$9', '3586196606', '1/6/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('71967428m', 'bscanlon9p@taobao.com', 'Binnie', 'Scanlon', 'mB8@H"5`A', '1439252739', '12/22/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99452437v', 'jstrain9q@who.int', 'Jaimie', 'Strain', 'dW1=p(QUWn?bldE', '5929305275', '1/14/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86541368c', 'mklimontovich9r@uiuc.edu', 'Marcel', 'Klimontovich', 'cE3?})FO_"', '1122846358', '3/22/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('04081169a', 'mambrogini9s@ebay.com', 'Mason', 'Ambrogini', 'oC9>"uU}U}', '5918001550', '11/21/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31061144r', 'mnewall9t@webs.com', 'Malissia', 'Newall', 'nD4.`lg|VkcCn9<f', '6625789399', '4/26/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('14856313m', 'tdefty9u@vistaprint.com', 'Tabby', 'Defty', 'jV2$yV,kU/,', '3011595932', '12/9/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36239898y', 'pkruszelnicki9v@tinypic.com', 'Phaedra', 'Kruszelnicki', 'eY2$7r$fs+zOM', '7714287543', '3/27/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('61733237m', 'fvarndell9w@google.cn', 'Fonz', 'Varndell', 'aZ7_ZwB">&,m%m3}', '1134537620', '2/23/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('84423620z', 'efassman9x@amazon.de', 'Eduard', 'Fassman', 'fG3&CYw*>i_@Os4', '8009802543', '2/7/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('95103952w', 'wklaas9y@lulu.com', 'Waverly', 'Klaas', 'mZ0_/Bhhon4v', '1278208086', '4/30/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('11125340y', 'dkennerknecht9z@jimdo.com', 'Dalenna', 'Kennerknecht', 'eK1+We$z&', '2239981159', '6/6/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('85051460l', 'cdibdina0@archive.org', 'Courtnay', 'Dibdin', 'pG4"w>z''uFLjXe', '5053427560', '10/8/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('01259982l', 'gshieldona1@nature.com', 'Gabie', 'Shieldon', 'iY3&pjs@P', '7546483809', '11/24/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90598234f', 'vhurdidgea2@google.ru', 'Vittoria', 'Hurdidge', 'hU6~k{P_D.}Ni"@U', '2005147230', '12/31/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('79120042a', 'sberaneka3@live.com', 'Shelley', 'Beranek', 'tD1|jZ''>QcP<+Vl', '5058292363', '2/11/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36482936c', 'cmanifoulda4@google.de', 'Colette', 'Manifould', 'iD0+~&hUI<nI', '4474582663', '6/17/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('34241672l', 'mgaughana5@walmart.com', 'Matthew', 'Gaughan', 'fM1\Z09<9om~', '8285503039', '1/11/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28205808x', 'brobloua6@si.edu', 'Bernadene', 'Roblou', 'eH6+?JZc?b', '5696969788', '10/17/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23622972s', 'mkeela7@mail.ru', 'Minne', 'Keel', 'yQ1+BM>n*gd._0', '8401913688', '10/17/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86145452e', 'lplantea8@google.it', 'Lammond', 'Plante', 'nD9*%B_"S3/&ZlI', '1691050491', '5/26/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('14044306f', 'btamblyna9@smh.com.au', 'Brand', 'Tamblyn', 'lZ4(wWj7d''f', '8394482869', '9/11/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('68755394b', 'hdymickaa@exblog.jp', 'Henryetta', 'Dymick', 'uI9|pT(yi0g&4', '1158605654', '12/16/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('24193637b', 'dnussiiab@freewebs.com', 'Doe', 'Nussii', 'tY7`2l(V6ax', '5135866598', '1/10/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69375414s', 'hjellimanac@geocities.com', 'Hedwig', 'Jelliman', 'tD8$#95E/i{gZ(6', '6541919922', '6/8/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('24378861d', 'eabaziad@wisc.edu', 'Elwira', 'Abazi', 'iW0,x04|)>,(0&l_', '6865420387', '11/4/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64613127l', 'ptilerae@reddit.com', 'Pincus', 'Tiler', 'oF9&Xx4iWH`(0', '3864906825', '9/29/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('95750524f', 'spretoraf@slate.com', 'Syd', 'Pretor', 'tE5!fMdvr', '1624143100', '12/11/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('85755609y', 'snaishag@seattletimes.com', 'Sigismond', 'Naish', 'nS2''i=\1~@)/~', '2122472280', '5/6/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54802696t', 'rlakeah@hibu.com', 'Rosabella', 'Lake', 'kE3_Y_dQ,BAa7', '3804239284', '5/7/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02415889w', 'wfairai@smugmug.com', 'Way', 'Fair', 'lI9(B9)*TrTbA', '6884440991', '1/14/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('24312661u', 'npawsonaj@sun.com', 'Nickie', 'Pawson', 'wS0!P3(RA1Y', '3008398662', '10/7/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54146193x', 'gmarstonak@meetup.com', 'Glenn', 'Marston', 'eF5(<=815oN', '1833604767', '7/2/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41409656w', 'dcuffal@usnews.com', 'Dwayne', 'Cuff', 'vU4%%OC2', '7543048693', '5/19/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('58538596w', 'agergeram@comcast.net', 'Arlyne', 'Gerger', 'eL2?Uu=,Q9f9Mds{', '7453805777', '5/4/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90341094r', 'enurdinan@i2i.jp', 'Ezmeralda', 'Nurdin', 'wN9!vHwv31aAZ(', '4061743959', '8/10/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('57482011p', 'ppantlinao@prweb.com', 'Prudi', 'Pantlin', 'nU6&CRA$\|xKj', '2479239682', '7/10/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94268770b', 'agabalaap@skyrock.com', 'Ade', 'Gabala', 'aX1&*E*!', '4877716406', '12/14/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64179708k', 'jleeuwerinkaq@over-blog.com', 'Joete', 'Leeuwerink', 'iH5)I&av', '1947632251', '9/2/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63579764v', 'yschwandermannar@jalbum.net', 'Yorgos', 'Schwandermann', 'iC6%3`j9mEm`#GDR', '3893471296', '11/9/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('46013159d', 'hshasnanas@exblog.jp', 'Hildegaard', 'Shasnan', 'lY8"qBB5Fn1?erI', '6105688784', '1/18/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('20372342v', 'kboshersat@wikispaces.com', 'Kayley', 'Boshers', 'eX9<MG@c', '4807346268', '4/16/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94829448f', 'yingerfieldau@bbb.org', 'Yetty', 'Ingerfield', 'pQ3(`,_jt!7c', '7572679681', '12/10/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40403437l', 'sgiovannacciav@imgur.com', 'Sunny', 'Giovannacci', 'nD5@qav/6jg}A$', '6646346024', '3/30/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('71181410t', 'jmairaw@jiathis.com', 'Jack', 'Mair', 'dH6?&Xk@', '8608921066', '6/10/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55125771j', 'llearax@ibm.com', 'Luca', 'Lear', 'xV3%S~JIbVn|q', '2441331729', '12/16/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66254109o', 'everlanderay@youku.com', 'Emogene', 'Verlander', 'mM6*.MO47!r', '3281497921', '8/25/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35799185c', 'ssignoriaz@vistaprint.com', 'Storm', 'Signori', 'jR3+%h|Y7wXZ''', '5708494857', '4/17/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('22203528z', 'esoaperb0@cmu.edu', 'Euell', 'Soaper', 'yI6/q8UCvXA4', '9751302580', '6/13/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78255318p', 'pnairneb1@over-blog.com', 'Patrizio', 'Nairne', 'lY5|5EZj9}HHk', '5031298952', '1/1/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('07193741b', 'shellenb2@economist.com', 'Stern', 'Hellen', 'tY1(u1jLlLx7hK', '3451034088', '11/7/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('24513649q', 'mrankcomb3@themeforest.net', 'Meg', 'Rankcom', 'yU6!\_.KzkoF<bCr', '6609720846', '8/27/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('77065332c', 'ejaqueminetb4@latimes.com', 'Elspeth', 'Jaqueminet', 'dC8$P~JbEE=J_', '3189511920', '4/19/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('29998786i', 'izammittb5@vkontakte.ru', 'Ingrim', 'Zammitt', 'oP2!)eF~', '8212812333', '3/28/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64163285h', 'vfleyb6@google.it', 'Valina', 'Fley', 'pY4)F}1!?pX`E', '5691896238', '3/10/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('50434167h', 'chogbenb7@cafepress.com', 'Carroll', 'Hogben', 'mR2(fe&YK!UV_P', '9523068731', '1/29/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00959519u', 'hcamlinb8@wikipedia.org', 'Hyatt', 'Camlin', 'tE1)33KzX6S', '3497536043', '6/2/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08239757n', 'ddowzellb9@last.fm', 'Donica', 'Dowzell', 'oU3|OgjLsg', '6981634470', '6/20/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('17042263v', 'lledfordba@bbc.co.uk', 'Loise', 'Ledford', 'gS4/w>Gq22,@J7&', '5241899398', '2/2/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59822769q', 'mhullybb@latimes.com', 'Mack', 'Hully', 'kJ5&bkWq*XRgSp', '7904324680', '10/7/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16121901s', 'rinnettbc@ftc.gov', 'Roxane', 'Innett', 'lI7`{ht(XBX', '3344294806', '5/3/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('60653366u', 'gdixseebd@cnet.com', 'Gram', 'Dixsee', 'lP8&A!Nu#A''jt', '3779512174', '5/5/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('32085008o', 'pcheversbe@nba.com', 'Pattie', 'Chevers', 'xP7&a9m''k~%z*I@I', '9255959812', '10/25/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('12629022z', 'egravesbf@netvibes.com', 'Enrico', 'Graves', 'bW1!ls#0\AC', '9192340612', '6/1/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55176339r', 'cfreerbg@a8.net', 'Caty', 'Freer', 'bQ7{wW{S=', '4062408088', '11/28/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18515232d', 'bgreswellbh@xinhuanet.com', 'Buffy', 'Greswell', 'hF7?xOC=d,', '6448765372', '6/20/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('39949775x', 'sgaytherbi@alexa.com', 'Susannah', 'Gayther', 'hM4?N3HM8eL5+Qs3', '7193611576', '10/8/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96670741c', 'dlittlepagebj@cocolog-nifty.com', 'Dee dee', 'Littlepage', 'bP6,38)%z(', '3754210734', '12/7/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70817656t', 'bducebk@geocities.com', 'Berti', 'Duce', 'bS5?aYvWw{D%p+b', '3965145997', '1/5/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('92148597r', 'cpreonbl@businessinsider.com', 'Celina', 'Preon', 'uD6$nXD"q`g', '8276121292', '7/23/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56375829k', 'bmanuellobm@1688.com', 'Bernadine', 'Manuello', 'vS9+?z+9', '2314395482', '9/23/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91143903v', 'mbloisbn@rambler.ru', 'Marianna', 'Blois', 'oC1=!XO,!aYm', '1129094283', '7/31/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35509404h', 'cstreeterbo@macromedia.com', 'Chiquita', 'Streeter', 'cN1}{g=rSw|\''A}', '3869820827', '3/16/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('95825322r', 'cwhittierbp@nyu.edu', 'Celeste', 'Whittier', 'qH8>k_ug*Vr&', '3649386757', '3/14/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('34607728c', 'azecchettibq@go.com', 'Aleda', 'Zecchetti', 'mG6&<\fGOMsw', '8397414497', '10/15/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99503670c', 'omarflittbr@linkedin.com', 'Orelia', 'Marflitt', 'bX8"D`c!.9b', '5462728604', '9/3/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51728713f', 'aportmanbs@shutterfly.com', 'Andriette', 'Portman', 'vF2#Ru}Mdj\', '6075053186', '9/30/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03726217y', 'nrussilllbt@storify.com', 'Nalani', 'Russilll', 'vG4_KfXp,d6a\tT`', '6983409850', '8/17/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('97785836x', 'fhoweybu@blogspot.com', 'Far', 'Howey', 'pD0{d$6).CyQ|E!h', '2097479114', '1/18/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25873911y', 'rnickolsbv@usa.gov', 'Rianon', 'Nickols', 'bI0`>RHzZ', '9126351265', '11/5/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('48874367m', 'ngoddertsfbw@timesonline.co.uk', 'Natka', 'Goddert.sf', 'yK3_Nm2mlr5', '2838202698', '9/9/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96133799o', 'hinghambx@hao123.com', 'Helene', 'Ingham', 'nN0_&G<Y#rGSlhzn', '1819386609', '5/16/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('14076902p', 'alipscombby@wikipedia.org', 'Ahmad', 'Lipscomb', 'yM9=4%?>', '7156042746', '1/16/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('32594469h', 'mmangerbz@ameblo.jp', 'Melantha', 'Manger', 'kE2@gwfir5*WZ', '7609140631', '4/8/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98759427o', 'dgomerc0@hostgator.com', 'Demetris', 'Gomer', 'hR3~|3p*aT', '7862159989', '12/5/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('61245419j', 'dandrassyc1@paypal.com', 'Deck', 'Andrassy', 'aI0"X1%+|<5', '9319441333', '10/8/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('75314569l', 'gblunec2@cpanel.net', 'Georges', 'Blune', 'kM6{lHn))vC', '9497104063', '12/15/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('71192214g', 'rhawsc3@walmart.com', 'Randolph', 'Haws', 'mX6|}t95', '4088196699', '3/29/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35078998q', 'ajelksc4@loc.gov', 'Aubine', 'Jelks', 'nM5''/\`g', '7703594147', '11/24/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('58375348u', 'ksandeyc5@instagram.com', 'Klaus', 'Sandey', 'zP9=C2`$jflKPA@', '7363170606', '3/29/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49580954e', 'mmcgoldrickc6@upenn.edu', 'Montague', 'McGoldrick', 'kK7\0,a479%`kwS', '1065042369', '11/9/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10010358x', 'gfeatherstonhaughc7@e-recht24.de', 'Goddart', 'Featherstonhaugh', 'pC8{m5i9V8', '3093130311', '10/10/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40935657d', 'vralestonec8@nifty.com', 'Vlad', 'Ralestone', 'lC8)BPPa', '8509349262', '11/1/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86731787z', 'jsimenetc9@livejournal.com', 'Jolyn', 'Simenet', 'sX8(O_`>7', '9857811624', '3/5/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26746284t', 'cmulqueenyca@engadget.com', 'Caresse', 'Mulqueeny', 'dA3!!"Q5}ht?8j', '3363760962', '5/1/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67819829c', 'oovercb@ning.com', 'Olia', 'Over', 'aG6''`>XM%.3/&v', '9139085130', '7/21/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('92700420z', 'ddumphreyscc@instagram.com', 'Duffie', 'Dumphreys', 'uZ7}$o_U', '6596296952', '10/12/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87626949j', 'tbannestercd@sciencedirect.com', 'Towney', 'Bannester', 'hO6/1BMT*', '5752543915', '7/15/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('30119148z', 'hpykece@redcross.org', 'Hanson', 'Pyke', 'mP3{384by<2G', '5989236191', '4/25/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26517047c', 'klewndencf@mozilla.org', 'Kenon', 'Lewnden', 'lK3*0H1Ol', '9784961632', '8/11/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('06192013i', 'sdedantesiecg@moonfruit.com', 'Shena', 'De Dantesie', 'mP8=GVHI8', '7481920142', '1/29/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('43572566w', 'bstanlakech@uol.com.br', 'Buiron', 'Stanlake', 'sW3$X.lTf4sl', '8231143678', '2/22/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03609391f', 'barnowci@imgur.com', 'Barri', 'Arnow', 'xB9@m``@$', '4226462588', '9/19/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54346433u', 'lthextoncj@spotify.com', 'Lauretta', 'Thexton', 'wP1"a,>&*Y.(En$', '1152967236', '2/8/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('12708603b', 'dnorthbridgeck@oaic.gov.au', 'Dayna', 'Northbridge', 'xT8%MYmcd8%', '2609068392', '1/9/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98047129l', 'dgetleycl@google.it', 'D''arcy', 'Getley', 'cH2`1JV(', '2533678961', '11/3/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27433518t', 'pecclestoncm@vimeo.com', 'Phil', 'Eccleston', 'iZ8_''Jk{i?Thi9', '8831550998', '12/21/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('44145111o', 'jjossecn@4shared.com', 'Jade', 'Josse', 'oL2)3,7&W,/Es+', '4394338141', '1/15/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41552265n', 'yomullallyco@census.gov', 'Yolanthe', 'O''Mullally', 'vA8''>zoE)mjHSX', '1333907949', '6/27/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('20685980i', 'alukoviccp@networksolutions.com', 'Amalee', 'Lukovic', 'oB3*@b`$z&9`,ArD', '9534017481', '1/1/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31623545n', 'vonioncq@lycos.com', 'Vic', 'O''Nion', 'qO7<=(A''$3,jkBto', '7818991113', '5/22/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76116888c', 'mfrantzencr@digg.com', 'Myriam', 'Frantzen', 'eE4,%bbSxg9&YC(p', '5824788892', '3/8/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88083673h', 'pgilmartincs@skyrock.com', 'Pansie', 'Gilmartin', 'yP1_5lr/#J_m!J#G', '1481052308', '5/30/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09548901d', 'acommingsct@thetimes.co.uk', 'Alexandros', 'Commings', 'kA8>KuRyn6*OG', '6588343740', '7/2/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('46527713a', 'hpennuzzicu@t-online.de', 'Herold', 'Pennuzzi', 'yQ2*f3&pgLu$rN', '5678467056', '9/16/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('44678047n', 'aenockssoncv@shinystat.com', 'Althea', 'Enocksson', 'gO7_%@+U*n2y', '2102648768', '12/20/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55899027i', 'cromayncw@ed.gov', 'Cyndi', 'Romayn', 'iM6@y.nta"/)6J', '2992975760', '3/5/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67735432g', 'apetocx@ocn.ne.jp', 'Adrianna', 'Peto', 'rF3@+gT4zZ.z!', '8636789266', '6/10/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49410876t', 'gboulstridgecy@fema.gov', 'Gerrie', 'Boulstridge', 'qJ1{8WK''W}4av2', '4944508478', '9/22/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45699944h', 'hgillespiecz@seattletimes.com', 'Holli', 'Gillespie', 'oF7+*096{OB9tU~d', '3036130686', '1/24/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('01161303b', 'ccausleyd0@washington.edu', 'Cullin', 'Causley', 'rI8)Q~}gZ}`Kd`', '4457995925', '6/7/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('22379626r', 'jthiolierd1@cmu.edu', 'Janot', 'Thiolier', 'dX6?&==i.N9Dcht5', '4403297849', '7/18/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78959825z', 'hbrahmd2@youku.com', 'Harwell', 'Brahm', 'uA1\)Sm#a=c6?88n', '5414387298', '1/13/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('07896316q', 'abillesd3@patch.com', 'Aretha', 'Billes', 'tM4,,4+}mL2)+qE', '2619302420', '10/3/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35598490k', 'mbearfootd4@ft.com', 'Milissent', 'Bearfoot', 'eM7)GB`c"', '9669903311', '11/7/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73476685d', 'frabjohnsd5@cnet.com', 'Floria', 'Rabjohns', 'eZ6<7VD2ol', '8075572158', '4/30/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26742649l', 'aroaked6@salon.com', 'Aurea', 'Roake', 'mG2<0<GA', '6717680041', '2/11/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('14911779o', 'ewignalld7@bloglines.com', 'Elfrida', 'Wignall', 'wB0,b7kBi', '8021835400', '12/21/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52591042p', 'vgoodbanned8@mozilla.com', 'Vaughan', 'Goodbanne', 'wQ7*E6kuj7Z', '4119404833', '6/15/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('32657604i', 'mabbated9@usa.gov', 'Mufinella', 'Abbate', 'vT3!}Xas', '4614228650', '6/8/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('32714398a', 'sbutterfillda@mozilla.org', 'Stacie', 'Butterfill', 'iP7(l5MO|1Bh{', '6952554304', '5/26/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26025407c', 'lhattoedb@sciencedaily.com', 'Lezley', 'Hattoe', 'eB4*!MC?j', '8338711085', '1/8/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36700441a', 'erappoportdc@sphinn.com', 'Ernestine', 'Rappoport', 'oC8!x@\HkW"''DR+?', '2432918745', '11/26/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('38459065u', 'rrapseydd@sciencedirect.com', 'Rey', 'Rapsey', 'iQ7(&S1R#Pbg', '1865947547', '2/16/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('42336876q', 'kgibkede@about.com', 'Kellen', 'Gibke', 'xA5_>1Xl{''j<bZx', '4308414781', '12/7/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73685647j', 'qwashdf@mozilla.com', 'Quincy', 'Wash', 'zQ4(kP2Kwz#_M', '5471623350', '1/13/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90844433z', 'lcolbertdg@dot.gov', 'Laure', 'Colbert', 'pR6#wjE,h%{=`', '1533490592', '3/27/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('17296285r', 'kbushendh@oaic.gov.au', 'Kile', 'Bushen', 'lM7{Hl`f', '5955934867', '12/24/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55985386t', 'jtoffaninidi@nasa.gov', 'Jamison', 'Toffanini', 'eZ7*Dfa46NPy1c2', '7875083635', '9/18/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87963998e', 'gwoodruffedj@ask.com', 'Gaston', 'Woodruffe', 'xN1#jFjpSWD.', '7062698282', '1/16/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55962831k', 'canyondk@dmoz.org', 'Clim', 'Anyon', 'hN4<|#6PMCE82K(', '5764292608', '9/22/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94608104l', 'mreveningdl@pinterest.com', 'Merrili', 'Revening', 'pR2)4E%C8X', '7695721845', '4/25/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('12817105i', 'uclohiseydm@123-reg.co.uk', 'Ursula', 'Clohisey', 'jB8%iQ$b', '8385767646', '3/2/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19919431r', 'tbatistellidn@joomla.org', 'Tonye', 'Batistelli', 'mH7=,VGH`4Za,iN', '4324143388', '5/30/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19427275v', 'srolancedo@vistaprint.com', 'Sheelah', 'Rolance', 'xL6,9~9uw', '2523489754', '11/3/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10445717l', 'dtisondp@trellian.com', 'Demetris', 'Tison', 'qQ1)!`uja!c6', '8352572325', '12/7/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03322436q', 'cspeardq@yale.edu', 'Clevey', 'Spear', 'gM0~1V.u=&2=@i>.', '9458356605', '12/27/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('97494119f', 'cbouskilldr@goodreads.com', 'Cece', 'Bouskill', 'tV8\p''gc@on,/TW', '2384236927', '3/4/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28294167n', 'amilburneds@myspace.com', 'Alexis', 'Milburne', 'cC2?HL4>HM21WeU', '2005547341', '2/16/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52604476a', 'nlappindt@ustream.tv', 'Nancee', 'Lappin', 'kK3.Kg.DKJgai', '4199829130', '11/17/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82315030f', 'jdifranceshcidu@nydailynews.com', 'Jesselyn', 'Di Franceshci', 'rG6_>7p=$$RG6', '8901776507', '10/14/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82362670v', 'mkarpmanndv@sogou.com', 'Melinda', 'Karpmann', 'wI9+x5PYv', '9613418309', '8/11/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37583113u', 'achessordw@photobucket.com', 'Agosto', 'Chessor', 'qY1`+qQ+N', '2835868403', '11/11/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23856373i', 'ashealdx@wikispaces.com', 'Anatollo', 'Sheal', 'zD8{cU#1C', '6567928133', '1/21/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47112101q', 'tmessittdy@redcross.org', 'Timothea', 'Messitt', 'vY2?Sww{Imvq', '5866382451', '4/16/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45338745r', 'bpilbeamdz@ow.ly', 'Benjamin', 'Pilbeam', 'oI3"/N311%)&>&x', '5515271430', '5/4/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86321610y', 'msouzae0@hexun.com', 'Matthew', 'Souza', 'uJ2(Lnov$e=uFfb', '3055997837', '6/20/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18907989s', 'wchadwicke1@quantcast.com', 'Wilow', 'Chadwick', 'pL6!JW{h6o>', '8445872249', '11/24/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('85324607k', 'rcohne2@biglobe.ne.jp', 'Rosette', 'Cohn', 'iT0<P!>#dgH''0_{&', '9983621007', '11/14/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('14824172k', 'tskilbecke3@ucla.edu', 'Tabor', 'Skilbeck', 'qV1.w{F,stn\5', '3255455583', '4/10/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86622464r', 'mjobe4@nba.com', 'Mitchell', 'Job', 'dY8+{`JntrM', '4478507468', '9/5/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('07389396i', 'rswancotte5@illinois.edu', 'Randy', 'Swancott', 'cJ1~dx/nF|)D=', '2917452304', '1/19/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36457651x', 'ghagwoode6@biblegateway.com', 'Griz', 'Hagwood', 'vR8|LDha3vzz@r', '4058608572', '11/23/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27278722w', 'gumberse7@bandcamp.com', 'Gabrielle', 'Umbers', 'zL2''6s)Lp!pn', '2325100879', '3/15/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02214849o', 'uhoultone8@discovery.com', 'Umberto', 'Houlton', 'yN6''''$h=7P*U7', '7482300452', '11/27/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('34393075k', 'xquinete9@istockphoto.com', 'Xena', 'Quinet', 'lB4\jm3q7AoxWD', '2767758369', '3/2/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('65053916p', 'hgraddellea@slate.com', 'Hewe', 'Graddell', 'eC4%$!x}G<t*+h', '7848713486', '2/2/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55369556i', 'cgorellieb@so-net.ne.jp', 'Chane', 'Gorelli', 'hW6(f\%hCd#Gx@h,', '3502742486', '6/15/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('72569857e', 'sgarrisonec@answers.com', 'Sara', 'Garrison', 'nA3{4?64u', '8067839526', '10/22/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('77596932u', 'fkarpoved@house.gov', 'Frederic', 'Karpov', 'xE5&MvFs', '8079803648', '12/24/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('12276411u', 'relcyee@go.com', 'Rochell', 'Elcy', 'kF6\K/(D''j+H>J"', '7554985270', '7/15/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08272273z', 'iweatherhillef@ft.com', 'Isiahi', 'Weatherhill', 'bG3./D9t6AaDp0yW', '4622949815', '1/10/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56885054f', 'vvaudreyeg@dmoz.org', 'Veronike', 'Vaudrey', 'uF3!xvPYYLT)Jumb', '9846698792', '8/1/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40749094x', 'fgarthsideeh@sfgate.com', 'Farlee', 'Garthside', 'rF5$EOb$', '8087240064', '4/24/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56091967n', 'tbignallei@lulu.com', 'Toddy', 'Bignall', 'jS5$\!XhVd', '6853349400', '4/22/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35215545p', 'sdautryej@reverbnation.com', 'Stacy', 'Dautry', 'wH7~8xNQL', '7929102085', '6/21/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('32315112a', 'whaizeldenek@ft.com', 'Weber', 'Haizelden', 'vS0,}nG%RH<Y', '3706844639', '3/28/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99186967i', 'cworgeel@wix.com', 'Carla', 'Worge', 'mR6<"wqPylU\`Wx)', '1149365672', '8/14/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('68772332k', 'clevesleyem@psu.edu', 'Clemente', 'Levesley', 'rF5{*cRF%', '5829336530', '11/22/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59064246i', 'lgosticken@sitemeter.com', 'Lavinia', 'Gostick', 'nL3"w.VOpEEl!}rk', '7884831205', '1/24/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47570456u', 'cgallehawkeo@imageshack.us', 'Curran', 'Gallehawk', 'bW9#C91BVF', '5554000780', '12/16/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88415784n', 'acolleltonep@gravatar.com', 'Allie', 'Collelton', 'jK5''s_Bj', '4012109079', '7/8/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15665841v', 'jtippingeq@example.com', 'Justinn', 'Tipping', 'kJ9$4B*_', '7419618097', '4/12/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('92047284j', 'gbestaller@hp.com', 'Gert', 'Bestall', 'xJ4.=m)2Ev7RH', '2348838616', '8/30/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73950614p', 'jmckinleyes@google.pl', 'Jacquie', 'McKinley', 'dE8%V>L''fAZoJj', '4885558825', '11/13/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08110344q', 'acoitet@stanford.edu', 'Allistir', 'Coit', 'xY4)x69p2M`H/', '8564840150', '8/24/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93073226m', 'msouthertoneu@loc.gov', 'Madalyn', 'Southerton', 'zS7$LKFK#''m', '9023373937', '7/22/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27991737p', 'gwilloughleyev@mozilla.org', 'Gayle', 'Willoughley', 'zR2$w1WsK@C$?(', '4275709799', '4/23/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02849854d', 'rclougherew@cdc.gov', 'Rowland', 'Clougher', 'wL7''>3enflg#', '7154779261', '7/7/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31940817p', 'abettamex@quantcast.com', 'Anstice', 'Bettam', 'rC6#V_+B', '4084556440', '1/10/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('13778092g', 'ologhaney@apache.org', 'Obadiah', 'Loghan', 'jW4|Vlqb9eYt', '9214947418', '5/9/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26182571n', 'ashadboltez@yelp.com', 'Anders', 'Shadbolt', 'tG3"rZrWI8n', '8585069754', '7/13/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09473893p', 'pjosifovicf0@youtu.be', 'Paulie', 'Josifovic', 'fA1''@.0jH', '7538589795', '1/27/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15015415b', 'slitherlandf1@ox.ac.uk', 'Shaine', 'Litherland', 'aU6+G3=_OAtfHA', '6755089876', '1/7/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64451393h', 'nrojasf2@statcounter.com', 'Nero', 'Rojas', 'fM7?PW+Q', '7193304485', '2/15/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54847961a', 'nszymanowiczf3@g.co', 'Nat', 'Szymanowicz', 'lA0<74iPwj*!', '1967700081', '5/26/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('17552144m', 'cvigiettif4@webeden.co.uk', 'Cooper', 'Vigietti', 'yX4,u=>MXN&J(', '2361330795', '1/21/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33877419s', 'dhappsf5@exblog.jp', 'Dorie', 'Happs', 'aO2(ubvl{uqz+', '9881294672', '9/20/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63969999j', 'oetheridgef6@spiegel.de', 'Ollie', 'Etheridge', 'aA0!wtBwGJ+L>', '7681826876', '9/12/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94652368z', 'sjedraszczykf7@reference.com', 'Sibelle', 'Jedraszczyk', 'xB6&fx''H', '1126146014', '4/12/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19848329s', 'ngarattyf8@acquirethisname.com', 'Natassia', 'Garatty', 'bD9#.uffx=uwu0', '2413920310', '10/25/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49119133r', 'dbonusf9@dot.gov', 'Dusty', 'Bonus', 'uF3/No24E', '8979102696', '6/29/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('57167026z', 'tflukesfa@netlog.com', 'Teddy', 'Flukes', 'iO0!,R3et7', '9584467067', '4/5/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10413633b', 'mlongleyfb@boston.com', 'Magdalene', 'Longley', 'dH7=xPO>S', '8345084494', '5/16/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91454538z', 'aminesfc@people.com.cn', 'Abran', 'Mines', 'yB3`!E\{aIA<DJ', '3507802548', '7/3/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45335421l', 'vsheranfd@blog.com', 'Valry', 'Sheran', 'yQ8(j<IRLt', '2517525577', '1/14/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('53085972a', 'aetridgefe@bloomberg.com', 'Adriena', 'Etridge', 'wS2{C2"Fl01', '6992982554', '4/2/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33316024p', 'lfernff@loc.gov', 'Les', 'Fern', 'oV2@9S~uj{4XY>', '6167939986', '3/15/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67606326n', 'kbartelfg@webs.com', 'Kakalina', 'Bartel', 'oF0{.%22''', '2427306464', '6/25/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('34901176l', 'acorneljesfh@skype.com', 'Albertine', 'Corneljes', 'pO6+0?QDtYEr', '2745692137', '8/6/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('24338408o', 'bcourtesfi@lycos.com', 'Betti', 'Courtes', 'pO8/eK3XcUDjVpgy', '7066591858', '6/20/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73580753a', 'wrufflifj@marriott.com', 'Worthington', 'Ruffli', 'pH2{WU~B)c3L', '5417877609', '10/7/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('20860576f', 'dyurinfk@ebay.co.uk', 'Dimitri', 'Yurin', 'hW2+lruddKCg', '5803111209', '7/12/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('71421032j', 'hbazellfl@yahoo.com', 'Hazel', 'Bazell', 'dO3%pokGP,7))', '4897222339', '8/14/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63672691u', 'cgoudmanfm@github.com', 'Clarke', 'Goudman', 'iY6''Q{B.oh?', '4497473646', '3/4/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86474882e', 'gmivalfn@vkontakte.ru', 'Giselle', 'Mival', 'qD2,KiP6', '9813612278', '9/3/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54810201q', 'slamballfo@amazon.com', 'Shell', 'Lamball', 'cZ5!a?cV=nY#S', '2824352594', '7/28/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19808217t', 'aleathersfp@purevolume.com', 'Abigael', 'Leathers', 'mZ8}go)gpv', '3144393642', '10/12/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96216353e', 'tblaxallfq@studiopress.com', 'Tobiah', 'Blaxall', 'oN0''7PYbk&AQ', '8582639878', '4/5/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51334045p', 'ctonnerfr@foxnews.com', 'Cosimo', 'Tonner', 'yO7",}4F', '9111160300', '3/19/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82732949g', 'icanelasfs@google.com.hk', 'Ingmar', 'Canelas', 'eJ1%tHYC`!MQC*P', '2437335494', '8/1/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('95450884l', 'abutterfillft@blinklist.com', 'Alyss', 'Butterfill', 'jQ5+Vy"dk5gB', '8617616736', '2/14/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09339803a', 'lcarmofu@house.gov', 'Laird', 'Carmo', 'tO2"FJ.75D', '3975979476', '11/10/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89376196o', 'lnoddingsfv@nbcnews.com', 'Laryssa', 'Noddings', 'sR5''##lp{N', '8468490034', '12/22/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('12455097v', 'kyeskinfw@si.edu', 'Kathe', 'Yeskin', 'eT1(W0aWuAE', '1974862960', '10/24/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55918854l', 'ebenieshfx@gnu.org', 'Electra', 'Beniesh', 'aO0~Y+MejlErL#', '2913478101', '6/6/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('83328129t', 'cruzickafy@google.de', 'Charity', 'Ruzicka', 'jT6`s807', '2298061635', '7/14/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15740700p', 'bmincherfz@yellowbook.com', 'Beniamino', 'Mincher', 'sM2?D"mDhC}V', '3386346318', '10/16/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15259095x', 'iberresfordg0@nationalgeographic.com', 'Ilaire', 'Berresford', 'zX7@I96EKet)Bx', '1699778711', '2/5/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81971528u', 'aweeksg1@narod.ru', 'Aldrich', 'Weeks', 'wT4=kMzY', '2359147211', '5/2/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70776661y', 'cdiruggierog2@berkeley.edu', 'Clare', 'Di Ruggiero', 'yW4{e9k{', '1412029232', '4/25/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94090271h', 'cwaycottg3@elpais.com', 'Chevy', 'Waycott', 'aS4`''I}oN""', '1714506999', '7/6/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08870348l', 'tminshawg4@cnet.com', 'Terrijo', 'Minshaw', 'mC2\KoF)8Dlf*,', '1524020192', '1/21/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16098009m', 'tmercyg5@jimdo.com', 'Tiebout', 'Mercy', 'eP5)n.$~8,zP}', '2158777919', '11/8/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('04458574f', 'xcanog6@miibeian.gov.cn', 'Xymenes', 'Cano', 'yI4}qJMAH1uT', '8914210314', '4/5/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96300735q', 'mjacobsseng7@gravatar.com', 'Moina', 'Jacobssen', 'bW1*@%7I', '3377343047', '12/22/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19615793m', 'zsolang8@histats.com', 'Zonnya', 'Solan', 'sR7"#*%DcL\''@', '3756473086', '2/11/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('95361255k', 'aryleg9@unicef.org', 'Austin', 'Ryle', 'oQ8~''U<$4~', '7828402190', '8/25/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02200808q', 'dgravettga@csmonitor.com', 'Davidson', 'Gravett', 'vA5*QB{2Fs9iZtCR', '3518921995', '7/24/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45690584a', 'ptarbingb@vistaprint.com', 'Polly', 'Tarbin', 'vL6''uW2/k', '2713943389', '7/27/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36432484m', 'vcastletongc@netscape.com', 'Vassili', 'Castleton', 'nT9}R6VHeROlWY<', '8061967351', '9/26/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('44968199k', 'cdraggegd@github.io', 'Charline', 'Dragge', 'dV4/$NMSX', '7573655531', '7/1/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('77738034m', 'eopferge@domainmarket.com', 'Erv', 'Opfer', 'hT5*fq>L~', '5827748486', '11/4/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15613168i', 'hdanilewiczgf@shutterfly.com', 'Henryetta', 'Danilewicz', 'iG8.#0TT?<?n(H', '8259234014', '1/7/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87250772j', 'dharfletegg@hc360.com', 'Dorita', 'Harflete', 'pE7%D''?M/z', '1075283921', '10/31/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('57841180e', 'emodengh@topsy.com', 'Elmira', 'Moden', 'vS6!quIFAPdr@#},', '4458777457', '11/1/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('61719074h', 'ekintongi@infoseek.co.jp', 'Eran', 'Kinton', 'iN5)GM&{~X`9V5@F', '7532373813', '8/1/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88938219l', 'mtreleavengj@de.vu', 'Meggie', 'Treleaven', 'yA1~FM}qf6', '6382020762', '5/16/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55673720x', 'cmeadgk@addthis.com', 'Cyrille', 'Mead', 'pK8{\Z`tm+`5~gY', '1096277992', '12/24/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('67392695e', 'zwalpolegl@newyorker.com', 'Zollie', 'Walpole', 'qT2$QZ#1~Uw{V,5N', '9571843276', '5/22/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09241368i', 'rpauntongm@geocities.com', 'Ripley', 'Paunton', 'aU4=>dZq', '9401315874', '3/24/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('83817147x', 'akochelgn@google.de', 'Arni', 'Kochel', 'dI4(h&@LHo*m', '9503997509', '12/8/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('50142951r', 'devennettgo@loc.gov', 'Daryl', 'Evennett', 'cC8/h?094d,/', '4132560857', '11/16/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('38218846s', 'mupstongp@merriam-webster.com', 'Mitchell', 'Upston', 'hA8+z$J.OR7T\', '6532481148', '4/4/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28801857f', 'mkellertgq@1und1.de', 'Mycah', 'Kellert', 'bD7>UXc3b', '5848965574', '1/20/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('83744570o', 'bestickgr@twitpic.com', 'Bondy', 'Estick', 'yI1?@QsLx`', '2854495771', '5/6/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56384439i', 'lshillumgs@lycos.com', 'Lock', 'Shillum', 'gZ6**CMrq', '3193356545', '6/3/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33180443v', 'kboltwoodgt@soundcloud.com', 'Kipp', 'Boltwood', 'pC7&L,y/O<x', '6927537413', '11/20/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86745090h', 'rmilkehamgu@sbwire.com', 'Reed', 'Milkeham', 'rC0<Z=CK=}', '4258095722', '6/20/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('75253099z', 'mmccuegv@unicef.org', 'Montague', 'McCue', 'rN6!mVrL(0a#K', '7859967917', '12/22/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31464380z', 'glawtiegw@samsung.com', 'Grantley', 'Lawtie', 'hK4)SXLa', '4217318968', '5/10/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49464867k', 'cholbygx@naver.com', 'Colby', 'Holby', 'wA5=*.>xXkwy/n', '6496807164', '3/29/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88255181m', 'lglandergy@springer.com', 'Lin', 'Glander', 'bI7#),QE1cQ', '2267874393', '11/19/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55583015s', 'gfussiegz@reuters.com', 'Grover', 'Fussie', 'oO1@gl=iNQ*Y/A', '3303624373', '5/18/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89779657t', 'jfibbensh0@geocities.com', 'Jecho', 'Fibbens', 'hK8#JLEZ1R', '2008279683', '1/6/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51852862t', 'cblakeleyh1@wsj.com', 'Claudell', 'Blakeley', 'hU5''oj\2I', '3472880510', '12/15/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76821348d', 'vamyesh2@weebly.com', 'Valerye', 'Amyes', 'lT9{#(&b', '3591595435', '5/9/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31575585h', 'jmingush3@fastcompany.com', 'Johny', 'Mingus', 'fV7+/6J/', '4934498324', '12/17/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63369627s', 'rcardenosah4@dagondesign.com', 'Rosemarie', 'Cardenosa', 'rX2%b.Ml''', '6907591323', '10/1/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55675454u', 'hbarrh5@fc2.com', 'Helena', 'Barr', 'cN9/!0(~!3$i$e#+', '3176836939', '5/2/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36931229y', 'nlanslyh6@loc.gov', 'Neddy', 'Lansly', 'tG9''5lZJ~73iHkp0', '5093334240', '1/30/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55830998o', 'jdonoherh7@sourceforge.net', 'Jillene', 'Donoher', 'oL4=cXIn!UX0WG2f', '1768566647', '5/15/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78691532z', 'icristolh8@lycos.com', 'Ikey', 'Cristol', 'aP3/,#m=', '2264096622', '11/11/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('58505884v', 'mmoreinuh9@ucsd.edu', 'Marice', 'Moreinu', 'uB6{ty40=@FLp', '1996584706', '2/20/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98648830m', 'mrizzelloha@virginia.edu', 'Marlon', 'Rizzello', 'pB1!r}NZUNw4', '7564229242', '2/28/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16307752y', 'abatchellorhb@multiply.com', 'Aura', 'Batchellor', 'gE0{b7eDUmF~h', '4687811018', '6/3/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('53555540f', 'csavaryhc@mozilla.com', 'Cami', 'Savary', 'vV7@t$Whyh', '1603990581', '2/16/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('06606991z', 'gspurriorhd@alexa.com', 'Grove', 'Spurrior', 'eK7|CK7"iVY74I$', '5207403802', '7/20/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('22084123e', 'dlastehe@usatoday.com', 'Diane', 'Laste', 'zV7$\\MFx.+(', '8633523653', '10/26/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00185041d', 'hisenorhf@bing.com', 'Honor', 'Isenor', 'pK2/fubJ8za>)p', '5758198486', '10/22/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27793952n', 'acrowhg@joomla.org', 'Ann-marie', 'Crow', 'xM1?U''z3TBJ*YDf', '3298136252', '9/7/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('65870377i', 'tvardyhh@geocities.jp', 'Terrijo', 'Vardy', 'xH1_TA+l4"v}"v', '8176421201', '1/16/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96725646b', 'dmcalpinhi@va.gov', 'Dre', 'McAlpin', 'jF5`1&w@sw(Mkp', '3992567296', '12/29/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('53221293i', 'cstubbshj@umich.edu', 'Candra', 'Stubbs', 'oJ5<UL&Q', '6486026282', '10/24/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15360871j', 'ctowerhk@theatlantic.com', 'Carmine', 'Tower', 'mA0%m`~<N', '6657279953', '5/5/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00222653g', 'esaphirhl@narod.ru', 'Edmund', 'Saphir', 'bX1/8~3xs', '5982772861', '7/21/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('74603936q', 'bpriddlehm@mysql.com', 'Berty', 'Priddle', 'nQ3<1>Zjc', '6591684023', '5/31/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94039775s', 'dbrodeauhn@wikipedia.org', 'Dudley', 'Brodeau', 'oC4)vh|Tv&!0K`M', '7615504290', '7/23/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02905265z', 'lchinho@bandcamp.com', 'Laurette', 'Chin', 'sH9.s,)NX', '7872197099', '2/19/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('75479485m', 'wbethelhp@domainmarket.com', 'Willi', 'Bethel', 'iZ0}!UR3!~', '8103720981', '9/1/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47243736q', 'esweatlandhq@weather.com', 'Eolanda', 'Sweatland', 'nD8_par=d', '5555017349', '3/17/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33228346i', 'nohalleghanehr@globo.com', 'Neysa', 'O''Halleghane', 'sN3.c*cIKTm', '2906878741', '11/7/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28424617n', 'sgertyhs@barnesandnoble.com', 'Sammy', 'Gerty', 'zR9/rG~oc', '2951316685', '7/18/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86260396d', 'elelandeht@npr.org', 'Ewart', 'Lelande', 'bD8"2Gxhxmsd_$m', '3577675942', '8/30/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31140453q', 'wwyperhu@wp.com', 'Windham', 'Wyper', 'dV2{YrtHY{iY*SkT', '7906737511', '7/3/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09659163v', 'rcometsonhv@rambler.ru', 'Ruthann', 'Cometson', 'oN9%st#9{Zjh|5I`', '1283073612', '5/16/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26695796p', 'enappinhw@irs.gov', 'Eldin', 'Nappin', 'eT8.{`B!%YsXwSP', '3444468187', '3/6/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21501038m', 'afearehx@slideshare.net', 'Allina', 'Feare', 'gF0_u,?<>=Q|R', '5661881002', '9/26/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56922878v', 'crankinehy@networksolutions.com', 'Carleton', 'Rankine', 'xU6<\%UY$dpEDrob', '4866189719', '4/9/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('12973635v', 'ftrivetthz@webeden.co.uk', 'Fifi', 'Trivett', 'mR0&%`I_UyP?9', '9077275027', '9/24/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69774602z', 'apriggi0@webeden.co.uk', 'Agace', 'Prigg', 'tR8?@=Bf', '8224274699', '3/25/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99826057m', 'gmackartani1@shareasale.com', 'Gilbert', 'MacKartan', 'oY5%XL#AMw&~kP', '8377550725', '10/2/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31360396v', 'dmorratti2@sourceforge.net', 'Darda', 'Morratt', 'xC4%!OVIbe\EF', '4383822442', '3/23/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('72300195o', 'hcostei3@addtoany.com', 'Hernando', 'Coste', 'wY1#H$<#i', '5461057058', '8/1/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25314271z', 'lduchennei4@addtoany.com', 'Lolita', 'Duchenne', 'bO9''0SpeR,RxEj', '3683754493', '4/5/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('43394604s', 'gdigiacomettinoi5@stanford.edu', 'Georgia', 'Di Giacomettino', 'jP9\{l''Nu(', '5015537205', '9/19/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25899469y', 'mdilaweyi6@rakuten.co.jp', 'Malia', 'Dilawey', 'oG3)KEFS`', '2898603731', '9/9/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56756839n', 'parnkei7@weibo.com', 'Patricio', 'Arnke', 'wT7+kagu8J', '8479062724', '5/9/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('04465829u', 'mbartoseki8@amazon.co.uk', 'Meris', 'Bartosek', 'rH2%)~ee<', '3693660586', '7/15/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('85866070h', 'ngaythwaitei9@technorati.com', 'Nara', 'Gaythwaite', 'aU9}{vNYtDUe', '2823244417', '10/14/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86851876l', 'zpollastroneia@sogou.com', 'Zarla', 'Pollastrone', 'eY7%\}nE@4', '9986589077', '9/6/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('58180963l', 'kadlemib@msn.com', 'Koressa', 'Adlem', 'dM2{w*i+6/rhQX', '1511111536', '8/8/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('19122470b', 'alabusquiereic@artisteer.com', 'Archy', 'Labusquiere', 'rD4<b>n%<`{L!', '1233163165', '11/5/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('62454022m', 'rscrannageid@skype.com', 'Remy', 'Scrannage', 'xO5}%0tOmG%HSj!Z', '5772946299', '9/26/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96898833u', 'odommettie@liveinternet.ru', 'Orv', 'Dommett', 'jX9#Jjy_mY@_F', '1216995811', '2/28/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99568871c', 'vbettif@cdbaby.com', 'Vonny', 'Bett', 'tD6!OiZ5l', '4143858018', '7/16/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69415547q', 'ijeschnerig@yellowpages.com', 'Ingaberg', 'Jeschner', 'dB8"mE(%E`/R{z', '5599423932', '2/19/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('68993656t', 'lbradieih@godaddy.com', 'Lorin', 'Bradie', 'hE7%Bg5%E_EvtLw.', '4541884440', '1/8/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63242549j', 'cdrabbleii@naver.com', 'Cy', 'Drabble', 'gS1%}u(&P0', '6446668131', '9/18/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('84162696q', 'swisonij@foxnews.com', 'Scarface', 'Wison', 'wT9,n~$P)p=', '2597166486', '10/8/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09539422u', 'cabrehartik@netvibes.com', 'Celine', 'Abrehart', 'jS1?)7Ne', '8965580704', '8/9/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('50259787h', 'rkleinsmuntzil@angelfire.com', 'Rafi', 'Kleinsmuntz', 'vF8@u5"#6k', '4191679978', '10/5/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25054734g', 'msimukovim@themeforest.net', 'Matilde', 'Simukov', 'oR1$i|?u', '8705015623', '6/7/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09402832b', 'csanchesin@washington.edu', 'Cammie', 'Sanches', 'vJ3/Eb5S92xdO|G"', '8946695216', '4/25/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18086445s', 'ebiagiio@tinypic.com', 'Emylee', 'Biagi', 'yP1@w~`km~OqX', '1782282378', '3/13/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37883025s', 'cclaridgeip@desdev.cn', 'Carolus', 'Claridge', 'tE3`U3hh', '6886223945', '4/4/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36990365t', 'mdiantonioiq@fastcompany.com', 'Malynda', 'Di Antonio', 'mP3_<`SCla)4)l%', '3426110599', '11/20/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15205100h', 'hgonthierir@hatena.ne.jp', 'Hill', 'Gonthier', 'wW8`6m#ON*=o}J', '2953752092', '9/30/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56732269w', 'meddyis@fastcompany.com', 'Margaret', 'Eddy', 'lR4.''8SU+U@', '8985953122', '2/12/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('74749775k', 'cjurschit@uiuc.edu', 'Carol-jean', 'Jursch', 'tL6''th''c0v+', '3239888358', '6/6/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41219694c', 'speticaniu@github.io', 'Starlene', 'Petican', 'kG7?m,6T\', '6602297487', '5/31/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59669658m', 'ksydalliv@blogger.com', 'Kerby', 'Sydall', 'xS5?k=se/', '5089741486', '1/3/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('75842367c', 'hshapiraiw@army.mil', 'Hanny', 'Shapira', 'kY3@)#V1LESSb', '7476521077', '1/30/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27845677v', 'hrochfordix@dedecms.com', 'Hewie', 'Rochford', 'iI1<+X8hck', '4504901094', '12/23/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('68026747u', 'cwinchcombiy@aboutads.info', 'Corrianne', 'Winchcomb', 'tD4\+0f42?pW', '6375813417', '4/26/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36273937m', 'heakleiz@weebly.com', 'Haroun', 'Eakle', 'oC6}SenTuJF"%OnF', '7513851586', '9/27/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00721690x', 'hbretlandj0@privacy.gov.au', 'Hogan', 'Bretland', 'rM7%BR3Xv|Hehq*0', '4751783359', '7/24/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21161355s', 'nidwalevansj1@ed.gov', 'Niel', 'Idwal Evans', 'eJ0="f/5,Frt', '9866534861', '6/27/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70386143k', 'elettingtonj2@bbb.org', 'Ezechiel', 'Lettington', 'tS6<bop&~TU75\FM', '1414405150', '10/1/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18138399r', 'tmaycockj3@moonfruit.com', 'Trstram', 'Maycock', 'hK2''m@.`', '7009928817', '10/9/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36678409m', 'csibsonj4@com.com', 'Colas', 'Sibson', 'xV7<GB9">j&4y?&', '2434944100', '2/17/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40474328d', 'rnorvillj5@yellowpages.com', 'Rodolph', 'Norvill', 'lY0\6ujH`aCHN', '2734151534', '3/6/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91491016g', 'skingsworthj6@nasa.gov', 'Staffard', 'Kingsworth', 'mG4(P&/al=rE#', '2629121527', '4/10/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45245579p', 'dportmanj7@live.com', 'Dulcea', 'Portman', 'rU5<C`4m#x2E', '5334230542', '4/30/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('02903646o', 'ajakubowskyj8@ibm.com', 'Ashby', 'Jakubowsky', 'qH8_|PpIh&', '8388154139', '7/1/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86481183f', 'forcottj9@psu.edu', 'Florentia', 'Orcott', 'rW5.oA,fcGo', '2805688783', '11/10/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94928933v', 'asayeja@angelfire.com', 'Allin', 'Saye', 'jC8%_|sp|_W@NFe>', '8194797302', '9/22/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('95238381a', 'clunnyjb@weebly.com', 'Claiborn', 'Lunny', 'uJ3,ofw4v#2H{n', '9098293598', '1/26/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('53339908v', 'atomaskovjc@quantcast.com', 'Allx', 'Tomaskov', 'cA0%BL''{!S', '4299709910', '7/8/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('38733556e', 'sedbrookejd@eepurl.com', 'Smitty', 'Edbrooke', 'kE1.*z8Yi`A`/', '4945753497', '9/13/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96077516t', 'mklewije@skyrock.com', 'Man', 'Klewi', 'fD1$rA|YS', '8457441677', '4/9/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('77410826i', 'gthornsjf@flavors.me', 'Garrek', 'Thorns', 'uL8!xC."', '9789173249', '4/2/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03503571g', 'llowmanjg@wikimedia.org', 'Lemmy', 'Lowman', 'tU4@2a\3$Nv$E', '5613845044', '6/24/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00038754l', 'rarroljh@hatena.ne.jp', 'Ricardo', 'Arrol', 'yZ9''6_r)B+0q"', '5613657678', '8/18/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81582891v', 'tkleiserji@comcast.net', 'Teodoor', 'Kleiser', 'cQ7\PB(GPtNUkHe', '8181000394', '9/19/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93760765v', 'lmordantijj@scribd.com', 'Lisle', 'Mordanti', 'tT9''oMJ$jkEuoyX', '9046976817', '10/2/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('24537158s', 'daleshintsevjk@sina.com.cn', 'Deni', 'Aleshintsev', 'hJ4|UM\~H@L|3#s9', '3803723539', '5/7/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('30200334s', 'skrolakjl@earthlink.net', 'Saundra', 'Krolak', 'eR4~KN)Q2Ry', '4432588334', '10/25/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('13066522y', 'msibbonsjm@wordpress.com', 'Maurie', 'Sibbons', 'oU2~f{b4D&hpVu8', '2493601783', '11/20/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56042616y', 'aaluardjn@bluehost.com', 'Arlen', 'Aluard', 'wD9<yZv{b5', '1001638009', '8/21/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78038869s', 'sholworthjo@yelp.com', 'Shaine', 'Holworth', 'qJ2=X''uOjK6Yjf', '3172243278', '7/4/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00878979x', 'nrentallljp@hud.gov', 'Nikos', 'Rentalll', 'oA5_CCZn+O', '4774043560', '9/14/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91393944o', 'rbristonjq@epa.gov', 'Roanne', 'Briston', 'zB5"+p40Jixq,C', '4855206610', '5/1/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25334444l', 'hogilvyjr@state.tx.us', 'Herbert', 'Ogilvy', 'yO2,q!QJ', '4537707298', '10/31/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87712958i', 'bobrienjs@cisco.com', 'Blaine', 'O''Brien', 'oF6!COkN)e@F#', '4684155214', '8/2/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99424166i', 'mpomphreyjt@telegraph.co.uk', 'Mildred', 'Pomphrey', 'dU6{3qVbJXK!_7w', '3219643584', '6/20/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('34648953r', 'olightonju@hc360.com', 'Orelie', 'Lighton', 'rJ3.d{YH,''*@~xg<', '2877972103', '8/29/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33674474j', 'medsonjv@taobao.com', 'Martino', 'Edson', 'sQ6_)Qp{', '5293388858', '1/9/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('77842265m', 'gscoginjw@domainmarket.com', 'Giulietta', 'Scogin', 'bF3''sE$7m1+7?i\4', '2485530851', '3/15/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('22044234d', 'dbraithwaitejx@yahoo.com', 'Doy', 'Braithwaite', 'uO4~tqSO$', '1749711601', '5/12/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35673529a', 'gburgnejy@soup.io', 'Gordan', 'Burgne', 'qP2/<CYzUfG5<E4w', '3108767773', '2/20/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91526629w', 'sparkynsjz@mapy.cz', 'Sharyl', 'Parkyns', 'jZ5?dtCy@H', '8249906509', '4/30/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03133517q', 'bgangek0@sourceforge.net', 'Brnaby', 'Gange', 'pR2\?p)JqM<*oJ"', '9087896774', '10/3/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78403052i', 'laldridgek1@cnet.com', 'Lilian', 'Aldridge', 'eW9)y8ZA$', '5481575779', '11/16/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26058516s', 'slansdownk2@shareasale.com', 'Sandor', 'Lansdown', 'yM5''1fvg@UO,', '4162371768', '12/31/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('30599196l', 'ccowlardk3@freewebs.com', 'Constantia', 'Cowlard', 'xU7=9J}T(Z', '5564330970', '7/7/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25386654e', 'vablek4@ezinearticles.com', 'Vanda', 'Able', 'wL6=M5oUa', '2455134667', '4/28/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('11545574a', 'tmelatok5@chicagotribune.com', 'Tobit', 'Melato', 'dS0|(20o*', '1297760430', '1/25/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('10892138k', 'cterransk6@engadget.com', 'Clerissa', 'Terrans', 'pC2\~<#k?C>NTS{', '3275504432', '12/27/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('14595590e', 'edanfordk7@360.cn', 'Emmey', 'Danford', 'xQ2>frS8nfHt', '6114688985', '6/6/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35699504y', 'rkennaghk8@ehow.com', 'Rafferty', 'Kennagh', 'tT3$J&tlSRav5?J5', '3184637471', '3/19/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('50172573k', 'rderxk9@friendfeed.com', 'Rawley', 'Derx', 'xH7@EP>BK', '2517365027', '12/30/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('79180248p', 'mshynnka@mozilla.com', 'Margette', 'Shynn', 'wQ2>\.6C9S"t''', '1069936516', '2/15/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15407007c', 'ltorettakb@cnet.com', 'Lorne', 'Toretta', 'wW8*Qj0Sap|+', '2861101081', '2/24/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27103096y', 'agoscombkc@china.com.cn', 'Ardys', 'Goscomb', 'qC3|5*3A', '5765566366', '12/30/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15058737n', 'afrancesckd@youtube.com', 'Augie', 'Francesc', 'rJ5?%93TP''l/a%F', '1328806917', '8/26/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86261238j', 'alamerske@dyndns.org', 'Alec', 'Lamers', 'hV6??,6)ner', '8137806104', '1/3/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('77383539k', 'gkeepinkf@bing.com', 'Gale', 'Keepin', 'cM7%DGfiEqR%~Yi', '4048560073', '5/26/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('44688779o', 'ypicoppkg@un.org', 'Yancey', 'Picopp', 'nD4+kadC%#J/', '1663631224', '11/19/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('16255035t', 'llewishamkh@dagondesign.com', 'Lovell', 'Lewisham', 'mU6(''p6"!', '3395920846', '12/8/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('44719056f', 'ymcguireki@yellowpages.com', 'Yancey', 'McGuire', 'yG7+a=9x3z3&"', '4935497002', '4/1/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('50403952e', 'efrankiewiczkj@spotify.com', 'Ernst', 'Frankiewicz', 'iZ2>ie8>5vw|Tp', '6008770398', '6/6/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23058997b', 'msnellmankk@so-net.ne.jp', 'Marne', 'Snellman', 'mQ6!pPo&', '4648791668', '12/7/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90646865u', 'tmichielikl@dyndns.org', 'Tedda', 'Michieli', 'oQ1=sL|9!gQ', '3307170484', '7/26/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31786433h', 'mwotherspoonkm@examiner.com', 'Markus', 'Wotherspoon', 'qD4>ttoonPdd>P4_', '4946597666', '12/17/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25945110i', 'agorrykn@gizmodo.com', 'Avram', 'Gorry', 'zP1&s?BC', '1169473413', '12/20/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90907016o', 'hjimsonko@techcrunch.com', 'Hendrick', 'Jimson', 'lC2_EdbjKN2j5', '1972763598', '12/22/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56530034k', 'ahanscomkp@mozilla.com', 'Abe', 'Hanscom', 'uN9#|nWO''(8_', '2698679752', '2/8/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18345454a', 'vmenaultkq@ox.ac.uk', 'Vidovic', 'Menault', 'iT2>`o!xJzAA7O<', '5463535829', '3/28/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49881516i', 'rraggkr@statcounter.com', 'Rosana', 'Ragg', 'fO3_l#ZKl', '9605902921', '3/10/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99932954z', 'acharleyks@google.ru', 'Agace', 'Charley', 'oP8{Mq%ZxYQ=', '9552615493', '5/8/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81103639r', 'hbarratkt@cam.ac.uk', 'Husein', 'Barrat', 'oX7%U~rX<&DJ', '5366963433', '8/4/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64135659z', 'vglasspoolku@gmpg.org', 'Valaree', 'Glasspool', 'aH9+2eG9', '2344306271', '11/19/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59916603h', 'gpignykv@bloglines.com', 'Glenden', 'Pigny', 'sG7~1GjyL', '4129253666', '12/7/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66595224f', 'vshrevekw@google.com', 'Vere', 'Shreve', 'gX1,Fcfze~ldI`', '5784636468', '7/10/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('84934860t', 'ofurbankkx@mayoclinic.com', 'Oates', 'Furbank', 'wB7<Je/%', '4289856465', '9/14/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55964843u', 'bcribbinsky@photobucket.com', 'Belinda', 'Cribbins', 'pE1''8b"g8GL', '9705768054', '1/17/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94472058y', 'csandersonkz@slate.com', 'Conchita', 'Sanderson', 'lT0"~5''.9UQqL', '3142933585', '6/20/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18047754h', 'mjearyl0@adobe.com', 'Maxie', 'Jeary', 'uI4~fo0\', '1626081074', '7/6/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78972772c', 'pmcelweel1@feedburner.com', 'Paulette', 'McElwee', 'zV3!>z*d\e/8D|#p', '6668059938', '2/4/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('20978984x', 'escallanl2@eepurl.com', 'Eberto', 'Scallan', 'bL0<s@u?,Z', '6799448204', '9/22/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66379463p', 'mmaggioril3@oaic.gov.au', 'Matthus', 'Maggiori', 'nN6|S|8=,.', '2921884081', '12/12/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37151516k', 'gheaysmanl4@sogou.com', 'Gordie', 'Heaysman', 'jQ6.''fB''', '9749572662', '5/22/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93628043r', 'haloshikinl5@mozilla.org', 'Hinze', 'Aloshikin', 'dL2|GTZOle', '6365390024', '10/27/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35738343g', 'nskippl6@yahoo.co.jp', 'Natka', 'Skipp', 'wB5&{&!"Mpe$x', '2174678508', '1/18/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08101056k', 'saudryl7@comcast.net', 'Sargent', 'Audry', 'zX1|#V&puM()', '6481098081', '10/4/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69171540a', 'rbehninckl8@nature.com', 'Rosamund', 'Behninck', 'lF8/G0%1', '3192721431', '6/19/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31796665l', 'bmaudl9@state.gov', 'Bartolemo', 'Maud', 'vY0@3Xqt', '6518481891', '10/9/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35876311f', 'rleipnikla@omniture.com', 'Raf', 'Leipnik', 'aU7<|bT/gICL\Yy0', '6386358669', '8/27/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70205971p', 'prembrandtlb@wired.com', 'Pru', 'Rembrandt', 'yR1.m!tQN.vT5t', '3033820680', '6/6/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('77746095j', 'kcysonlc@simplemachines.org', 'Kary', 'Cyson', 'nO2&vj<*f3"ijd', '3355135846', '8/17/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33986361w', 'mschmuhlld@istockphoto.com', 'Mason', 'Schmuhl', 'tL5!`JO&y2=GO', '4262965885', '8/29/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55179287i', 'rwalworchele@bloglovin.com', 'Rhodie', 'Walworche', 'gZ6+>rnUILeuN55', '1585605363', '12/19/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76452670n', 'gcawthralf@marriott.com', 'Gusti', 'Cawthra', 'yS7`Z7c{%', '6002978849', '5/28/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('92441850h', 'jmcquirklg@hud.gov', 'Johan', 'McQuirk', 'uP6''v8hP+W', '7098231911', '4/19/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25827990p', 'kpowderhamlh@baidu.com', 'Kenny', 'Powderham', 'pE9}mn\K4VRV\Q', '7838666274', '12/14/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87036459a', 'mmatteauli@hatena.ne.jp', 'Modestine', 'Matteau', 'cQ8|2rLMjP5$Jog=', '7643710698', '10/15/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82325314b', 'nbalsomlj@upenn.edu', 'Nanon', 'Balsom', 'cQ3#/UR`B(', '8399098702', '12/26/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('74550178a', 'rjaggarlk@army.mil', 'Rois', 'Jaggar', 'pX8<~eO`90P0!c', '7348529490', '10/13/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('06987794q', 'nsteedenll@merriam-webster.com', 'Norry', 'Steeden', 'lY6{sz11t!Oi_', '9028266685', '8/6/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('65276595o', 'dbartotlm@chronoengine.com', 'Di', 'Bartot', 'eW5\3{%$|b(xOdrp', '9351898536', '2/12/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('42777334n', 'rfryerln@youtu.be', 'Robbie', 'Fryer', 'zL8_vR3XwDWpYN', '8306365159', '9/28/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08590830m', 'faddamslo@who.int', 'Francene', 'Addams', 'bB4&152O/Wd', '8894007052', '8/14/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64693259f', 'mbennittlp@admin.ch', 'Meier', 'Bennitt', 'kJ4~h~/uw09o', '7062445074', '12/30/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52507603t', 'cpothburylq@webmd.com', 'Claude', 'Pothbury', 'wY3$,6@,5', '6266506381', '5/7/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('74038231k', 'grosgenlr@archive.org', 'Grethel', 'Rosgen', 'rA3|5|Ze', '9523372831', '1/12/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18186381a', 'mmenloels@timesonline.co.uk', 'Marc', 'Menloe', 'vM3=48#RY_', '7381444026', '2/26/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('80862103g', 'kjoanniclt@scribd.com', 'Kasey', 'Joannic', 'bJ2"F{"nohAMS<h', '9938474599', '7/24/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('04911969r', 'hlohdelu@purevolume.com', 'Henka', 'Lohde', 'uN7#ZUU*L', '3983822581', '11/30/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('26737245c', 'dsmardonlv@furl.net', 'Dalston', 'Smardon', 'qH4#g9oZJQ_gVQ', '6887875826', '11/20/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35168110k', 'edranlw@histats.com', 'Evan', 'Dran', 'oD4''*upUNx%#', '1629857740', '4/28/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('11352984q', 'fseabertlx@berkeley.edu', 'Freemon', 'Seabert', 'qR7%W)L>@egE3c', '9636787943', '6/16/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('18537020t', 'moccleshawly@usda.gov', 'Marcellus', 'Occleshaw', 'mP0)/vtmS?X}W%*', '4043121148', '6/10/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('75009997w', 'hidendenlz@booking.com', 'Heidi', 'Idenden', 'jU1(8"1rUO', '9392593631', '9/15/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52528176w', 'edefrainem0@delicious.com', 'Earl', 'De Fraine', 'sW5&QT7cRdQ=a', '4893117862', '6/5/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('75847142g', 'lmolyneuxm1@indiatimes.com', 'Lane', 'Molyneux', 'fY8?P9_16H', '4374959328', '2/7/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78817027l', 'lgeorgelm2@buzzfeed.com', 'Luigi', 'Georgel', 'nQ9+jh9qBEWA%P''', '6715910116', '5/19/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27742696w', 'smapstonem3@google.com.hk', 'Samaria', 'Mapstone', 'iU5,1w+5!v<x', '4798921867', '2/14/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23693619t', 'bstarfordm4@yahoo.com', 'Brande', 'Starford', 'cJ1<mIbcI9}?P', '1474174142', '8/30/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('72869103y', 'kvannim5@odnoklassniki.ru', 'Kacey', 'Vanni', 'cF4{%=`<V2~k', '8297082163', '12/16/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51813997i', 'lwileym6@over-blog.com', 'Lil', 'Wiley', 'tR2}u.Bp', '8069750587', '12/27/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31170180u', 'mstelfaxm7@free.fr', 'Mamie', 'Stelfax', 'rJ8(tc6k(#>cL@', '4795340004', '6/14/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28562998z', 'ccamblinm8@miibeian.gov.cn', 'Carolan', 'Camblin', 'rY8_,L6RKw', '9449277644', '2/7/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('95305496o', 'clarticem9@nature.com', 'Colman', 'Lartice', 'sY6)xK?+~2<I3*', '2051460697', '3/30/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98751592p', 'jsiehardma@pcworld.com', 'Jefferson', 'Siehard', 'sQ4`x"!xs52', '2128017320', '1/17/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70415194f', 'cbessentmb@smh.com.au', 'Chancey', 'Bessent', 'eV1*Zb#VEa', '7802547404', '10/30/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('96213602z', 'sshortanmc@altervista.org', 'Samson', 'Shortan', 'cD7&AVC&FU~<=)TK', '4734959878', '1/31/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51634788f', 'mbarstowmd@infoseek.co.jp', 'Margaret', 'Barstow', 'tX6!@u#T/t\52', '8003632164', '11/14/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35474267l', 'lgodmarme@ezinearticles.com', 'Lizabeth', 'Godmar', 'oC6$=m1g1', '6025074515', '1/7/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89241234s', 'dbinksmf@geocities.com', 'Darb', 'Binks', 'tR5%GC3hNv', '3302975984', '8/21/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55563220k', 'cchaffmg@flavors.me', 'Cathryn', 'Chaff', 'xJ2%&5./OZd8K', '1892359493', '11/11/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('05037612j', 'ndukemh@usatoday.com', 'Nerita', 'Duke', 'oK6+n`Y&CL#sP"F', '3241843071', '5/30/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70657141j', 'mginnimi@feedburner.com', 'Maisie', 'Ginni', 'hE9/NP4R', '1196869765', '8/16/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41103332u', 'bedsermj@illinois.edu', 'Boone', 'Edser', 'jB0}DY>/>.)t', '9687885082', '9/11/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('61929330s', 'doverymk@wunderground.com', 'Devy', 'Overy', 'dL8{R.ua', '4025421098', '7/19/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87090000h', 'cswyndleyml@google.it', 'Corie', 'Swyndley', 'cG2/Hxk9"}&o~Xu=', '2125136273', '11/20/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('50638575u', 'jazemarmm@cnbc.com', 'Jeth', 'Azemar', 'vW2\cg~D3C9VSs', '3928649817', '9/20/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('05085828p', 'pyglesiamn@bizjournals.com', 'Pierrette', 'Yglesia', 'aC0\z3hTQ', '3317485157', '6/3/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93169219y', 'gyakobmo@amazon.co.uk', 'Gerick', 'Yakob', 'pH9>hM(hLY+', '7103799435', '11/27/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31611609b', 'bduchartmp@altervista.org', 'Bekki', 'Duchart', 'uU1+#IWD&S', '7709277353', '1/6/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87014303u', 'dmcgluemq@hud.gov', 'Dory', 'McGlue', 'oF1@&+_}2LMSVI1', '2733602602', '9/26/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52283564r', 'ccanasmr@technorati.com', 'Carolina', 'Canas', 'sC0&lziXwS2.Z', '3793375814', '3/21/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('17833412u', 'jdewesms@google.es', 'Jorgan', 'Dewes', 'sY9=a"t<j', '3997618185', '2/29/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31268390q', 'cjulienmt@bigcartel.com', 'Charity', 'Julien', 'vZ1"2b&zhvy*eek0', '9558869779', '12/23/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('39627032i', 'lmaccartairmu@imageshack.us', 'Lucia', 'MacCartair', 'gT4\YZ_zOg8Zm!D?', '5219153348', '10/24/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51988383h', 'mhaighmv@discuz.net', 'Myron', 'Haigh', 'nV2(''N0zo6', '1347469130', '4/11/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('22463555b', 'jarnoppmw@altervista.org', 'Judie', 'Arnopp', 'lT7|,,`+(y', '2559146975', '3/16/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('68560736h', 'arizzinimx@sohu.com', 'Ab', 'Rizzini', 'kA3,1ff=H1GB<V', '6116171979', '4/7/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52009970l', 'jshirrellmy@google.nl', 'Jaquelyn', 'Shirrell', 'vV7!Twe#aJXbg6NE', '3523007962', '10/20/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59458483d', 'bdixeymz@shutterfly.com', 'Boris', 'Dixey', 'gU7,z9''4M', '9667083367', '2/23/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23022924r', 'tholylandn0@mail.ru', 'Tera', 'Holyland', 'nY6@M''.t1&1@', '7119354757', '4/14/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94432835h', 'ewolvern1@ehow.com', 'Etty', 'Wolver', 'uC6+?MO''6~6w$', '2205607518', '2/14/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('79903022x', 'pfermoyn2@hhs.gov', 'Pen', 'Fermoy', 'oU2.+|NOa6', '4316625324', '10/9/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37588766q', 'aeltonn3@sina.com.cn', 'Anette', 'Elton', 'xS9\Uk7m8', '6454106919', '1/13/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78561555i', 'vhugnetn4@sourceforge.net', 'Vittorio', 'Hugnet', 'nB5|Ue=R)nb}', '8305966174', '11/13/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33105544u', 'dtonryn5@t-online.de', 'Davidde', 'Tonry', 'tN0+g0,9uz<ZLm{', '5634945290', '8/26/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('05736035c', 'ehainen6@deviantart.com', 'Erina', 'Haine', 'pH5!@a+U6DAn$', '1476886735', '5/14/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47382826n', 'lpinnijarn7@jimdo.com', 'Lloyd', 'Pinnijar', 'cM1#+.0DEc<', '6239880575', '1/20/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69858636m', 'vlefridgen8@nymag.com', 'Vincenz', 'Lefridge', 'gG9+l7#}SuA$', '7212637227', '11/19/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('36478976x', 'cfulgern9@joomla.org', 'Chickie', 'Fulger', 'bG5~vC_$@(G', '1126556646', '5/29/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('32261535i', 'brudledgena@mashable.com', 'Bennie', 'Rudledge', 'xZ0?G3>&c', '5072207364', '1/31/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('04011115e', 'omitronb@wsj.com', 'Odie', 'Mitro', 'hG4~=3W''@G&{\', '6468620833', '10/13/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86109034l', 'rtriggelnc@wordpress.org', 'Robb', 'Triggel', 'xY7*oE,A0Uf.<', '4864794792', '10/17/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87082651c', 'nbrogind@163.com', 'Nevins', 'Brogi', 'cJ9?RIm5YcC', '8246041108', '4/25/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88046398a', 'lmanharene@salon.com', 'Lorinda', 'Manhare', 'xK5"KJ9{2wW#4J', '1073010742', '6/5/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('52137254z', 'mraunnf@bbb.org', 'Madlin', 'Raun', 'fF4.G1"MhQIK', '4179778633', '7/1/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('31624264h', 'cdownageng@google.ca', 'Christian', 'Downage', 'fS3'')qp!xga1@', '7366905715', '9/18/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('48770400w', 'cluetkemeyersnh@gravatar.com', 'Chane', 'Luetkemeyers', 'lY8`sxlLdJ>)GJ$F', '6788721765', '1/13/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23418424f', 'ctutchellni@princeton.edu', 'Clarance', 'Tutchell', 'aG8}<0|=T', '8381222673', '1/2/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59100301d', 'hblanckleynj@domainmarket.com', 'Hyacinthie', 'Blanckley', 'xV5''U_pBm\', '9291172110', '12/19/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82638159h', 'hheissnk@jugem.jp', 'Husein', 'Heiss', 'tA0{z4akZnys', '3067381150', '1/3/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('80318964r', 'rjellybrandnl@kickstarter.com', 'Randi', 'Jellybrand', 'hL0=M)zEfnd5K,', '5345644199', '5/12/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('01651698x', 'spawelleknm@cbslocal.com', 'Selena', 'Pawellek', 'oF2>oJiy0M&', '7312540262', '6/22/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('17307761x', 'skohtlernn@devhub.com', 'Sandie', 'Kohtler', 'wA9/bEjrO', '2179066526', '9/22/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47286407g', 'afallowfieldno@marketwatch.com', 'Abbi', 'Fallowfield', 'aG7)*wE|qDQ*m4P', '1178847413', '3/24/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('30154999j', 'ldynenp@archive.org', 'Lynn', 'Dyne', 'eC0(%h8XMOY=Y?', '9241500182', '1/13/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('49609505t', 'ncorradinonq@360.cn', 'Nickey', 'Corradino', 'lJ6`#*a~TM', '8178118282', '4/8/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('34166607g', 'dwandrachnr@chron.com', 'Dugald', 'Wandrach', 'iQ5\,g)#''a', '4014122379', '4/26/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('61488735s', 'pmorriartyns@bluehost.com', 'Powell', 'Morriarty', 'bD0'')LNDnK)+8', '2718090446', '5/22/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76193545n', 'cpendrillnt@imageshack.us', 'Caresse', 'Pendrill', 'oV5{0zb1v@Ks|_SO', '3602616212', '5/5/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('07355269f', 'bjayesnu@time.com', 'Bondie', 'Jayes', 'mZ9(q+7f9q', '4562694541', '2/27/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99080252f', 'rmccartneynv@issuu.com', 'Rory', 'McCartney', 'bA7!a/o}~', '6639868513', '9/29/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('91481605n', 'hcrottaghnw@amazonaws.com', 'Harlene', 'Crottagh', 'yO6%lv"`Tu<kl', '9523381179', '4/23/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('87968970y', 'escullionnx@vinaora.com', 'Elbertina', 'Scullion', 'fV0>X5e\jEO*KF.', '8058690422', '10/30/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03845891p', 'npisculliny@livejournal.com', 'Neils', 'Pisculli', 'uV4}M?!SQSZyzGMw', '2033840430', '5/26/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88234802w', 'jcurtainnz@bloglines.com', 'Jesse', 'Curtain', 'pK4\&L17XH7%Y/|', '1665280503', '4/30/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03143839b', 'ebernardio0@pbs.org', 'Elberta', 'Bernardi', 'rA3,RO!z', '6444867786', '3/12/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('61535251x', 'bjoslino1@auda.org.au', 'Blayne', 'Joslin', 'jO4|9.s`B?PjmT.O', '1756610477', '7/16/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('13947462t', 'mseviouro2@liveinternet.ru', 'Milton', 'Seviour', 'wM0?vqN,''', '2434507408', '4/12/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('44669028u', 'ajovicevico3@cisco.com', 'Andros', 'Jovicevic', 'xU5./p~!{?fN<qj', '5915387612', '5/4/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78702253s', 'meilleso4@bizjournals.com', 'Myrta', 'Eilles', 'uD2)y@E)&', '4271004855', '1/18/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37338202g', 'dminkino5@berkeley.edu', 'Danni', 'Minkin', 'vP2(2|#gshU>te', '4448895979', '2/9/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('32035164r', 'tgoodyo6@statcounter.com', 'Thorn', 'Goody', 'nA6\BYUmNp}~*6>N', '3596775017', '10/7/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66521063z', 'lshingfieldo7@eepurl.com', 'Lelia', 'Shingfield', 'tS2!Mql$~b<x!xya', '8816390704', '7/8/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('27647119w', 'lestrellao8@cbslocal.com', 'Laryssa', 'Estrella', 'eZ1.}Y<`bFrm?', '3198132934', '1/31/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25520244l', 'vforcadeo9@google.com.au', 'Vonnie', 'Forcade', 'eI4$(h7?0|,3b+0Z', '1704937214', '7/2/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86425951k', 'candreassenoa@vk.com', 'Collette', 'Andreassen', 'kK4{9UXi11', '1183749122', '4/13/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21730519p', 'lbozierob@ucla.edu', 'Leighton', 'Bozier', 'cC7/1d`xczZZp{0t', '8284837925', '12/30/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76223445a', 'elathyoc@topsy.com', 'Elinore', 'Lathy', 'wL3(NZMI3y', '9173207399', '6/12/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('01904979v', 'tswepsonod@slideshare.net', 'Trstram', 'Swepson', 'yM0>+w{X', '4266198766', '1/2/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47998368s', 'cfochoe@psu.edu', 'Casey', 'Foch', 'xU9"vPYdS8~tQqL"', '5792575816', '11/26/1983', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('72500008s', 'glucasof@senate.gov', 'Giselbert', 'Lucas', 'wZ0(xGC%yml~g', '5823069061', '2/14/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('66000825h', 'kstowteog@xrea.com', 'Kira', 'Stowte', 'jH8>''rfVbz=', '5758924600', '8/16/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54978417f', 'blukasikoh@trellian.com', 'Beatriz', 'Lukasik', 'lT9''(9W2Wi75M', '3625724864', '3/10/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56788637z', 'kjeffordoi@skype.com', 'Killie', 'Jefford', 'cP6\~hFOW2ynS', '9307044429', '8/4/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86237904u', 'hbeebyoj@fema.gov', 'Hilary', 'Beeby', 'zQ4)?|.(>!t&8s', '8855958969', '2/22/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('59859104w', 'adavauxok@slashdot.org', 'Adoree', 'D''Avaux', 'wK6<Q_sf8', '5049414998', '10/23/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('38167844e', 'orodsonol@nymag.com', 'Oliviero', 'Rodson', 'bL2#txM.qJxLr{.7', '7474600971', '4/25/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('21811429y', 'tcreeboom@intel.com', 'Tommi', 'Creebo', 'oT8+La.!4|', '3827592378', '12/10/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15438203r', 'bhearneson@globo.com', 'Barnabe', 'Hearnes', 'vO7\R*8AuF`+.', '4828553104', '11/10/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('65449487r', 'mgoadbieoo@huffingtonpost.com', 'Malanie', 'Goadbie', 'gO2)E~vL&g3tufy', '1913225360', '4/26/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('08928989u', 'pdoleyop@dropbox.com', 'Pattie', 'Doley', 'lH3*)5V=osS_n', '3553897650', '1/30/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('37317308k', 'cskaceoq@stumbleupon.com', 'Ciro', 'Skace', 'yD8~Gta1X6U', '7728373208', '3/21/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70597035q', 'gfiloniereor@google.es', 'Gerrilee', 'Filoniere', 'nW9("W9rx=', '4735450309', '1/3/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('55211134d', 'spetyakovos@xrea.com', 'Sonny', 'Petyakov', 'sA6+(4"dAdW', '3271560031', '2/16/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('30062989i', 'rbrevetorot@networkadvertising.org', 'Ramon', 'Brevetor', 'dA3){8Fo?{o.\', '7502003864', '1/10/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('83739621o', 'smccuaigou@yale.edu', 'Sabrina', 'McCuaig', 'cK1=!AO|CXC', '1016071095', '4/9/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('43617642i', 'lskylettov@mac.com', 'Leoline', 'Skylett', 'zC0''rMO&hxPNk+R', '2047832856', '3/13/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('43915644a', 'seisenbergow@mlb.com', 'Sigfrid', 'Eisenberg', 'bS8}fZY#?,|`EkO', '6448481948', '1/11/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('29043383u', 'swestonox@google.nl', 'Somerset', 'Weston', 'dR7$=k"6', '4981980750', '5/6/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('78938679a', 'rcullerneoy@scientificamerican.com', 'Reidar', 'Cullerne', 'sB3){E2Q<YOu', '9034667866', '12/22/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('20302260q', 'csiddensoz@tinyurl.com', 'Carina', 'Siddens', 'sP6,n9`|g', '4529745029', '9/25/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('54426637u', 'eakkerp0@phoca.cz', 'Elyse', 'Akker', 'kW7%MH@!$Tn6W', '5966708600', '1/14/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('74447820m', 'tmcgauhyp1@t.co', 'Turner', 'McGauhy', 'cF7|.<"FA{', '8305905974', '9/3/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('60362909g', 'ktimminsp2@free.fr', 'Karoly', 'Timmins', 'nL7+eZ3qylOE', '9588345448', '1/10/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86167143p', 'kconiffp3@usnews.com', 'Kelsey', 'Coniff', 'lT4}b38&+Q@', '9782757152', '4/29/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('12289802v', 'otungatep4@who.int', 'Othella', 'Tungate', 'kB9\/7n''|gG0~', '3706395692', '9/16/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('29512201g', 'nbriggdalep5@noaa.gov', 'Nadeen', 'Briggdale', 'iF8@!h)!Gez', '2892685189', '7/16/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93515387x', 'bhinstridgep6@hibu.com', 'Boone', 'Hinstridge', 'kN0+MFgAiFS8nqM', '7668466298', '7/31/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('05407741k', 'ejerrardp7@flickr.com', 'Etta', 'Jerrard', 'hT9"h}ZtgJ&0', '8302871793', '10/12/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('01694691d', 'slethibridgep8@reddit.com', 'Susannah', 'Lethibridge', 'gP9=dddLixM', '4339727839', '11/7/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('44564282k', 'aremonp9@umich.edu', 'Allyson', 'Remon', 'kN0=zrLi05#\`Gk', '8151035762', '9/9/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86495685x', 'ralmanpa@a8.net', 'Reyna', 'Alman', 'nN0\5<8va+RN', '9879045227', '3/17/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98992745i', 'gjarrellpb@wikispaces.com', 'Gonzalo', 'Jarrell', 'gT3$1h@''jB,a', '7731634629', '2/16/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94812828y', 'dvanleijspc@privacy.gov.au', 'Deeyn', 'Van Leijs', 'hG8@3h''x''TMPeYm4', '1676033005', '9/15/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('30945290e', 'nandreixpd@biglobe.ne.jp', 'Nolana', 'Andreix', 'eI5%j,9V,dk(Mi', '7364887975', '12/31/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('84167627w', 'aaldhouspe@baidu.com', 'Arin', 'Aldhous', 'dV7/v|v*C5', '7502898909', '3/17/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('06261404a', 'agatrillpf@constantcontact.com', 'Alexei', 'Gatrill', 'zC6$U(wo1T`\Fg', '1931721018', '5/23/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56650116d', 'nivanilovpg@goodreads.com', 'Nichol', 'Ivanilov', 'mT4|7_~/fN', '6523863229', '9/18/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81603541p', 'lpirotph@squarespace.com', 'Lilllie', 'Pirot', 'hM5*~pDu', '1627601879', '5/16/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('44166782j', 'kwedgbrowpi@ifeng.com', 'Kalvin', 'Wedgbrow', 'tI3}pP\"', '7685556327', '7/4/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82975470r', 'rjurgensenpj@twitter.com', 'Redford', 'Jurgensen', 'lH2(}}Nv6</{', '5104586785', '11/14/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90395695w', 'fmccurtpk@umich.edu', 'Freida', 'McCurt', 'qV8\E0qLeq,m', '8402291446', '5/19/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76495349w', 'lhaughanpl@odnoklassniki.ru', 'Laurena', 'Haughan', 'mE3_TdA!1G`dl', '8685600828', '3/13/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('17587900f', 'kburgoinpm@usatoday.com', 'Keefer', 'Burgoin', 'xP6+=}wArw', '7643098012', '2/15/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('22047332y', 'hcronpn@addtoany.com', 'Ham', 'Cron', 'qX4,k.R=O5v%AbE', '9031878328', '3/17/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('17877962l', 'nattenboroughpo@spotify.com', 'Norris', 'Attenborough', 'oM2&enncJUDoo', '8955525684', '8/25/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23610893n', 'ejosefspp@pbs.org', 'Elbert', 'Josefs', 'rC9''|3rGwp#L', '8238963880', '4/24/1990', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('51133764k', 'tcardewpq@springer.com', 'Tracey', 'Cardew', 'rN5!lNKVLrY(Ox"g', '8884185803', '3/28/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('39628189k', 'adykepr@paginegialle.it', 'Ansell', 'Dyke', 'cA4@#f}!CSI', '8094455371', '2/4/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('42797711o', 'thafnerps@last.fm', 'Thor', 'Hafner', 'mO6%4_1%@zHNFQ', '2557346267', '10/15/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('86198198e', 'loatspt@phpbb.com', 'Lula', 'Oats', 'tW8+U"qM''cbB', '1284470619', '7/3/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45769018u', 'aechpu@un.org', 'Abbye', 'Ech', 'jP2.s#/W}pY', '5878487960', '12/28/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('79789455w', 'livashechkinpv@elegantthemes.com', 'Lucky', 'Ivashechkin', 'dW4/U''~e%', '8746809125', '3/7/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('94804491o', 'tcalverleypw@unblog.fr', 'Tibold', 'Calverley', 'tS5&Zm4wt', '8908905775', '3/16/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99146457f', 'ahexterpx@nsw.gov.au', 'Augie', 'Hexter', 'zK6%5si|v', '4139803409', '8/20/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('33477191c', 'jgoodlettpy@moonfruit.com', 'Jilly', 'Goodlett', 'hT0!C7VP#r7$<', '7197310019', '5/17/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03029247u', 'dneachellpz@google.cn', 'Dorri', 'Neachell', 'mI3<%!00Idi6', '4892771376', '3/8/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('15681573t', 'sfateleyq0@acquirethisname.com', 'Stanford', 'Fateley', 'sH0<Dil3(h+O!', '9032263180', '8/4/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('01388848v', 'jtreadwayq1@nydailynews.com', 'Jarrad', 'Treadway', 'zF7}"sm{qNPlh9+T', '9252045767', '7/3/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('00402082f', 'jfernihoughq2@cbslocal.com', 'Jasun', 'Fernihough', 'zC3)pwQ11M~CbL', '3095435339', '6/6/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('73611155u', 'gridgwayq3@lycos.com', 'Guthry', 'Ridgway', 'vC2$oA%Y~hHF|Q~', '1455474630', '5/19/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('34622860r', 'nserleq4@lulu.com', 'Nahum', 'Serle', 'fQ7(l52J', '7435946496', '4/26/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09336203o', 'mbochq5@angelfire.com', 'Milo', 'Boch', 'lP2`i)lvK7', '2905673412', '7/28/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('47967794y', 'gmacgaffeyq6@princeton.edu', 'Ginnie', 'MacGaffey', 'hF3+`\ChqnHG<o}', '9753029240', '10/31/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88493163o', 'ncaheyq7@deliciousdays.com', 'Natka', 'Cahey', 'jP9''bkdYrF<~UE', '7711267817', '4/22/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70414440o', 'karonsteinq8@weather.com', 'Katina', 'Aronstein', 'zB4(puT(', '8326310124', '3/19/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('80694705l', 'omallochq9@auda.org.au', 'Oby', 'Malloch', 'sO0,&lH02moq', '9474167646', '6/14/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('28249149q', 'eberstonqa@ft.com', 'Erin', 'Berston', 'gZ3*L`Rt{jC', '5635155359', '3/30/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56436895i', 'swheildonqb@senate.gov', 'Salem', 'Wheildon', 'dS2|<R!?#DRSVwY', '9444007776', '7/13/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('83458716b', 'eantoinetqc@amazon.com', 'Eddie', 'Antoinet', 'nC3~@8{ez', '9512930611', '2/22/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40888989m', 'oeglintonqd@virginia.edu', 'Orelle', 'Eglinton', 'tD5,BdGf,5Wrr6', '1255797720', '7/29/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('41182810h', 'pphilcockqe@ustream.tv', 'Penny', 'Philcock', 'jZ5=MF~3Z=', '1424887504', '1/19/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('45749891g', 'amcmanamanqf@nytimes.com', 'Ashlen', 'Mcmanaman', 'mV1>nAtN?vib', '8995754260', '3/25/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('85275032f', 'ballibonqg@amazon.co.uk', 'Bernie', 'Allibon', 'qW3{tM`T~', '5367331568', '11/15/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('25213280i', 'cdevonishqh@example.com', 'Cleopatra', 'Devonish', 'bK0"0z/h_1eW?86_', '4705557752', '7/20/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35266626o', 'tcokayneqi@admin.ch', 'Titus', 'Cokayne', 'fX4@l''H8+b', '4476403256', '6/10/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63928328u', 'celcocksqj@cocolog-nifty.com', 'Coleman', 'Elcocks', 'mR6%t)c3H8Q"u,,', '6172588398', '5/16/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76510760i', 'jimlachqk@wsj.com', 'Janey', 'Imlach', 'dI9!)1v\a7,(P5}.', '2051796940', '2/8/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98877926w', 'thawfordql@adobe.com', 'Timothea', 'Hawford', 'pM6){Op<Iw3', '9439314933', '12/13/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('29716496a', 'imacalroyqm@nydailynews.com', 'Isidor', 'MacAlroy', 'qC0@+U.i', '3216211437', '4/28/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('75433370a', 'kchalliceqn@dot.gov', 'Kanya', 'Challice', 'bW5@,r}HL|>ge_Q', '4111388455', '4/13/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('84837195c', 'ctieqo@mit.edu', 'Claiborne', 'Tie', 'iF4!BKD4E{)cvp6p', '7128236980', '9/1/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('76769650k', 'afretwellqp@baidu.com', 'Addison', 'Fretwell', 'vP2+iSvTr', '2065163699', '4/29/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('90962543f', 'iyedallqq@usatoday.com', 'Irvine', 'Yedall', 'fK6,&7GYbTSZ"\*', '5214766718', '4/15/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('72469606a', 'msabbinqr@dagondesign.com', 'Manon', 'Sabbin', 'yZ2}cC0DwE<U', '2721584209', '5/18/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('40387391x', 'rsennerqs@youtu.be', 'Renato', 'Senner', 'bQ8@YJ6mnN<', '6947151609', '3/3/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98339683e', 'kkunzelmannqt@oakley.com', 'Kameko', 'Kunzelmann', 'sU3*=,hfiQvc"Y84', '5687510595', '1/23/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93592169b', 'darnefieldqu@amazon.co.uk', 'Dolorita', 'Arnefield', 'lN4$U\J.', '7122077726', '2/3/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('56224065u', 'fvenourqv@facebook.com', 'Faith', 'Venour', 'sF6(<F0j/vnC}O', '2369357028', '11/4/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('72379232e', 'ahammermanqw@timesonline.co.uk', 'Alvy', 'Hammerman', 'qX0!?+Iax', '2206966304', '11/5/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('98215524c', 'lkimblyqx@cnbc.com', 'Leanor', 'Kimbly', 'mL8.6WFT=', '3439080009', '5/23/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('13378450a', 'ksmaileqy@cafepress.com', 'Kenn', 'Smaile', 'qR2#+l|g6e6CCZ', '8597266812', '10/23/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('84081397i', 'bthaxtonqz@quantcast.com', 'Blane', 'Thaxton', 'oK2<(Zsi', '9404812100', '12/9/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('14791261s', 'kcammidger0@hibu.com', 'Kathleen', 'Cammidge', 'vE1*PXi)', '1649424334', '6/26/1991', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('92545600u', 'dsibyllar1@vimeo.com', 'Dasi', 'Sibylla', 'yL4,''$|/(.{', '5657906128', '1/24/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81917487i', 'mpearr2@salon.com', 'Matilde', 'Pear', 'iP4"aG@1W="3xA1', '9986932980', '3/20/2003', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('09106859o', 'epowisr3@rediff.com', 'Elsinore', 'Powis', 'cO6}="H|3xn>lPLN', '9563741897', '12/7/1997', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('97231223e', 'arabierr4@gravatar.com', 'Adler', 'Rabier', 'tS2#5BGc{b"', '6085079190', '1/9/1986', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('22660142i', 'kbootherstoner5@tinypic.com', 'Kaiser', 'Bootherstone', 'yE4''{bIfm', '6173574690', '8/18/1988', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63220801m', 'fmctrustramr6@cnn.com', 'Flynn', 'McTrustram', 'zV5#Cj=u>e', '8014542846', '3/3/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89301599u', 'awimmsr7@usgs.gov', 'Alanson', 'Wimms', 'tD4.N!dqne<9', '7269559300', '12/7/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('81170124o', 'showlesr8@wikipedia.org', 'Stanfield', 'Howles', 'cC8!5ql0u', '5283264986', '1/8/2000', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89857118y', 'mkoppelmannr9@acquirethisname.com', 'Melodie', 'Koppelmann', 'aH2`E4GS', '9903387762', '1/30/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('70028769r', 'snurnyra@tumblr.com', 'Shelden', 'Nurny', 'dL9,`f`Hj8uKTkI', '1188148298', '9/19/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('99201149z', 'lbrownsworthrb@posterous.com', 'Lonnie', 'Brownsworth', 'sY2+=L%()fY|yT#o', '6767498227', '7/19/1985', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('89751896u', 'mchancerc@google.com', 'Mal', 'Chance', 'qS4|&J@RTaw#eUjf', '8611674540', '11/15/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('63312752w', 'tcredlandrd@wiley.com', 'Traci', 'Credland', 'xR1`>Um*&Tu`', '4286194761', '5/31/1984', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('93402697x', 'jclixbyre@yahoo.co.jp', 'Jamima', 'Clixby', 'gU8))Ku,q', '7115501065', '5/28/1995', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('82068898d', 'lboscherf@elegantthemes.com', 'Leanna', 'Bosche', 'pQ2{W?6HeCc3#/s', '7109508775', '1/11/1992', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('75551191e', 'cbawcockrg@accuweather.com', 'Cissiee', 'Bawcock', 'eO6)XR"wqV7`~i_T', '1276461555', '7/2/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('29135169b', 'mghestrh@comsenz.com', 'Mariann', 'Ghest', 'iQ2<w?''UtR0*k>ss', '1446066820', '3/11/1999', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('06585471u', 'mteesdaleri@virginia.edu', 'Mohandas', 'Teesdale', 'kG1$skYh`!#z', '5641919995', '12/6/1998', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('04784074u', 'vbiasettirj@admin.ch', 'Vernon', 'Biasetti', 'uF7%k,x!x2', '9967376489', '4/9/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('06239920j', 'lbrislawnrk@bandcamp.com', 'Liane', 'Brislawn', 'pK0%mU#"82<)C', '9613892622', '1/29/1989', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('35774571i', 'aneelyrl@google.it', 'Abran', 'Neely', 'zO3/z,64', '4239542855', '3/12/2001', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('23812033o', 'otrahmelrm@utexas.edu', 'Oralie', 'Trahmel', 'tL3$3?9e!ApN0', '8412151260', '8/24/1994', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('88495095n', 'eskeetern@shop-pro.jp', 'Emory', 'Skeete', 'lH6_V9NsozWV_0', '9671409145', '4/19/2002', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('69699671s', 'fgerardotro@nasa.gov', 'Fran', 'Gerardot', 'pU2?p)*JR8ySadq', '6933329419', '2/3/1987', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('58360718f', 'hmattenrp@adobe.com', 'Hildy', 'Matten', 'eN3$HQmt}"jbkzY/', '4417349897', '8/19/1993', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('03987813p', 'wkirwoodrq@disqus.com', 'Wally', 'Kirwood', 'mY3@>.1Ki"}', '3388146258', '8/25/1996', '0');
insert into Usuario (dni, email, nombre, apellidos, contrasena, telefono, fecha_nac, admin) values ('64940584a', 'rpendletonrr@mapy.cz', 'Rory', 'Pendleton', 'hN9@4!i_YE%V', '9183892357', '9/18/1998', '0');





insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('0 Pond Road', '65960', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('4822 Macpherson Place', '61109', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('41 Eastlawn Pass', '07658', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('241 Roxbury Terrace', '56116', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('56736 Blackbird Alley', '61716', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('2216 Jana Road', '15940', null, 'Galicia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('56 Northview Way', '71988', 'Jaen', 'Andalucia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('1719 Lawn Crossing', '35738', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('5 Farragut Court', '35240', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('895 Bartelt Trail', '67349', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('60 Utah Alley', '67969', 'Dos Hermanas', null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('8 Grim Pass', '28676', null, 'Andalucia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('6 Westport Center', '51099', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('2938 Sullivan Alley', '62594', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('1 Rieder Pass', '71246', null, 'Andalucia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('4753 Manitowish Crossing', '28689', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('43905 Nancy Plaza', '04332', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('64 Alpine Road', '46078', 'Vigo', null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('163 Oxford Lane', '42877', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('6603 Linden Circle', '94576', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('111 Rigney Plaza', '20747', 'Santiago De Compostela', null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('61 Lawn Hill', '32904', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('3 Crest Line Road', '82498', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('9 Sachs Point', '76552', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('449 Helena Lane', '09247', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('6419 Artisan Terrace', '13432', null, 'Galicia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('12 Westend Crossing', '58793', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('144 Burning Wood Circle', '45869', 'Ferrol', 'Galicia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('11 Helena Circle', '88225', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('49 Maple Trail', '49497', null, 'Andalucia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('1643 Del Sol Way', '41688', null, 'Andalucia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('9 Steensland Parkway', '29082', 'Ourense', 'Galicia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('19829 Mallory Lane', '50204', 'Lugo', null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('98187 Fallview Road', '16395', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('8796 Welch Parkway', '44667', null, 'Andalucia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('189 Brown Street', '18092', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('5 Sauthoff Way', '47157', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('7718 Fairview Circle', '07032', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('51 Tony Pass', '58838', 'Granada', 'Andalucia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('09422 Bayside Street', '06159', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('7920 Brown Point', '93114', 'Vigo', 'Galicia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('6 Green Hill', '46231', null, 'Galicia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('03 Grim Road', '76752', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('178 4th Point', '68719', 'Lugo', null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('64 Portage Terrace', '01951', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('62 Stone Corner Alley', '74995', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('42 Grim Center', '92741', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('233 Pond Junction', '59695', null, 'Andalucia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('94910 Hazelcrest Parkway', '47510', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('8 Cordelia Hill', '95401', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('525 Sutherland Park', '96256', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('492 La Follette Hill', '55219', null, 'Galicia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('3431 Barby Road', '97288', 'Pontevedra', 'Galicia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('199 Badeau Crossing', '75472', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('726 Autumn Leaf Place', '80288', null, 'Galicia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('9 Dapin Lane', '26044', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('541 Mcguire Street', '59326', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('9988 Barby Point', '86100', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('31131 Aberg Circle', '60687', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('458 Donald Court', '61801', 'Santiago De Compostela', null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('9 Toban Avenue', '94893', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('4 Northfield Center', '88127', 'Cadiz', null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('7660 Bluejay Avenue', '56336', null, 'Andalucia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('395 Jay Junction', '43317', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('8403 Carberry Trail', '14650', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('94695 Holy Cross Street', '05684', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('52 Pond Center', '45366', null, 'Galicia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('60 Portage Drive', '66249', null, 'Galicia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('66502 Colorado Park', '98800', null, 'Galicia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('5450 Basil Way', '05241', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('33 Melrose Pass', '51354', 'Sevilla', 'Andalucia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('6672 Onsgard Point', '44590', null, 'Galicia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('3914 Wayridge Point', '14511', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('517 Lien Road', '04897', null, 'Andalucia', null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('6 Buhler Point', '15877', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('578 Daystar Point', '33789', 'Santiago De Compostela', null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('280 Del Sol Trail', '89344', 'Pontevedra', null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('283 Kingsford Plaza', '04862', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('23392 Memorial Trail', '46147', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('8 Elka Lane', '76000', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('168 Springview Drive', '33822', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('11 Magdeline Terrace', '34007', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('3 Stone Corner Hill', '07508', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('1 Melody Way', '04838', null, 'Andalucia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('1101 Gateway Junction', '84232', 'Dos Hermanas', null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('2227 Miller Road', '41417', 'Jaen', 'Andalucia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('257 Lyons Parkway', '73593', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('97 Nova Road', '34944', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('328 Hazelcrest Trail', '25990', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('24823 Jay Trail', '65132', null, 'Andalucia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('26737 Scoville Lane', '26068', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('10215 Killdeer Avenue', '25304', null, null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('17727 Schlimgen Avenue', '58686', 'Jaen', null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('2 Bultman Alley', '78422', null, 'Andalucia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('9 Morning Hill', '95325', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('03939 Roth Crossing', '23312', null, 'Galicia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('406 Algoma Point', '52323', null, null, null);
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('44680 Tony Road', '14135', null, 'Galicia', 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('44778 Forest Court', '97129', 'Vigo', null, 'Spain');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('006 Bonner Crossing', '11298', null, null, null);

insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('La Mancha', '03610', 'Petrer', 'Alicante', 'España');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('Calle Mayor', '02811', 'Alcornoque', 'Pontevedra', 'España');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('Muralla 12', '14859', 'Ávila', 'Ávila', 'España');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('Brigadier Algarra', '03610', 'Petrer', 'Alicante', 'España');
insert into Direccion (calle, cod_postal, ciudad, provincia, pais) values ('Banyeres', '29734', 'Cadaqués', 'Gerona', 'España');


insert into Direccion_en ([usuario],[direccion]) values (3,1);
insert into Direccion_en ([usuario],[direccion]) values (23,2);
insert into Direccion_en ([usuario],[direccion]) values (12,3);
insert into Direccion_en ([usuario],[direccion]) values (6,4);
insert into Direccion_en ([usuario],[direccion]) values (9,33);
insert into Direccion_en ([usuario],[direccion]) values (2,2);
insert into Direccion_en ([usuario],[direccion]) values (12,9);
insert into Direccion_en ([usuario],[direccion]) values (1,12);



INSERT INTO Locker (nombre) VALUES ('Kiosko Laura');
INSERT INTO Locker (nombre) VALUES ('Casa Paquirrín');
INSERT INTO Locker (nombre) VALUES ('Panadería Tomasa');
INSERT INTO Locker (nombre) VALUES ('Habana');
INSERT INTO Locker (nombre) VALUES ('Correos');



insert into Categoria(tipo,descripcion) values ('Ratones','El ratón es un dispositivo apuntador utilizado para facilitar el manejo de un entorno gráfico en una computadora');
insert into Categoria(tipo,descripcion) values ('Auriculares','El auricular es transductor que recibe una señal eléctrica originada desde una fuente electrónica');
insert into Categoria(tipo,descripcion) values ('Monitores','El monitor u ordenador es el principal dispositivo de salida que muestra los datos e información de los [usuario]s');
insert into Categoria(tipo,descripcion) values ('Teclados','El teclado es un dispositivo de entrada, en parte inspirado en el teclado de las máquinas de escribir');
insert into Categoria(tipo,descripcion) values ('Alfombrillas','La alfombrilla es una superficie que mejora el movimiento del ratón');
insert into Categoria(tipo,descripcion) values ('Ordenadores','Máquinas listas para usar con las mejores calidades');



insert into Promocion(descuento,disponibilidad) values (80,0);
insert into Promocion(descuento,disponibilidad) values (60,0);
insert into Promocion(descuento,disponibilidad) values (20,1);
insert into Promocion(descuento,disponibilidad) values (30,1);
insert into Promocion(descuento,disponibilidad) values (50,1);
insert into Promocion(descuento,disponibilidad) values (90,1);
insert into Promocion(descuento,disponibilidad) values (100,0);



insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('Newskill Sylvanus PRO Auriculares Gaming',54.99,'Images/Productos/1.jpg','Auriculares Gaming con Sonido Envolvente Virtual 7.1 Multiplataforma',40,100,null,'Auriculares');
insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('Cool Kids Auriculares Bluetooth Infantiles',26.11,'Images/Productos/2.jpg','Cascos ergonómicos suaves y seguros, ideales para niños. Volumen limitado para una experiencia perfecta',20,5,null,'Auriculares');
insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('Logitech Headset PC 960 USB',27.99,'Images/Productos/3.jpg','Cascos del Xocas',25,100,null,'Auriculares');

insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('Forgeon Perdition RGB Ratón Gaming',35.99,'Images/Productos/4.jpg','Ratón ergonómico RGB con 16.000 DPI en color negro',10,60,3,'Ratones');
insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('Logitech M185 Ratón Inalámbrico',12.00,'Images/Productos/5.jpg','Ratón inalámbrico en color gris muy comodo',200,14,3,'Ratones');
insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('Apple Magic Mouse Plata',85.00,'Images/Productos/6.jpg','Ratón Magic Mouse de Apple inalámbrico en color plata',76,65,3,'Ratones');

insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('HP OMEN 27" LED IPS FullHD 165Hz FreeSync',169.00,'Images/Productos/7.jpg','Su excelente rendimiento y la nitidez de sus colores permiten que pueda perderse en los juegos que más le gustan',21,70,6,'Monitores');
insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('AOC 27B3HA2 LED IPS 27" FullHD 100Hz',109.90,'Images/Productos/8.jpg','Claridad de alto rendimiento con monitor FHD de 27" y 100Hz con HDMI. ',76,10,6,'Monitores');
insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('HP OMEN 34c 34" WQHD 165Hz FreeSync Premium Curva',389.00,'Images/Productos/9.jpg','No hay nada mejor que evadirse con el monitor gaming curvo OMEN by HP de 34", WQHD, 165 Hz. Inmersión total gracias a su pantalla curva ultrapanorámica de 1500R',3,0,null,'Monitores');


insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('Logitech G915 TKL RGB',139.00,'Images/Productos/10.jpg','El G915 TKL es increíblemente refinado y sorprendentemente fino, duradero y hecho ante todo para ofrecer rendimiento y funciones.',10,32,null,'Teclados');
insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('Newskill Serike V2 TKL',75.00,'Images/Productos/11.jpg','El teclado mecánico para juegos Serike V2 te ofrece la experiencia más completa para jugar',76,65,null,'Teclados');
insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('Tempest K20 Beast',32.44,'Images/Productos/12.jpg','Teclado Mecánico Inalámbrico Gaming RGB TKL Mini Negro',500,100,null,'Teclados');





insert into Testimonial(mensaje) values ('Explorar la tienda digital fue como navegar en un universo de posibilidades tecnológicas. ¡Una experiencia fascinante!');
insert into Testimonial(mensaje) values ('Hallé la laptop perfecta entre brillantes pantallas y veloces procesadores. ¡Una elección que despierta sonrisas!');
insert into Testimonial(mensaje) values ('Cada clic fue un descubrimiento. Encontré periféricos que potenciaron mi creatividad. ¡Una compra inolvidable');
insert into Testimonial(mensaje) values ('Sumergirme en la tienda virtual fue como entrar en un oasis tecnológico. ¡Una aventura que despierta la imaginación');
insert into Testimonial(mensaje) values ('Desde el primer contacto, la atención al cliente fue excepcional. ¡Un servicio que marca la diferencia!');
insert into Testimonial(mensaje) values ('Explorar las ofertas de la tienda digital fue como encontrar tesoros en un mar de innovación. ¡Una experiencia emocionante');
insert into Testimonial(mensaje) values ('La facilidad de navegación hizo que mi compra fuera un paseo por el paraíso digital. ¡Una sensación de satisfacción absoluta');
insert into Testimonial(mensaje) values ('Cada artículo estaba envuelto en posibilidades infinitas. ¡Una visita que despierta la curiosidad!');
insert into Testimonial(mensaje) 
values ('Descubrir la tienda online fue como abrir una puerta a un mundo de tecnología. ¡Una experiencia que alimenta la pasión por lo digital!');
insert into Testimonial(mensaje) values ('Explorar la tienda de informática fue como ser un niño en una juguetería, pero con gadgets. ¡Una emoción indescriptible!');



insert into Califica(testimonial,[usuario]) values (1,1);
insert into Califica(testimonial,[usuario]) values (2,2);
insert into Califica(testimonial,[usuario]) values (3,3);
insert into Califica(testimonial,[usuario]) values (4,4);
insert into Califica(testimonial,[usuario]) values (5,5);
insert into Califica(testimonial,[usuario]) values (6,6);
insert into Califica(testimonial,[usuario]) values (7,7);
insert into Califica(testimonial,[usuario]) values (8,8);
insert into Califica(testimonial,[usuario]) values (9,9);
insert into Califica(testimonial,[usuario]) values (10,10);


-- insert into Valora([[usuario]],producto,puntuacion,descripcion) values (2,1,5,'Los mejores cascos que he probado en mi vida');
insert into Valora([usuario],producto,puntuacion,descripcion) values (6,1,0,'No me han gustado nada, los he probado 100h y ya se están pelando');
insert into Valora([usuario],producto,puntuacion,descripcion) values (32,1,2,'Demasido caros para lo que ofrecen');
insert into Valora([usuario],producto,puntuacion,descripcion) values (1,1,4,null);



insert into Locker_en ([direccion],[locker]) values (82,1); 
insert into Locker_en ([direccion],[locker]) values (83,2);
insert into Locker_en ([direccion],[locker]) values (84,3);
insert into Locker_en ([direccion],[locker]) values (85,4);

insert into Pedido([fecha], [usuario]) values ('01/01/1900', 1);
insert into Pedido([fecha], [usuario]) values ('01/01/1900', 2);
insert into Pedido([fecha], [usuario]) values ('01/01/1900', 3);