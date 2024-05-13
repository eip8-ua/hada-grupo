using System;
using System.Data.SqlClient;
namespace Library
{
    class CADDireccion
    {
        private string constring;
        private SqlConnection connection;

        /// <summary>
        /// Constructor por defecto
        /// </summary>
        public CADDireccion()
        {
            //constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
            constring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Database1.mdf;Integrated Security=True";
        }
        /// <summary>
        /// Añade una direccion a la base de datos
        /// </summary>
        /// <param name="dir"> Objeto con los datos de la dirección a añadir</param>
        /// <returns></returns>
        public bool Create(ENDireccion dir)
        {
            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                if (dir.is_correct())
                {
                    SqlCommand sql = new SqlCommand($"insert into Direccion(calle, cod_postal, ciudad, provincia, pais) values (@calle,@cod_postal,@ciudad,@provincia,@pais); select SCOPE_IDENTITY();", connection);
                    sql.Parameters.AddWithValue("@calle", dir.calle);
                    sql.Parameters.AddWithValue("@cod_postal", dir.cod_postal);

                    if (dir.ciudad == null)
                        sql.Parameters.AddWithValue("@ciudad", DBNull.Value);
                    else
                        sql.Parameters.AddWithValue("@ciudad", dir.ciudad);
                    if (dir.provincia == null)
                        sql.Parameters.AddWithValue("@provincia", DBNull.Value);
                    else
                        sql.Parameters.AddWithValue("@provincia", dir.provincia);
                    if (dir.pais == null)
                        sql.Parameters.AddWithValue("@pais", DBNull.Value);
                    else
                        sql.Parameters.AddWithValue("@pais", dir.pais);
                    //sql.ExecuteNonQuery();

                    dir.id = Convert.ToInt32(sql.ExecuteScalar());
                    return true;
                }
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

            return true;
        }

        /// <summary>
        /// Borra una dirección de la base de datos
        /// </summary>
        /// <param name="dir">Objeto a borrar</param>
        /// <returns></returns>
        public bool Delete(ENDireccion dir)
        {
            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                SqlCommand sql = new SqlCommand($"delete from Direccion where id=@id", connection);
                sql.Parameters.AddWithValue("@id", dir.id);
                sql.ExecuteNonQuery();
                return true;
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
        /// Actualiza la direccion con id el id de dir
        /// </summary>
        /// <param name="dir">Datos a actualizar en la db</param>
        /// <returns></returns>
        public bool Update(ENDireccion dir)
        {
            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                if (dir.is_correct())
                {
                    SqlCommand sql = new SqlCommand("update Direccion set calle=@calle,cod_postal=@cod_postal,ciudad=@ciudad,provincia=@provincia,pais=@pais where id=@id",connection);
                    sql.Parameters.AddWithValue("@calle", dir.calle);
                    sql.Parameters.AddWithValue("@cod_postal", dir.cod_postal);
                    sql.Parameters.AddWithValue("@id", dir.id);

                    if (dir.ciudad == null || dir.ciudad == "")
                        sql.Parameters.AddWithValue("@ciudad", DBNull.Value);
                    else
                        sql.Parameters.AddWithValue("@ciudad", dir.ciudad);
                    if (dir.provincia == null || dir.provincia == "")
                        sql.Parameters.AddWithValue("@provincia", DBNull.Value);
                    else
                        sql.Parameters.AddWithValue("@provincia", dir.provincia);
                    if (dir.pais == null || dir.pais == "")
                        sql.Parameters.AddWithValue("@pais", DBNull.Value);
                    else
                        sql.Parameters.AddWithValue("@pais", dir.pais);


                    sql.ExecuteNonQuery();
                    return true;
                }
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

            return true;
        }

        /// <summary>
        /// Introduce en dir todos los datos de la dirección usando el id de dir
        /// </summary>
        /// <param name="dir">Debe tener un id válido, la direccion se devuelve aquí</param>
        /// <returns></returns>
        public bool Read(ENDireccion dir)
        {
            connection = new SqlConnection(constring);
            connection.Open();

            SqlCommand sql = new SqlCommand("select * from Direccion where id=@id", connection);
            sql.Parameters.AddWithValue("@id", dir.id);
            SqlDataReader reader = sql.ExecuteReader();

            if (reader.Read())
            {
                dir.calle = reader["calle"].ToString();
                dir.cod_postal = reader["cod_postal"].ToString();
                dir.ciudad = reader["ciudad"].ToString();
                dir.provincia = reader["provincia"].ToString();
                dir.pais = reader["pais"].ToString();

                return true;
            }
            return false;
        }

        /// <summary>
        /// Obtiene la id de la direccion usando la calle y el codigo postal
        /// </summary>
        /// <param name="dir"></param>
        /// <returns></returns>
        public bool get_id(ENDireccion dir)
        {
            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                if (dir.is_correct())
                {
                    SqlCommand sql = new SqlCommand($"select id from direccion where calle = {dir.calle} and cod_postal = {dir.cod_postal}", connection);
                    dir.id = (int)sql.ExecuteScalar();

                    return true;
                }
            }
            catch (SqlException e)
            {
                //Falta poner el error

                return false;
            }
            finally
            {
                connection.Close();
            }

            return false;
        }
    }
}
