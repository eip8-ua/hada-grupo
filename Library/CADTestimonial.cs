using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Library
{
    [Serializable]
    public class CADTestimonial
    {
        private string constring { get; set; }
        SqlConnection connection;
        private List<ENTestimonial> testimonios;


        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADTestimonial() 
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
            connection = new SqlConnection(constring);
            testimonios = ObtenerTestimonios();

        }

        /// <summary>
        /// Método que inserta el Testimonio en la BD
        /// </summary>
        /// <param name="en">EN del testimonio</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Create(ENTestimonial en)
        {
            bool exists = false, inserted = false;
            int nextId = 0;
            try
            {
                connection.Open();

                SqlCommand com = new SqlCommand("SELECT * FROM TESTIMONIAL", connection);
                SqlDataReader dr = com.ExecuteReader();
                while(dr.Read())
                {
                    if (dr["mensaje"].ToString() == en.Message) exists = true;
                    nextId = dr.GetInt32(dr.GetOrdinal("id"));
                }
                dr.Close();
                nextId += 1;
                if(!exists)
                {
                    SqlCommand auth = new SqlCommand("SET IDENTITY_INSERT testimonial ON", connection);
                    SqlCommand ins = new SqlCommand("INSERT INTO Testimonial (id, mensaje) VALUES (" + nextId + ", '" + en.Message + "');", connection);
                    SqlCommand deauth = new SqlCommand("SET IDENTITY_INSERT Testimonial ON", connection);

                    auth.ExecuteNonQuery();
                    ins.ExecuteNonQuery();
                    deauth.ExecuteNonQuery();
                    inserted = true;
                }
                else
                {
                    Console.WriteLine("An error ocurred while inserting on the Database: The given message for the Testimonial alredy exists");
                }

                connection.Close();
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                Console.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            finally
            {
                connection.Close();
            }
            return inserted;
        }

        /// <summary>
        /// Método que actualiza el Testimonio en la BD
        /// </summary>
        /// <param name="en">EN del testimonio</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Update(ENTestimonial en)
        {
            bool exists = false, updated = false;
            try
            {
                connection.Open();

                SqlCommand com = new SqlCommand("SELECT * FROM TESTIMONIAL", connection);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    if (dr.GetInt32(dr.GetOrdinal("id")) == en.Id) exists = true;
                }
                dr.Close();

                if (exists)
                {
                    SqlCommand updt = new SqlCommand("UPDATE testimonial mensaje = '" + en.Message + "' WHERE id = '" + dr.GetInt32(dr.GetOrdinal("id")) + "';", connection);

                    updt.ExecuteNonQuery();
                    updated = true;
                }
                else
                {
                    Console.WriteLine("An error ocurred while updating the Database: The given Testimonial doesn't exist");
                }

                connection.Close();
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                Console.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            finally
            {
                connection.Close();
            }
            return updated;
        }

        /// <summary>
        /// Método que lee el Testimonio de la BD
        /// </summary>
        /// <param name="en">EN del testimonio</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Read(ENTestimonial en)
        {
            bool found = false;
            try
            {
                connection.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM TESTIMONIAL", connection);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    if (dr.GetInt32(dr.GetOrdinal("id")) == en.Id)
                    {
                        en.Message = dr["mensaje"].ToString();
                        found = true;
                        break;
                    }
                }
                dr.Close();
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema 
                Console.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            finally
            {
                connection.Close();
            }
            return found;
        }

        /// <summary>
        /// Método que elimina el Testimonio de la BD
        /// </summary>
        /// <param name="en">EN del testimonio</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Delete(ENTestimonial en)
        {
            bool exists = false, deleted = false;
            try
            {
                connection.Open();

                SqlCommand com = new SqlCommand("SELECT * FROM TESTIMONIAL", connection);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    if (dr.GetInt32(dr.GetOrdinal("id")) == en.Id) exists = true;
                }
                dr.Close();

                if (exists)
                {
                    SqlCommand dlt = new SqlCommand("DELETE FROM testimonial WHERE id = '" + dr.GetInt32(dr.GetOrdinal("id")) + "';", connection);

                    dlt.ExecuteNonQuery();
                    deleted = true;
                }
                else
                {
                    Console.WriteLine("An error ocurred while deleting on the Database: The given Testimonial doesn't exist");
                }

                connection.Close();
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                Console.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            finally
            {
                connection.Close();
            }
            return deleted;
        }

        // *****     MÉTODOS EXTRA     *****

        /// <summary>
        /// Método que lee el primer Testimonio de la BD
        /// </summary>
        /// <param name="en">EN del testimonio actual</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadFirst(ENTestimonial en)
        {
            bool firstExists = false, read = false;
            try
            {
                connection.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM TESTIMONIAL", connection);
                SqlDataReader dr = com.ExecuteReader();
                firstExists = dr.Read();
                if (firstExists)
                {                   
                    //Almacenamos en el EN de entrada los datos del nuevo elemento de testimonial
                    en.Id = dr.GetInt32(dr.GetOrdinal("id"));
                    en.Message = dr["mensaje"].ToString();
                    read = true;
                }
                else
                    Console.WriteLine("An error ocurred while reading the first element on the Database: There are no items on the Database");
                dr.Close();
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                Console.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            finally
            {
                connection.Close();
            }
            return read;
        }

        /// <summary>
        /// Método que lee el siguiente Testimonio de la BD
        /// </summary>
        /// <param name="en">EN del testimonio actual</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadNext(ENTestimonial en)
        {
            for (int i = 0; i < testimonios.Count - 1; i++)
            {
                if (testimonios[i].Id == en.Id)
                {
                    en.Id = testimonios[i + 1].Id;
                    en.Message = testimonios[i + 1].Message;
                    return true;
                }
            }
            return false; // No se encontró el testimonio o ya es el último
        }

        /// <summary>
        /// Método que lee el anterior Testimonio de la BD
        /// </summary>
        /// <param name="en">EN del testimonio actual</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadPrev(ENTestimonial en)
        {
            for (int i = 1; i < testimonios.Count; i++)
            {
                if (testimonios[i].Id == en.Id)
                {
                    en.Id = testimonios[i - 1].Id;
                    en.Message = testimonios[i - 1].Message;
                    return true;
                }
            }
            return false; // No se encontró el testimonio o ya es el primero
        }
        /// <summary>
        /// Método que obtiene todos los testimonios de la base de datos
        /// </summary>
        /// <returns>Una lista de testimonios</returns>
        // Modify your ObtenerTestimonios method to work with ENTestimonial
        public List<ENTestimonial> ObtenerTestimonios()
        {
            List<ENTestimonial> testimonios = new List<ENTestimonial>();
            try
            {
                connection.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM Testimonial", connection);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    ENTestimonial testimonio = new ENTestimonial
                    {
                        Id = dr.GetInt32(dr.GetOrdinal("id")),
                        Message = dr.GetString(dr.GetOrdinal("mensaje"))
                    };
                    testimonios.Add(testimonio);
                }
                dr.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine("An error occurred while accessing the Database: " + e.Message);
            }
            finally
            {
                connection.Close();
            }
            return testimonios;
        }

    }
}
