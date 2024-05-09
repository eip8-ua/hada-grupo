using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace Library
{
    class CADProducto
    {
        public string constring;
        public SqlConnection connection;

        public CADProducto()
        {

        }
        public bool Create(ENProducto prod)
        {
            string consu = "Insert into Producto("
        }

        public bool Delete(ENProducto prod)
        {
            return false;
        }
        public bool Update(ENProducto prod)
        {
            SqlConnection conn = null;


            string com = "Select * from Producto where id = " + prod.id;

            SqlCommand command = new SqlCommand(com, conn);



            try
            {
                conn = new SqlConnection(constring);
                conn.Open();
                DataSet bdvirtual = new 

                
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
        public bool Read(ENProducto prod)
        {
            SqlConnection conn = null;
           

            string com = "Select * from Producto where id = " + prod.id;

            SqlCommand command = new SqlCommand(com, conn);



            try
            {
                conn = new SqlConnection(constring);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    prod.nombre = reader["nombre"].ToString();
                    prod.popularidad = Convert.ToInt32(reader["popularidad"]);
                    prod.pvp = (float)reader["pvp"];
                    int ordinal = reader.GetOrdinal("url_image");
                    prod.url_image = reader.IsDBNull(ordinal) ? null : reader.GetString(ordinal);
                    ordinal = reader.GetOrdinal("descripcion");
                    prod.descripcion = reader.IsDBNull(ordinal) ? null : reader.GetString(ordinal);
                    prod.stock = Convert.ToInt32(reader["stock"]);
                    prod.promocion = Convert.ToInt32(reader["promocion"]);
                    return true;
                }
            }
            catch(SqlException)
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
