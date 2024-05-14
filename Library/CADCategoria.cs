using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Library
{
    class CADCategoria
    {
        public string constring;
        public SqlConnection connection;

        public CADCategoria()
        {

        }
        public bool Create(ENCategoria cat)
        {
            SqlConnection conn = null;

            string consu = "Insert into Categoria(tipo, descripcion) values (" + cat.tipo + ", " + cat.descripcion + ")";

            SqlCommand comm = new SqlCommand(consu, conn);

            try
            {
                conn = new SqlConnection(constring);
                conn.Open();

                comm.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                //error
                return false;

            }
            finally
            {
                conn.Close();
            }

            return true;
        }
        public bool Delete(ENCategoria cat)
        {
            SqlConnection conn = null;


            string consu = "Delete from Categoria where id =" + cat.tipo;

            SqlCommand comm = new SqlCommand(consu, conn);



            try
            {
                conn = new SqlConnection(constring);
                conn.Open();
                comm.ExecuteNonQuery();


            }
            catch (SqlException)
            {
                //ERROR
                return false;
            }
            finally
            {
                conn.Close();
            }
            return true;
        }
        public bool Update(ENCategoria cat)
        {
            SqlConnection conn = null;


            string consu = "Update Categoria set tipo =" + cat.tipo + ",descripcion =" + cat.descripcion + "where tipo =" + cat.tipo;

            SqlCommand comm = new SqlCommand(consu, conn);



            try
            {
                conn = new SqlConnection(constring);
                conn.Open();
                comm.ExecuteNonQuery();


            }
            catch (SqlException)
            {
                //ERROR
                return false;
            }
            finally
            {
                conn.Close();
            }
            return true;
        }
        public bool Read(ENCategoria cat)
        {
            SqlConnection conn = null;


            string com = "Select * from Categoria where id = " + cat.tipo;

            SqlCommand command = new SqlCommand(com, conn);



            try
            {
                conn = new SqlConnection(constring);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    cat.tipo = reader["tipo"].ToString();
                    cat.descripcion = reader["descripcion"].ToString();
                    
                    return true;
                }

               
            }
            catch (SqlException)
            {
                //ERROR
                return false;
            }
            finally
            {
                conn.Close();
            }
            return false;
        }
    }
}
