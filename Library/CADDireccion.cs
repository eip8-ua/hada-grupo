using System;
using System.Data.SqlClient;
using System.Configuration;
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
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
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
                    //Hace el insert y luego ejecuta una select que devuelve el ultimo id(el que acabas de insertar)
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

                    //Ejecuta la query y guarda el ultimo id
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

                //primero hay que borrar las relaciones entre direccion y locker para poder borrar la direccion
                SqlCommand check_locker = new SqlCommand("delete Locker_en where direccion=@dir", connection);
                check_locker.Parameters.AddWithValue("@dir", dir.id);
                check_locker.ExecuteNonQuery();


                //Borrar de la tabla direccion
                SqlCommand sql = new SqlCommand($"delete from Direccion where id=@id", connection);
                sql.Parameters.AddWithValue("@id", dir.id);
                int rowsAffected = sql.ExecuteNonQuery();
                if (rowsAffected == 0)
                    return false;
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

            return false;
        }

        /// <summary>
        /// Introduce en dir todos los datos de la dirección usando el id de dir
        /// </summary>
        /// <param name="dir">Debe tener un id válido, la direccion se devuelve aquí</param>
        /// <returns></returns>
        public bool Read(ENDireccion dir)
        {
            try
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
            }
            catch(SqlException e)
            {
                Console.WriteLine(e);
            }
            finally
            {
                connection.Close();
            }
            
            return false;
        }

        /// <summary>
        /// Comprueba si un id existe en la base de datos
        /// Si aparece un error devuelve una Sql Exception
        /// </summary>
        /// <param name="dir"></param>
        /// <returns></returns>
        public bool Exists(ENDireccion dir)
        {
            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                SqlCommand sql = new SqlCommand("select * from Direccion where id=@id", connection);
                sql.Parameters.AddWithValue("@id", dir.id);
                SqlDataReader reader = sql.ExecuteReader();
                return reader.HasRows;
            }
            finally
            {
                connection.Close();
            }
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
