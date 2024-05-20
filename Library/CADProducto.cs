using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    class CADProducto
    {
        public string constring;
        public CADProducto()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        public bool Create(ENProducto prod)
        {
            SqlConnection connection = null;
            string consu = "Insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values ('" + prod.nombre + "'," + prod.pvp + ",'" + prod.url_image + "','" + prod.descripcion + "'," + prod.stock + "," + prod.popularidad + "," + (prod.promocion != null ? prod.promocion.MiId.ToString() : "NULL") + ",'" + prod.categoria.tipo + "')";

            SqlCommand comm = new SqlCommand(consu, connection);

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                if (comm.ExecuteNonQuery() == 0)
                {
                    return false;
                }
            }
            catch (SqlException)
            {
                Console.Write("Excepción SQL");
                return false;
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }
            }

            return true;
        }

        public bool Delete(ENProducto prod)
        {
            SqlConnection connection = null;

            string consu = "Delete from Producto where id =" + prod.id;

            SqlCommand comm = new SqlCommand(consu, connection);

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                if (comm.ExecuteNonQuery() == 0)
                {
                    return false;
                }
            }
            catch (SqlException)
            {
                Console.Write("Excepción SQL");
                return false;
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }
            }
            return true;
        }

        public bool Update(ENProducto prod)
        {
            SqlConnection connection = null;

            string consu = "Update Producto set nombre ='" + prod.nombre + "',pvp =" + prod.pvp + ",url_image='" + prod.url_image + "',descripcion='" + prod.descripcion + "',stock=" + prod.stock + ",popularidad=" + prod.popularidad + ",promocion=" + (prod.promocion != null ? prod.promocion.MiId.ToString() : "NULL") + ",categoria='" + prod.categoria.tipo + "' where id =" + prod.id;

            SqlCommand comm = new SqlCommand(consu, connection);

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                if (comm.ExecuteNonQuery() == 0)
                {
                    return false;
                }
            }
            catch (SqlException)
            {
                Console.Write("Excepción SQL");
                return false;
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }
            }
            return true;
        }

        public bool Read(ENProducto prod)
        {
            SqlConnection connection = null; // Declarar la conexión como nula

            try
            {
                using (connection = new SqlConnection(constring)) // Crear y abrir la conexión dentro del bloque try
                {
                    string com = "Select * from Producto where id = @id"; // Consulta SQL con parámetro
                    SqlCommand command = new SqlCommand(com, connection); // Crear el comando SQL con la consulta y la conexión
                    command.Parameters.AddWithValue("@id", prod.id); // Asignar el valor del parámetro

                    connection.Open(); // Abrir la conexión
                    SqlDataReader reader = command.ExecuteReader(); // Ejecutar la consulta SQL

                    if (reader.Read()) // Verificar si se encontró un registro
                    {
                        prod.nombre = reader["nombre"].ToString();
                        prod.popularidad = Convert.ToInt32(reader["popularidad"]);
                        prod.pvp = Convert.ToSingle(reader["pvp"]);
                        int ordinal = reader.GetOrdinal("url_image");
                        prod.url_image = reader.IsDBNull(ordinal) ? null : reader.GetString(ordinal);
                        ordinal = reader.GetOrdinal("descripcion");
                        prod.descripcion = reader.IsDBNull(ordinal) ? null : reader.GetString(ordinal);
                        prod.stock = Convert.ToInt32(reader["stock"]);
                        ordinal = reader.GetOrdinal("promocion");

                        if (reader.IsDBNull(ordinal))
                        {
                            prod.promocion = null;
                        }
                        else
                        {
                            prod.promocion = new ENPromociones { MiId = reader.GetInt32(ordinal) };
                            prod.promocion = prod.promocion.read();
                        }

                        ordinal = reader.GetOrdinal("categoria");

                        if (reader.IsDBNull(ordinal))
                        {
                            prod.categoria = null;
                        }
                        else
                        {
                            prod.categoria = ENCategoria.getCategoria(reader.GetString(ordinal));
                        }
                        return true;
                    }
                    else
                    {
                        return false; // No se encontró el producto
                    }
                }
            }
            catch (SqlException ex)
            {
                Console.Write("Excepción SQL: " + ex.Message);
                return false; // Error al ejecutar la consulta SQL
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close(); // Cerrar la conexión en el bloque finally
                }
            }
        }


        public List<ENProducto> ProductosPorColumna(string columna, string valor)
        {
            SqlConnection connection = null;
            List<ENProducto> productos = new List<ENProducto>();
            string com = "SELECT * FROM Producto WHERE " + columna + "=@valor";

            try
            {
                using (connection = new SqlConnection(constring))
                {
                    SqlCommand command = new SqlCommand(com, connection);
                    command.Parameters.AddWithValue("@valor", valor);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        ENProducto prod = new ENProducto
                        {
                            id = reader.GetInt32(reader.GetOrdinal("id")),
                            nombre = reader.GetString(reader.GetOrdinal("nombre")),
                            pvp = Convert.ToSingle(reader["pvp"]),
                            url_image = reader["url_image"] as string,
                            descripcion = reader["descripcion"] as string,
                            stock = Convert.ToInt32(reader["stock"]),
                            popularidad = Convert.ToInt32(reader["popularidad"]),
                            promocion = reader.IsDBNull(reader.GetOrdinal("promocion")) ? null : new ENPromociones { MiId = reader.GetInt32(reader.GetOrdinal("promocion")) },
                            categoria = reader.IsDBNull(reader.GetOrdinal("categoria")) ? null : ENCategoria.getCategoria(reader.GetString(reader.GetOrdinal("categoria")))
                        };

                        if (prod.promocion != null)
                        {
                            prod.promocion = prod.promocion.read();
                        }

                        productos.Add(prod);
                    }
                }
            }
            catch (SqlException ex)
            {
                Console.Write("Excepción SQL: " + ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                }
            }
            return productos;
        }


        public bool isCorrect(string cat, int prom)
        {
            ENPromociones promo = new ENPromociones { MiId = prom };
            promo = promo.read();

            if (promo == null || ENCategoria.getCategoria(cat) == null)
            {
                return false;
            }

            return true;
        }

        public List<ENProducto> ObtenerProductos()
        {
            List<ENProducto> productos = new List<ENProducto>();
            string consulta = "SELECT * FROM Producto";

            using (SqlConnection connection = new SqlConnection(constring))
            {
                SqlCommand command = new SqlCommand(consulta, connection);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        ENProducto producto = new ENProducto
                        {
                            id = reader.GetInt32(reader.GetOrdinal("id")),
                            nombre = reader.GetString(reader.GetOrdinal("nombre")),
                            pvp = Convert.ToSingle(reader["pvp"]),
                            url_image = reader["url_image"] as string,
                            descripcion = reader["descripcion"] as string,
                            stock = Convert.ToInt32(reader["stock"]),
                            popularidad = Convert.ToInt32(reader["popularidad"]),
                            promocion = reader.IsDBNull(reader.GetOrdinal("promocion")) ? null : new ENPromociones { MiId = reader.GetInt32(reader.GetOrdinal("promocion")) },
                            categoria = reader.IsDBNull(reader.GetOrdinal("categoria")) ? null : ENCategoria.getCategoria(reader.GetString(reader.GetOrdinal("categoria")))
                        };

                        if (producto.promocion != null)
                        {
                            producto.promocion = producto.promocion.read();
                        }

                        productos.Add(producto);
                    }
                }
                catch (SqlException ex)
                {
                    Console.WriteLine("Excepción SQL: " + ex.Message);
                }
                finally
                {
                    if (connection != null)
                    {
                        connection.Close();
                    }
                }
            }
            return productos;
        }
    }
}
