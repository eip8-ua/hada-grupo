
## Descripción  
Esta aplicación web es una tienda online de productos tecnológicos, con un control de usuarios y privilegios para los administradores

## Integrantes del equipo de desarrollo
-  Emiliano Dovao Marcovich
-  Saúl Conejo Minguez
-  Lucas Alberola Pastor
-  Elías Iborra Pérez
-  David Mas Almendros
-  Daniel Alarcón Mena
-  Abdelatif Boussaid

## Reparto de Entidades y Aspx

|   Alumno    | EN |	ASPX |
| :----------- | :-----------: | :-----------: |
| Emiliano Dovao      |    Promociones <br></br>  Informes                    |		Master <br></br>  Index  <br><br>   Estadisticas                      |
| Saúl Conejo         |    Producto <br></br>  Categoría                      |		Contacta                                           |
| Lucas Alberola      |    Usuario <br></br>  Testimonial                     |		Usuario											   |
| Elías Iborra        |    Locker <br></br>  Dirección                        |		Login <br></br> Crear Usuario                      |
| David Mas Almendros |    Carrito <br></br>  Línea de Carrito                |		Carrito							                   |
| Daniel Alarcón      |    Pedido <br></br>  Línea de pedido                  |		Testimoniales						               |
| Abdelatif Boussaid  |    Valoraciones <br></br>  Contacta con nosotros      |		Pedido											   |


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
-  Devolver una lista con todas las promociones
-  Leer los datos de una promocion pasada por parámetro
#### Informes  -emiliano
-  Conseguir el top 10 de los productos más vendidos
-  Obtener la puntuación media de un producto
-  Obtener una pareja de productos promociones

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
#### Informes  -emiliano
-  Conseguir el top 10 de los clientes que más aportan a la empresa con el dinero gastado
-  Obtener la provincia con la mayor cantidad de pedidos
-  Obtener la cantidad de artículos vendidos
-  Obtener el número de pedidos realizados por un usuario

## Posibles mejoras
-  Añadir una página principal de presentación de nuestra empresa en la que se explique nuestro nicho de mercado y nuestra filosofía de empresa.
-  Apartado de devolución de artículos para usuarios registrados.
-  Apartado de valoración de usuarios.
-  Programam de fidelización de usuarios en el que se de recompensas a los usuarios que compren asiduamente.

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


