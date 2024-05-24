using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    public class CADContactUs
    {
        public string constring;
        private SqlConnection connection;
        public CADContactUs()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();


        }

        public bool Create(ENContactUs en)
        {
            string consu = "Insert into Contact_Us(nombre,email,telefono,mensaje) values (@nombre,@email,@telefono,@mensaje);";

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                SqlCommand comm = new SqlCommand(consu, connection);
                if (en.nombre == null)
                    comm.Parameters.AddWithValue("@nombre", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@nombre", en.nombre);
                if (en.email == null)
                    comm.Parameters.AddWithValue("@email", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@email", en.email);
                if (en.telefono == null)
                    comm.Parameters.AddWithValue("@telefono", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@telefono", en.email);
                if (en.mensaje == null)
                    comm.Parameters.AddWithValue("@mensaje", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@mensaje", en.email);

                
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




        public bool Read(ENContactUs en)
        {

            {
                string consu = "Select * from Contact_Us where nombre = @nombre; select SCOPE_IDENTITY();";

                try
                {
                    connection = new SqlConnection(constring);
                    connection.Open();
                    SqlCommand comm = new SqlCommand(consu, connection);

                    SqlCommand command = new SqlCommand(consu, connection); // Crear el comando SQL con la consulta y la conexión
                    command.Parameters.AddWithValue("@nombre", en.nombre); // Asignar el valor del parámetro

                    connection.Open(); // Abrir la conexión
                    SqlDataReader reader = command.ExecuteReader(); // Ejecutar la consulta SQL

                    if (reader.Read()) // Verificar si se encontró un registro
                    {
                        en.email = reader["email"].ToString();

                        en.telefono = reader["telefono"].ToString();

                        en.mensaje = reader["mensaje"].ToString();
                    }

                    else return false;

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
                return true;

            }
        }

        public bool Update(ENContactUs en)
        {

            string consu = "Update Contact_Us set email=@email,telefono=@telefono,mensaje=@mensaje where nombre=@nombre";

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                SqlCommand comm = new SqlCommand(consu, connection);

                if (en.nombre == null)
                    comm.Parameters.AddWithValue("@nombre", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@nombre", en.nombre);
                if (en.email == null)
                    comm.Parameters.AddWithValue("@email", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@email", en.email);
                if (en.telefono == null)
                    comm.Parameters.AddWithValue("@telefono", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@telefono", en.email);
                if (en.mensaje == null)
                    comm.Parameters.AddWithValue("@mensaje", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@mensaje", en.email);

                return comm.ExecuteNonQuery() > 0;
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

        public bool Delete(ENContactUs en)
        {
            SqlConnection connection = null;

            string consu = "Delete from Contact_Us where nombre =@nombre";



            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                SqlCommand comm = new SqlCommand(consu, connection);
                if (en.nombre == null)
                    comm.Parameters.AddWithValue("@nombre", DBNull.Value);
                else
                    comm.Parameters.AddWithValue("@nombre", en.nombre);

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
    }
}
