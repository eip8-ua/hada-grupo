
## Descripción  
Esta aplicación web es una tienda online de productos tecnológicos, con un control de usuarios y privilegios para los administradores

## Usuarios de prueba
|   Tipo    | Correo electrónico |	Contraseña |
| :----------- | :-----------: | :-----------: |
|Administrador | admin@ua.es   | 1234		   |
| Usuario	   | user@ua.es    | 1234          |

## Integrantes del equipo de desarrollo
-  Emiliano Dovao Marcovich
-  Saúl Conejo Minguez
-  Lucas Alberola Pastor
-  Elías Iborra Pérez
-  David Mas Almendros
-  Daniel Alarcón Mena
-  Abdelatif Boussaid

# Trabajo realizado
- Emiliano Dovao Marcovich
    - Creación de la página maestra y la gestión del usuario durante toda la web
    - Aspx de tienda (página principal)
    - Aspx de estadísticas
    - Entidades promociones e informes

- Saúl Conejo Minguez
    - Entidades producto, categoría y valoraciones
    - Aspx de contactanos
    - Aspx de administacion de pedidos
    - Confección de la base de datos 
    - Rellenado de la base de datos

- Lucas Alberola Pastor
  	- Entidades de Negocio ENUsuario y ENTestimonial y su capa intermedia con la base de datos
  	  (CADUsuario y CADTestimonial)
  	- Página de administración de usuarios para el admin de la página, con implementación de eliminado de usuarios
  	- Página de Datos de Usuario, con posibilidad de modificación y un pop-up de confirmación
  	- Configuración del Web.config para el acceso a la base de datos desde los CAD

- Elías Iborra Pérez
	- Entidades Direccion y Locker
	- Aspx de inicio de sesión y registro
	- Aspx de añadir artículos (administrador)
	- Mostrar valoraciones en los productos
    - Valoraciones en los productos
	- Confección y rellenado de la base de datos

- David Mas Almendros
    - Creación de los estilos, estructura y diseño de la página web (Estilos_web.pdf)
    - Entidades Carrito, LinCarr (Linea de Carrito) y CarritoDe
    - Aspx de Carrito
    - Añadir productos al carrito desde productos, producto-seleccionado y productosCategoria
    - Funcionalides de eliminar y cambiar cantidad de una linea del carrito
    - Ventana de confirmación de compra
    - Compatibilidad entre la variable Session y la Base de datos (Persistencia de datos)

- Daniel Alarcón Mena
	-Entidades Pedido y Línea Pedido
  	-Aspx de Testimoniales
  	-Aspx de Productos (por categoria,todos y de manera individual) 

- Abdelatif Boussaid
    - Entidades valoraciones.
    - Apsx de pedidos.
    - Aspx categorias, ayudando a Daniel.




## Reparto de Entidades y Aspx (inicialmente)

|   Alumno    | EN |	ASPX |
| :----------- | :-----------: | :-----------: |
| Emiliano Dovao      |    Promociones <br></br>  Informes                    |		Master <br></br>  Index                            |
| Saúl Conejo         |    Producto <br></br>  Categoría                      |		Contacta                                           |
| Lucas Alberola      |    Usuario <br></br>  Testimonial                     |		Usuario											   |
| Elías Iborra        |    Locker <br></br>  Dirección                        |		Login <br></br> Crear Usuario                      |
| David Mas Almendros |    Carrito <br></br>  Línea de Carrito                |		Carrito							                   |
| Daniel Alarcón      |    Pedido <br></br>  Línea de pedido                  |		Testimoniales<br></br>Página con todos los productos|
| Abdelatif Boussaid  |    Valoraciones <br></br>  Contacta con nosotros      |		Pedido<br></br>Página de producto específico       |
## Parte Pública  
La parte pública permite a los usuarios no registrados crear una cuenta, iniciar sesión, consultar los productos ofrecidos y su stock.  
## Listado EN Pública  
#### Producto -saúl  
-  Mostrar datos como la disponibilidad, el precio, características...
#### Categoría -saúl  
-  Método que devuelve un listado con todas las categorías
#### Contacta con nosotros (Datos emisor + mensaje)  -abdel
-  Devolver el mapa/ubicación de nuestra supuesta central
-  Permitir poder enviar correos electrónicos a nuestro email de empresa?
#### Promociones  -emiliano
-  Mostrar todas las promociones disponibles actualmente
-  Mostrar el periodo de disponibilidad de una promoción concreta
#### Informes  -emiliano
-  Conseguir el top 10 de los productos más vendidos
-  Conseguir el top 10 de los clientes que más aportan a la empresa
-  Obtener la provincia con la mayor cantidad de pedidos

