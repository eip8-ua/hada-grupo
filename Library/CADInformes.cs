using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    class CADInformes
    {
        //String para la conexión con la BD
        string miConexion;
        //Propiedad del string anterior
        public string MiConexion { get { return miConexion; } set { miConexion = value; } }

        //Constructor para establecer la cadena de conexión
        public CADInformes()
        {

            miConexion = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        //Método que modifica la lista pasada para que contenga los diez productos más populares
        //Devuelve verdadero si no hay ningún error al acceder a la BD SQL, si no devuelve falso
        public List<ENProducto> getTopProducts()
        {
            List<ENProducto> productos = new List<ENProducto>();
            //Creamos las conexión
            SqlConnection connection = new SqlConnection(miConexion);

            try
            {
                //Abrimos la conexión y definimos la variable De contador para los 10 productos más populares
                connection.Open();
                int contador = 10;

                //Creamos el comando y lo ejecutamos
                SqlCommand command = new SqlCommand("SELECT * FROM Producto ORDER BY popularidad DESC;", connection);
                SqlDataReader dr = command.ExecuteReader();

                //Se trata de un bucle que va leyendo los productos sacados por el DataReader y metiéndolos en una lista, hasta tener 10
                while (dr.Read() && contador > 0)
                {
                    //Definimos las variables para pasar los valores correctamente a la entidad EN
                    ENProducto producto = new ENProducto();
                    int rid, rstock, rpopularidad, rpromocion;
                    float rpvp;

                    //Pasamos los valores leídos a la entidad producto
                    int.TryParse(dr["id"].ToString(), out rid);
                    producto.id = rid;
                    producto.nombre = dr["nombre"].ToString();
                    float.TryParse(dr["pvp"].ToString(), out rpvp);
                    producto.pvp = rpvp;
                    producto.url_image = dr["url_image"].ToString();
                    producto.descripcion = dr["descripcion"].ToString();
                    int.TryParse(dr["stock"].ToString(), out rstock);
                    producto.stock = rstock;
                    int.TryParse(dr["popularidad"].ToString(), out rpopularidad);
                    producto.popularidad = rpopularidad;
                    int.TryParse(dr["promocion"].ToString(), out rpromocion);

                    // Inicializamos y asignamos el valor a la promoción
                    producto.promocion = new ENPromociones();
                    producto.promocion.MiId = rpromocion;

                    // Realizamos la lectura
                    ENPromociones promocionLeida = producto.promocion.read();

                    // Validamos si la promoción leída es válida
                    if (promocionLeida.MiId == rpromocion)
                    {
                        producto.promocion.MiId = promocionLeida.MiId;
                        producto.promocion.Descuento = promocionLeida.Descuento;
                        producto.promocion.Disponibilidad = promocionLeida.Disponibilidad;
                    }
                    else
                    {
                        producto.promocion = new ENPromociones();
                    }

                    //Añadimos el producto a la lista de productos
                    productos.Add(producto);

                    //Decrementamos el contador
                    contador--;
                }

                return productos;
                //En caso de fallar la operación Sql
            }
            catch (SqlException ex)
            {
                Console.WriteLine("Error con la parte SQL en CADInformes: {0}", ex.Message);
                return productos;
            }
            finally
            {
                //Cerramos la conexión
                connection.Close();
            }
        }

        //Método que modifica la lista pasada para que contenga todos los productos
        //Devuelve verdadero si no hay ningún error al acceder a la BD SQL, si no devuelve falso
        public bool getAllProducts(List<ENProducto> productos)
        {
            //Creamos las conexión
            SqlConnection connection = new SqlConnection(miConexion);

            try
            {
                //Abrimos la conexión
                connection.Open();

                //Creamos el comando y lo ejecutamos
                SqlCommand command = new SqlCommand( "SELECT * FROM Producto;", connection);
                SqlDataReader dr = command.ExecuteReader();

                //Se trata de un bucle que va leyendo los productos sacados por el DataReader y metiéndolos en una lista
                while(dr.Read())
                {
                    //Definimos las variables para pasar los valores correctamente a la entidad EN
                    ENProducto producto = new ENProducto();
                    int rid, rstock, rpopularidad, rpromocion;
                    float rpvp;

                    //Pasamos los valores leídos a la entidad producto
                    int.TryParse(dr["id"].ToString(), out rid);
                    producto.id = rid;
                    producto.nombre = dr["nombre"].ToString();
                    float.TryParse(dr["pvp"].ToString(), out rpvp);
                    producto.pvp = rpvp;
                    producto.url_image = dr["url_image"].ToString();
                    producto.descripcion = dr["descripcion"].ToString();
                    int.TryParse(dr["stock"].ToString(), out rstock);
                    producto.stock = rstock;
                    int.TryParse(dr["popularidad"].ToString(), out rpopularidad);
                    producto.popularidad = rpopularidad;
                    int.TryParse(dr["promocion"].ToString(), out rpromocion);

                    // Inicializamos y asignamos el valor a la promoción
                    producto.promocion = new ENPromociones();
                    producto.promocion.MiId = rpromocion;

                    // Realizamos la lectura
                    ENPromociones promocionLeida = producto.promocion.read();

                    // Validamos si la promoción leída es válida
                    if (promocionLeida.MiId == rpromocion)
                    {
                        producto.promocion.MiId = promocionLeida.MiId;
                        producto.promocion.Descuento = promocionLeida.Descuento;
                        producto.promocion.Disponibilidad = promocionLeida.Disponibilidad;
                    }
                    else
                    {
                        producto.promocion = new ENPromociones();
                    }

                    //Añadimos el producto a la lista de productos
                    productos.Add(producto);

                }

                return true;
                //En caso de fallar la operación Sql
            } catch(SqlException ex)
            {
                Console.WriteLine("Error con la parte SQL en CADInformes: {0}", ex.Message);
                return false;
            } finally
            {
                //Cerramos la conexión
                connection.Close();
            }
        }

        //Método que modifica la lista pasada para que contenga los diez usuarios que más han gastado en la web
        //Devuelve verdadero si no hay ningún error al acceder a la BD SQL, si no devuelve falso
        public bool getTopClients(List<ENUsuario> ballenas)
        {
            //Creamos la conexión
            SqlConnection connection = new SqlConnection(miConexion);

            try
            {
                //Abrimos la conexión y definimos el contador para coger el top 10 de compradores
                connection.Open();
                int contador = 10;

                //Creamos el comando y lo ejecutamos
                SqlCommand command = new SqlCommand("SELECT u.id, u.dni, u.email, u.nombre, u.apellidos, u.telefono, u.fecha_nac, " +
                    "u.admin, SUM(pd.pvp*lp.cantidad) AS 'Total gastado' FROM Usuario u " +
                    "INNER JOIN Pedido p on u.id = p.usuario " +
                    "INNER JOIN Linea_pedido lp on p.num_pedido = lp.pedido " +
                    "INNER JOIN Producto pd on lp.producto = pd.id " +
                    "GROUP BY u.id, u.dni, u.email, u.nombre, u.apellidos, u.telefono, u.fecha_nac, u.admin " +
                    "ORDER BY SUM(pd.pvp * lp.cantidad) DESC;", connection);
                SqlDataReader dr = command.ExecuteReader();

                //Bucle en el que leemos los datos de los compradores y los metemos dentro de la lista de mejores compradores
                while(dr.Read() && contador > 0)
                {
                    //Declarador de variables y contenedores
                    ENUsuario usuario = new ENUsuario();
                    int id;
                    DateTime fecha_nac;
                    bool admin;

                    int.TryParse(dr["id"].ToString(), out id);
                    usuario.Id = id;
                    usuario.Dni = dr["dni"].ToString();
                    usuario.Email = dr["email"].ToString();
                    usuario.Nombre = dr["nombre"].ToString();
                    usuario.Apellidos = dr["apellidos"].ToString();
                    usuario.Tlfn = dr["telefono"].ToString();
                    DateTime.TryParse(dr["fecha_nac"].ToString(), out fecha_nac);
                    usuario.FNacimiento = fecha_nac;
                    bool.TryParse(dr["admin"].ToString(), out admin);
                    usuario.Admin = admin;

                    contador--;
                    ballenas.Add(usuario);
                }

                //Se ha llevado a cabo el proeso sin problemas
                return true;

                //En caso de error
            } catch(SqlException ex) {
                Console.WriteLine("Error con la parte SQL en CADInformes: {0}", ex.Message);
                return false;
            } finally
            {
                //Cerramos la conexión
                connection.Close();
            }
        }

        //Método que modifica la dirección pasada para que contenga la provincia con la mayor cantidad pedidos registrados
        //Devuelve verdadero si no hay ningún error al acceder a la BD SQL, si no devuelve falso
        public bool getMostPopularProvince(ENDireccion direccion)
        {

            //Creamos las conexión
            SqlConnection connection = new SqlConnection(miConexion);

            try
            {
                //Abrimos la conexión
                connection.Open();

                //Creamos el comando y lo ejecutamos
                SqlCommand command = new SqlCommand("SELECT * FROM Producto ORDER BY popularidad DESC;", connection);
                SqlDataReader dr = command.ExecuteReader();

                //Condicional para ver si hay alguna provincia en la base de datos y para coger solo la información de la primera
                if (dr.Read())
                {

 
                }

                return true;
                //En caso de fallar la operación Sql
            }
            catch (SqlException ex)
            {
                Console.WriteLine("Error con la parte SQL en CADInformes: {0}", ex.Message);
                return false;
            }
            finally
            {
                //Cerramos la conexión
                connection.Close();
            }
        }

        //Método que devuelve el beneficio bruto que un producto aporta a la compañía
        //En caso de no encontrar el producto, o al haber algún error, devuelve -101
        public int getProductIncome(ENProducto en)
        {
            //Creamos las conexión
            SqlConnection connection = new SqlConnection(miConexion);

            try
            {
                //Abrimos la conexión y definimos la variable De contador para los 10 productos más populares
                connection.Open();
                int income = 0;

                //Creamos el comando y lo ejecutamos
                SqlCommand command = new SqlCommand("SELECT SUM(p.pvp*lp.cantidad) AS 'Income' FROM Producto p " +
                "INNER JOIN Linea_pedido lp on p.id = lp.producto WHERE p.id = " + en.id.ToString() + ";", connection);
                SqlDataReader dr = command.ExecuteReader();

                //Leemos la fila encontradas y cogemos el beneficio bruto
                if (dr.Read())
                {
                    int.TryParse(dr["Income"].ToString(), out income);
                }

                return income;
                //En caso de que haya error a la hora de recoger el beneficio bruto
            } catch(SqlException ex)
            {
                Console.WriteLine("Error con la parte SQL en CADInformes: {0}", ex.Message);
                return -101;
            }
            finally
            {
                //Cerramos la conexión
                connection.Close();
            }

        }

        //Método que devuelve el número de unidades vendidas del producto pasado por parámetro
        //En caso de no encontrar el producto, o al haber algún error, devuelve -101
        public int getNumberOfSoldUnits(ENProducto en)
        {
            //Creamos la conexión y la variable que contenga la cantidad de unidades vendidas
            SqlConnection connection = new SqlConnection(miConexion);
            int unitsSold = 0;
            //Habrímos un bloque try/catch para contener las posibles excepciones
            try
            {
                //Abrimos la conexión
                connection.Open();
                //Creamos el comando necesario
                SqlCommand command = new SqlCommand("SELECT SUM(lp.cantidad) AS 'Unidades' FROM Producto p " +
                    "INNER JOIN Linea_pedido lp ON p.id = lp.producto WHERE p.id = " + en.id.ToString() +";", connection);
                //Creamos el DataReader
                SqlDataReader dr = command.ExecuteReader();

                //Leemos el valor recogido
                if(dr.Read()) int.TryParse(dr["Unidades"].ToString(), out unitsSold);

                //Devolvemos las unidades vendidas
                return unitsSold;

                //En caso de error
            } catch (SqlException ex) {
                Console.WriteLine("Error con la parte SQL en CADInformes: {0}", ex.Message);
                return -101;
            } finally
            {   
                //Cerramos la conexión
                connection.Close();
            }
        }

        //Método que devuelve el número de unidades vendidas del producto pasado por parámetro
        //En caso de no encontrar el producto, o al haber algún error, devuelve -101
        public int getNumberOfOrders(ENUsuario en)
        {
            //Creamos la conexión y la variable que contenga la cantidad de pedidos
            SqlConnection connection = new SqlConnection(miConexion);
            int pedidos = 0;
            //Habrímos un bloque try/catch para contener las posibles excepciones
            try
            {
                //Abrimos la conexión
                connection.Open();
                //Creamos el comando necesario
                SqlCommand command = new SqlCommand("SELECT COUNT(*) AS 'Pedidos' FROM Usuario u " +
                    "INNER JOIN Pedido p ON u.id = p.usuario WHERE u.id = " + en.Id.ToString() + ";", connection);
                //Creamos el DataReader
                SqlDataReader dr = command.ExecuteReader();

                //Leemos el valor recogido
                if (dr.Read()) int.TryParse(dr["Pedidos"].ToString(), out pedidos);

                //Devolvemos las unidades vendidas
                return pedidos;

                //En caso de error
            }
            catch (SqlException ex)
            {
                Console.WriteLine("Error con la parte SQL en CADInformes: {0}", ex.Message);
                return -101;
            }
            finally
            {
                //Cerramos la conexión
                connection.Close();
            }
        }

        //Método que devuelve la puntuación media de un producto pasado por parámetro
        //Devuelve una valoración con la puntuación media, o bien nulo en caso de error
        public ENValoraciones getAverageProductRating(ENProducto en)
        {

            return null;
        }

        public List<ENProducto> getPairPromoProducts()
        {
            //Creamos la conexión y la pareja a devolver, y el contador de la cantidad de objetos a devolver
            List<ENProducto> pareja = new List<ENProducto>();
            SqlConnection connection = new SqlConnection(miConexion);
            int contador = 2;

            try
            {
                //Abrimos la conexión
                connection.Open();

                //Creamos el comando, y el data reader con la ejecución del comando
                SqlCommand command = new SqlCommand("SELECT * FROM Producto p" +
                    " INNER JOIN Promocion pr ON p.promocion = pr.id WHERE p.promocion IS NOT NULL " +
                    "ORDER BY p.popularidad DESC; ", connection);
                SqlDataReader dr = command.ExecuteReader();

                //Bucle en el que vamos leyendo mientras hayan filas o el contador no haya llegado a 0
                while(dr.Read() && contador > 0)
                {
                    //Definimos las variables para pasar los valores correctamente a la entidad EN
                    ENProducto producto = new ENProducto();
                    int rid, rstock, rpopularidad, rpromocion;
                    float rpvp;

                    //Pasamos los valores leídos a la entidad producto
                    int.TryParse(dr["id"].ToString(), out rid);
                    producto.id = rid;
                    producto.nombre = dr["nombre"].ToString();
                    float.TryParse(dr["pvp"].ToString(), out rpvp);
                    producto.pvp = rpvp;
                    producto.url_image = dr["url_image"].ToString();
                    producto.descripcion = dr["descripcion"].ToString();
                    int.TryParse(dr["stock"].ToString(), out rstock);
                    producto.stock = rstock;
                    int.TryParse(dr["popularidad"].ToString(), out rpopularidad);
                    producto.popularidad = rpopularidad;
                    int.TryParse(dr["promocion"].ToString(), out rpromocion);

                    // Inicializamos y asignamos el valor a la promoción
                    producto.promocion = new ENPromociones();
                    producto.promocion.MiId = rpromocion;

                    // Realizamos la lectura
                    ENPromociones promocionLeida = producto.promocion.read();

                    // Validamos si la promoción leída es válida
                    if (promocionLeida.MiId == rpromocion)
                    {
                        producto.promocion.MiId = promocionLeida.MiId;
                        producto.promocion.Descuento = promocionLeida.Descuento;
                        producto.promocion.Disponibilidad = promocionLeida.Disponibilidad;
                    }
                    else
                    {
                        producto.promocion = new ENPromociones();
                    }

                    //Añadimos el producto a la pareja
                    pareja.Add(producto);

                    contador--;
                }

                return pareja;

                //En caso de error
            } catch (SqlException ex)
            {
                Console.WriteLine("Error con la parte SQL en CADInformes: {0}", ex.Message);
                return pareja;
            } finally
            {   //Cerramos la conexión
                connection.Close();
            }
        }
    }
}
