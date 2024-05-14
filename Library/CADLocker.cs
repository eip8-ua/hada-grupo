using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;
namespace Library
{
    class CADLocker
    {
        string constring;
        SqlConnection connection;

        public CADLocker()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        /// <summary>
        /// Si la direccion no está en la db la añade
        /// Solo comprueba si el id de la direccion está en la db pero no si el resto de datos son correctos
        /// </summary>
        /// <param name="loc"></param>
        /// <returns></returns>
        public bool Create(ENLocker loc)
        {
            try
            {
                //Comprueba si la direccion existe y si no la crea
                if (loc.dir.Exists() || loc.dir.Create())
                {
                    connection = new SqlConnection(constring);
                    connection.Open();

                    //Hace el insert y luego ejecuta una select que devuelve el ultimo id(el que acabas de insertar)
                    SqlCommand command = new SqlCommand("insert into Locker(nombre) values(@nombre); select SCOPE_IDENTITY();", connection);
                    command.Parameters.AddWithValue("@nombre", loc.nombre);
                    //Ejecuta la query y guarda el ultimo id
                    loc.id = Convert.ToInt32(command.ExecuteScalar());

                    SqlCommand command_relation = new SqlCommand("insert into Locker_en(direccion,locker) values (@dir,@loc)", connection);
                    command_relation.Parameters.AddWithValue("@dir", loc.dir.id);
                    command_relation.Parameters.AddWithValue("@loc", loc.id);
                    command_relation.ExecuteNonQuery();

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
        /// Borra el Locker y si hay relacion con una direccion, borra la relacion, no la direccion
        /// </summary>
        /// <param name="loc"></param>
        /// <returns></returns>
        public bool Delete(ENLocker loc)
        {
            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                SqlCommand check_locker = new SqlCommand("delete Locker_en where locker=@locker", connection);
                check_locker.Parameters.AddWithValue("@locker", loc.id);
                check_locker.ExecuteNonQuery();

                SqlCommand command = new SqlCommand("delete Locker where id=@id");
                command.Parameters.AddWithValue("@id", loc.id);
                int modified_rows = command.ExecuteNonQuery();

                if (modified_rows == 0)
                    return false;
                return true;
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
        /// Actualiza el locker, la direccion y la relacion entre las dos
        /// </summary>
        /// <param name="loc"></param>
        /// <returns></returns>
        public bool Update(ENLocker loc)
        {
            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                //Update Locker
                SqlCommand lockerCommand = new SqlCommand("update Locker set nombre=@nombre where id=@id", connection);
                lockerCommand.Parameters.AddWithValue("@id", loc.id);

                if (loc.nombre == null || loc.nombre == "")
                    lockerCommand.Parameters.AddWithValue("@nombre", DBNull.Value);
                else
                    lockerCommand.Parameters.AddWithValue("@nombre", loc.nombre);

                lockerCommand.ExecuteNonQuery();


                //Update ENDireccion
                loc.dir.Update();

                //Update relacion entre los dos
                SqlCommand relationCommand = new SqlCommand("update Locker_en set direccion=@dir where locker=@id", connection);
                relationCommand.Parameters.AddWithValue("@id", loc.id);
                relationCommand.Parameters.AddWithValue("@dir", loc.dir.id);
                relationCommand.ExecuteNonQuery();
                
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
        /// Lee un locker utilizando el id, tambien se obtiene la direccion que tiene dentro si existe la relacion
        /// </summary>
        /// <param name="loc"></param>
        /// <returns></returns>
        public bool Read(ENLocker loc)
        {
            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                SqlCommand command = new SqlCommand("select * from Locker where id=@id", connection);
                command.Parameters.AddWithValue("@id", loc.id);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    loc.nombre = reader["nombre"].ToString();
                }
                reader.Close();
                //Sacar la direccion de la db
                SqlCommand getDireccion = new SqlCommand("select direccion from locker_en where locker=@id", connection);
                getDireccion.Parameters.AddWithValue("@id", loc.id);
                try
                {
                    loc.dir.id = Convert.ToInt32(getDireccion.ExecuteScalar());
                    loc.dir.Read();
                }
                catch(SqlException e)
                {
                    loc.dir.id = -1;
                }

                return true;
            }
            catch (SqlException e)
            {
                Console.WriteLine(e);
            }
            finally
            {
                connection.Close();
            }

            return false;
        }
    }
}