## Parte Privada  
La parte privada permite a los usuarios con cuenta de cliente añadir productos al carrito y realizar pedidos. Y a los administradores introducir productos, actualizarlos y obtener estadísticas.  
## Listado EN Privada  
#### Pedido  -dani
-  Devolver el número de líneas de pedido que lo forman
#### Línea de pedido  -dani
-  Devolver el número de pedido al que pertenece
#### Carrito -David
-  Devolver el precio total del carrito
#### Línea de carrito -David
-  Crear una línea de carrito al introducir un producto en la base de datos
#### Usuario  -Lucas
-  Método que comprueba si el usuario está registrado
-  Método que comprueba si el usuario tiene derechos de administrador
-  Método para registrar al usuario
-  Método para cambiar los datos del usuario una vez registrado
#### Dirección -elias  
-  Devolver la dirección de un usuario
#### Testimonial  -Lucas
-  
#### Valoraciones  -abdel
- Sacar la media de las puntuaciones emitidas por los usuario.
- Método para valuar un producto del 1 al 5 y escribir un comentario acerca del producto.
- Método para enseñar valoraciones anteriores.
### Contacta con nosotros -abdel
- método para poder escribir algo a los administradores de la tienda, puede ser una queja, una supuesta mejora de u producto etc...
#### Locker -elias
-  Obtener todos los lockers dada una provincia??
-  Obtener todos los lockers


#Problemas encontrados
- Ha habido problemas con la gestión del carrito y como añadir los productos al carrito para los usuarios sin registrar en la web. Finalmente se ha podido solventar pero ha llevado mucho tiempo.
- Modificación de la base de datos una vez ya empezado el proyecto debido a que surgieron nuevas funcionalidades en las que la base de datos anterior estaba obsoleta. Esto ha conllevado la modificacion del modelo entidad relación.
- Trabajo en equipo y sobretodo el uso de github para poder trabajar independientemente. Uno de los mayores aprendizajes ha sido el poder trabajar cada uno sobre su parte y luego unirlo todo en develop. La metodología de trabajo aprendida ha sido el mayor aprendizaje de este proyecto.
- Uso de nuevas tecnologías web de los que muchos no habíamos hecho uso nunca como puede ser css.
- Abdelatif Boussaid no ha podido con toda la carga de trabajo y se ha repartido su parte a Saúl Conejo Mínguez.


## Mejoras implementadas
- Protección contra injecciones sql. Gracias a SqlCommand.Parameters.SetValuesWith(string,variable). hemos conseguido mejorar en la seguridad de la página web.
- Apartado de testimonios de usuarios donde nuestros usuarios puedes expresar su opinión libremente sobre nuestra web y nuestros productos.
- Capacidad de ver estadísticas de los artículos de la web
- Sistema de popularidad para poder ordenar los artículos por popularidad
- Gestión total de la web por parte del administrador con un panel de control
- Mejoras gráficas en la web que aportan armonía visual
- Sistema de soporte para que los administradores de la web puedan solventar los problemas de los usuarios


## Posibles mejoras
-  Apartado de devolución de artículos para usuarios registrados.
-  Programam de fidelización de usuarios en el que se de recompensas a los usuarios que compren asiduamente.
-   Capacidad de recoger un pedido en un locker (no ha dado tiempo a implementarlo).

## Mejoras necesarias
-  Si el usuario está registrado las opciones del icono de usuario pasarán a ser:
	1. Mi cuenta (llevará a usuario.aspx)
	2. Mis pedios. (llevará a pedidos.aspx)
	3. Si es admin también aparecerán estas opciones:
		1.1. Añadir artículo. (llevará a un nuevos aspx llamado admin_productos.aspx)
		1.2. Administrar pedidos. (llevará a un aspx nuevo llamado admin_pedidos.aspx) MENOS PRIORITARIO
		1.3. Administrar usuarios. (llevará a un aspx nuevo llamado admin_usuarios.aspx) MENOS PRIORITARIO
	4. Cerrar sesión.


## Esquema Entidad Relacion de la base de datos
- El esquema se encuentra en la raiz del proyecto con el nombre 'Esquema_ER.pdf'. En este archivo se encuentra el equema ER con todas las relaciones de las entidades de nuestra página web.

# Entrega 01 Propuesta - Comentarios

La web que se propone es correcta y cumple con los requisitos de la práctica. El detalle de EN y funcionalidades es correcto. La descripción es correcta y además se cumple con todo lo que se pide para esta primera entrega en git.

Todo bien. Enhorabuena!!

# Entrega 02 EN/CAD - Comentarios

La entrega es correcta y cumple con todos los requisitos. Ahora vamos a por la siguiente entrega. Os recomiendo que creeis un proyecto en git hub en donde aparezca los .aspx que tiene que hacer cada uno y que la entrega la planteeis para el martes 30.

Saludos!!!

# Entrega 03 Interfaz

La entrega en git es correcta y cumple con todo. Simplemente hay dos inconvenientes, faltan .aspx por implementar. Por ejemplo registro.aspx no está, faltan los aspx de la administración. Además, el proyecto debia compilar y no compila. De todas formas es algo que podeis solventar con las mejoras.

Enhorabuena, vais muy bien!!!


