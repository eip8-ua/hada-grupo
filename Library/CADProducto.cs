using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    class CADProducto
    {
        public string constring;
        private SqlConnection connection;
        public CADProducto()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        public bool Create(ENProducto prod)
        {
            string consu = "Insert into Producto(nombre,pvp,url_image,descripcion,stock,popularidad,promocion,categoria) values (@nom,@pvp,@url_image,@descripcion,@stock,@pop,@promo,@cat); select SCOPE_IDENTITY();";

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                SqlCommand comm = new SqlCommand(consu, connection);
                comm.Parameters.AddWithValue("@nom", prod.nombre);
                comm.Parameters.AddWithValue("@pvp", prod.pvp);
                if (prod.url_image == null)
                    comm.Parameters.AddWithValue("@url_image", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@url_image", prod.url_image);
                if (prod.descripcion == null)
                    comm.Parameters.AddWithValue("@descripcion", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@descripcion", prod.descripcion);


                comm.Parameters.AddWithValue("@stock", prod.stock);
                comm.Parameters.AddWithValue("@pop", prod.popularidad);
                if(prod.promocion == null)
                    comm.Parameters.AddWithValue("@promo", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@promo", prod.promocion.MiId);

                if (prod.categoria == null)
                    comm.Parameters.AddWithValue("@cat", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@cat", prod.categoria.tipo);

                prod.id = Convert.ToInt32(comm.ExecuteScalar());
            }
            catch (SqlException e)
            {
                Console.Write(e);
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

            string consu = "Update Producto set nombre=@name,pvp=@pvp,url_image=@url_image,descripcion=@descripcion,stock=@stock,popularidad=@pop,promocion=@promo,categoria=@cat where id =@id";

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                SqlCommand comm = new SqlCommand(consu, connection);
                comm.Parameters.AddWithValue("@name", prod.nombre);
                comm.Parameters.AddWithValue("@pvp", prod.pvp);
                if (prod.url_image == null)
                    comm.Parameters.AddWithValue("@url_image", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@url_image", prod.url_image);
                if (prod.descripcion == null)
                    comm.Parameters.AddWithValue("@descripcion", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@descripcion", prod.descripcion);


                comm.Parameters.AddWithValue("@stock", prod.stock);
                comm.Parameters.AddWithValue("@pop", prod.popularidad);
                
                if (prod.promocion == null)
                    comm.Parameters.AddWithValue("@promo", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@promo", prod.promocion.MiId);

                if (prod.categoria == null)
                    comm.Parameters.AddWithValue("@cat", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@cat", prod.categoria.tipo);
                
                comm.Parameters.AddWithValue("@id", prod.id);

                return comm.ExecuteNonQuery() > 0;
            }
            catch (SqlException e)
            {
                Console.Write(e);
                return false;
            }
            finally
            {
                connection.Close();
            }
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

                        // Handle promocion
                        ordinal = reader.GetOrdinal("promocion");
                        if (reader.IsDBNull(ordinal))
                        {
                            prod.promocion = null;
                        }
                        else
                        {
                            int promocionId = reader.GetInt32(ordinal);
                            prod.promocion = new ENPromociones { MiId = promocionId };
                            prod.promocion = prod.promocion.read();
                        }

                        // Handle categoria
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
            catch (SqlException e)
            {
                Console.Write(e);
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
            catch (SqlException e)
            {
                Console.Write(e);
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

        public List<ENProducto> FiltrarProductos(string categoria, decimal minPrice, decimal maxPrice)
        {
            List<ENProducto> productos = new List<ENProducto>();
            string query = @"
        SELECT *, 
            CASE
                WHEN Promocion IS NOT NULL THEN Pvp * (1 - (SELECT Descuento FROM Promocion WHERE Promocion.id = Producto.promocion) / 100.0)
                ELSE Pvp
            END AS PrecioConDescuento
        FROM Producto
        WHERE (@categoria = 'all' OR Categoria = @categoria)
        AND 
        (
            (Promocion IS NOT NULL AND Pvp * (1 - (SELECT Descuento FROM Promocion WHERE Promocion.id = Producto.promocion) / 100.0) BETWEEN @minPrice AND @maxPrice)
            OR
            (Promocion IS NULL AND Pvp BETWEEN @minPrice AND @maxPrice)
        )";

            using (SqlConnection connection = new SqlConnection(constring))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@categoria", categoria);
                command.Parameters.AddWithValue("@minPrice", minPrice);
                command.Parameters.AddWithValue("@maxPrice", maxPrice);

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
