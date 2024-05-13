using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
                    SqlCommand sql = new SqlCommand($"insert into Direccion(calle, cod_postal, ciudad, provincia, pais) values ('{dir.calle}','{dir.cod_postal}','{dir.ciudad}','{dir.provincia}','{dir.pais}')", connection);
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
        /// Borra una dirección de la base de datos
        /// </summary>
        /// <param name="dir">Objeto a borrar</param>
        /// <returns></returns>
        public bool Delete(ENDireccion dir)
        {
            return false;
        }

        public bool Update(ENDireccion dir)
        {
            return false;
        }
        public bool Read(ENDireccion dir)
        {
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
