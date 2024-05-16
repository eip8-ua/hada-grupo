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
            connection = null;


            string com = "Select * from Categoria where id = " + cat.tipo;

            SqlCommand command = new SqlCommand(com, connection);



            try
            {
                connection = new SqlConnection(constring);
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
            finally
            {
                connection.Close();
            }
            return null;
        }

        public List<ENCategoria> listarCategoria()
        {
            connection = null;


            string com = "Select * from Categoria order by nombre [ASC]";

            SqlCommand command = new SqlCommand(com, connection);

            ENCategoria aux = new ENCategoria();

            List<ENCategoria> lista = new List<ENCategoria>();
            try
            {
                connection = new SqlConnection(constring);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    aux.tipo = reader["tipo"].ToString();
                    aux.descripcion = reader["descripcion"].ToString();

                    lista.Add(aux);
                }

                
            }
            catch (SqlException)
            {
                //ERROR
                return null;
            }
            finally
            {
                connection.Close();
            }
            return lista;
        }
    }
}
