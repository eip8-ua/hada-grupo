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
        public bool Create(ENCategoria cat)
        {
            connection = null;

            string consu = "Insert into Categoria(tipo, descripcion) values (" + cat.tipo + ", " + cat.descripcion + ")";

            SqlCommand comm = new SqlCommand(consu, connection);

            try
            {
                connection = new SqlConnection(constring);
                connection.Open();

                comm.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                //error
                return false;

            }
            finally
            {
                connection.Close();
            }

            return true;
        }
        public bool Delete(ENCategoria cat)
        {
            connection = null;


            string consu = "Delete from Categoria where id =" + cat.tipo;

            SqlCommand comm = new SqlCommand(consu, connection);



            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                comm.ExecuteNonQuery();


            }
            catch (SqlException)
            {
                //ERROR
                return false;
            }
            finally
            {
                connection.Close();
            }
            return true;
        }
        public bool Update(ENCategoria cat)
        {
            connection = null;


            string consu = "Update Categoria set tipo =" + cat.tipo + ",descripcion =" + cat.descripcion + "where tipo =" + cat.tipo;

            SqlCommand comm = new SqlCommand(consu, connection);



            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                comm.ExecuteNonQuery();


            }
            catch (SqlException)
            {
                //ERROR
                return false;
            }
            finally
            {
                connection.Close();
            }
            return true;
        }
        public ENCategoria Read(ENCategoria cat)
        {
            string com = "Select * from Categoria where tipo = @tipo";

            using (SqlConnection connection = new SqlConnection(constring))
            {
                SqlCommand command = new SqlCommand(com, connection);
                command.Parameters.AddWithValue("@tipo", cat.tipo);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        cat.tipo = reader["tipo"].ToString();
                        cat.descripcion = reader["descripcion"].ToString();
                        return cat;
                    }
                }
                catch (SqlException)
                {
                    //ERROR
                    return null;
                }
            }
            return null;
        }
    }
}
