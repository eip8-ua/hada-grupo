using System;
using System.Collections;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace Library
{
    public class CADUsuario
    {
        private string constring { get; set; }
        //private SqlConnection connection;
        ArrayList lista = new ArrayList();

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADUsuario()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        /// <summary>
        /// Método que inserta un Usuario en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public String create()//(ENUsuario en)
        {
            //Console.WriteLine("hola");
            
            SqlConnection connection = new SqlConnection(constring);
            String primerValor = "";
            
            try
            {
                connection.Open();
               
                SqlCommand com = new SqlCommand("Select * from producto", connection);
                SqlDataReader dr = com.ExecuteReader();
                //while (dr.Read())
                //{
                //  lista.Add(dr["usuario"].ToString());
                //}
                if(dr.Read())
                { primerValor = dr["nombre"].ToString(); }
                
                dr.Close();
                connection.Close();
            }
            catch(Exception e)
            {
                
            }
           
            return primerValor;
        }
        /// <summary>
        /// Método que actualiza un Usuario en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public bool update(ENUsuario en)
        {
            return true;
        }
        /// <summary>
        /// Método que lee los datos de un Usuario de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public bool read(ENUsuario en)
        {
            return true;
        }
        /// <summary>
        /// Método que elimina un Usuario de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public bool delete(ENUsuario en)
        {
            return true;
        }
        /// <summary>
        /// Método que inserta un Usuario en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public bool admin(ENUsuario en)
        {
            return true;
        }
    }
}
