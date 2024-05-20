using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    class CADCategoria
    {
        private string constring;
        public SqlConnection connection;

        public CADCategoria()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        /// <summary>
        /// Añade una categoría a la base de datos
        /// </summary>
        /// <param name="cat">Devuelve t/f si se ha podido añadir</param>
        /// <returns></returns>
        public bool Create(ENCategoria cat)
        {
            string query = "insert into Categoria(tipo, descripcion) values (@tipo,@desc)";

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                SqlCommand comm = new SqlCommand(query, connection);
                comm.Parameters.AddWithValue("@tipo", cat.tipo);
                comm.Parameters.AddWithValue("@desc", cat.descripcion);


                return comm.ExecuteNonQuery() > 0;
            }
            catch (SqlException e)
            {
                Console.WriteLine(e);
                return false;

            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Borrar la categoría de la db con el parámetro tipo de cat
        /// </summary>
        /// <param name="cat"></param>
        /// <returns>Si se ha borrado una columna devuelve t, si no f</returns>
        public bool Delete(ENCategoria cat)
        {
            string consu = "Delete from Categoria where id=@tipo";

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                SqlCommand comm = new SqlCommand(consu, connection);
                comm.Parameters.AddWithValue("@tipo", cat.tipo);

                return comm.ExecuteNonQuery() > 0;

            }
            catch (SqlException e)
            {
                Console.WriteLine(e);
                return false;
            }
            finally
            {
                connection.Close();
            }
        }
        /// <summary>
        /// Actualiza la categoría en la db
        /// </summary>
        /// <param name="cat">Devuelve t si se ha modificado alguna categoría</param>
        /// <returns></returns>
        public bool Update(ENCategoria cat)
        {
            string consu = "Update Categoria set descripcion=@desc where tipo=@tipo";

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                SqlCommand comm = new SqlCommand(consu, connection);
                comm.Parameters.AddWithValue("@desc", cat.descripcion);
                comm.Parameters.AddWithValue("@tipo", cat.tipo);
                
                //Devolverá true si se ha modificado alguna columna
                return comm.ExecuteNonQuery() > 0;
            }
            catch (SqlException e)
            {
                Console.WriteLine(e);
                return false;
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Obtiene la categoría con tipo igual al objeto cat
        /// </summary>
        /// <param name="cat"></param>
        /// <returns>Devuelve t/f si ha encontrado la categoría o no</returns>
        public bool Read(ENCategoria cat)
        {
            //Solo saco descripcion de la db porque si el tipo coincide,
            //ya lo tienes en el objeto cat
            string com = "Select descripcion from Categoria where tipo = @tipo";

            //No usamos el finally para cerrar la conexión porque usamos el using
            // que se encarga de ello
            using (SqlConnection connection = new SqlConnection(constring))
            {
                try
                {
                    connection.Open();

                    SqlCommand command = new SqlCommand(com, connection);
                    command.Parameters.AddWithValue("@tipo", cat.tipo);
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        cat.descripcion = reader["descripcion"].ToString();
                        return true;
                    }
                }
                catch (SqlException e)
                {
                    Console.WriteLine(e);
                    return false;
                }
            }
            return false;
        }

        /// <summary>
        /// Obtiene una lista con todas las categorías
        /// </summary>
        /// <param name="categorias"></param>
        /// <returns>Devuelve f si no hay categorías o se ha producido un error</returns>
        public List<ENCategoria> Read_All()
        {
            List<ENCategoria> categorias = new List<ENCategoria>();
            string com = "Select * from Categoria";

            //No usamos el finally para cerrar la conexión porque usamos el using
            // que se encarga de ello
            using (SqlConnection connection = new SqlConnection(constring))
            {
                try
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(com, connection);
                    SqlDataReader reader = command.ExecuteReader();


                    if (reader.Read())
                    {
                        ENCategoria categoria = new ENCategoria();
                        categoria.tipo = reader["tipo"].ToString();
                        categoria.descripcion = reader["descripcion"].ToString();

                        categorias.Add(categoria);
                    }
                }
                catch (SqlException e)
                {
                    Console.WriteLine(e);
                }
            }

            return categorias;
        }
    }
}
