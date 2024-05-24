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
        private SqlConnection connection;
        ArrayList lista = new ArrayList();

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADUsuario()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
            connection = new SqlConnection(constring);
        }

        /// <summary>
        /// Método que inserta un Usuario en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Create(ENUsuario en)//(ENUsuario en)
        {
            bool inserted = false, exists = false;
            try
            {
                connection.Open();

                SqlCommand com = new SqlCommand("SELECT * FROM Usuario", connection);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["email"].ToString() == en.Email) exists = true;
                }
                dr.Close();
                if(!exists)
                {
                    SqlCommand ins = new SqlCommand($"insert into usuario (dni, email, nombre, apellidos, telefono, fecha_nac, admin, contrasena) values (@dni,@email,@nombre,@apellidos,@telefono,@fecha_nac,@admin,@contrasena); select SCOPE_IDENTITY();", connection);
                    ins.Parameters.AddWithValue("@dni", en.Dni);
                    ins.Parameters.AddWithValue("@email", en.Email);
                    ins.Parameters.AddWithValue("@nombre", en.Nombre);
                    ins.Parameters.AddWithValue("@apellidos", en.Apellidos);
                    ins.Parameters.AddWithValue("@fecha_nac", en.FNacimiento);
                    ins.Parameters.AddWithValue("@admin", en.Admin);
                    ins.Parameters.AddWithValue("@contrasena", en.Passwd);
                    

                    if (en.Tlfn == "")
                        ins.Parameters.AddWithValue("@telefono", DBNull.Value);
                    else
                        ins.Parameters.AddWithValue("@telefono", en.Tlfn);

                    ins.ExecuteNonQuery();
                    inserted = true;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("An error ocurred while inserting on the Database: The given email for the User is alredy used");
                }

                connection.Close();
            }
            catch (SqlException e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine(e.Message);
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
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
        /// Método que actualiza un Usuario en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Update(ENUsuario en)
        {
            bool exists = false, updated = false;
            int id = 0;
            try
            {

                connection.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM usuario;", connection);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["email"].ToString() == en.Email && dr.GetInt32(dr.GetOrdinal("id")) != en.Id)
                    {
                        exists = true;
                        break;
                    }

                }
                dr.Close();

                if (!exists)
                {

                    SqlCommand updt = new SqlCommand($"UPDATE usuario set dni = @dni,email = @email,nombre = @nombre,apellidos = @apellidos,telefono = @telefono,fecha_nac = @fecha_nac,admin = @admin,contrasena = @contrasena WHERE id = @id;", connection);
                    updt.Parameters.Add("@id", SqlDbType.Int).Value = en.Id;
                    updt.Parameters.Add("@dni", SqlDbType.NVarChar).Value = en.Dni;
                    updt.Parameters.Add("@email", SqlDbType.NVarChar).Value = en.Email;
                    updt.Parameters.Add("@nombre", SqlDbType.NVarChar).Value = en.Nombre;
                    updt.Parameters.Add("@apellidos", SqlDbType.NVarChar).Value = en.Apellidos;
                    updt.Parameters.Add("@fecha_nac", SqlDbType.Date).Value = en.FNacimiento;
                    updt.Parameters.Add("@admin", SqlDbType.Bit).Value = en.Admin;
                    updt.Parameters.Add("@contrasena", SqlDbType.NVarChar).Value = en.Passwd;

                    if (en.Tlfn == "")
                        updt.Parameters.AddWithValue("@telefono", DBNull.Value);
                    else
                        updt.Parameters.Add("@telefono", SqlDbType.NVarChar).Value = en.Tlfn;
                    updt.ExecuteNonQuery();
                    updated = true;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("An error ocurred while updating the Database: The given Email is alredy used by another user");
                }

                connection.Close();
            }
            catch (SqlException e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
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
        /// Método que lee los datos de un Usuario de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Read(ENUsuario en)
        {
            //DateTime fecha_aux;
            bool found = false;
            try
            {
                connection.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM usuario", connection);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["email"].ToString() == en.Email)
                    {
                        en.Id = dr.GetInt32(dr.GetOrdinal("id"));
                        en.Dni = dr["dni"].ToString();
                        en.Email = dr["email"].ToString();
                        en.Nombre = dr["nombre"].ToString();
                        en.Apellidos = dr["apellidos"].ToString();
                        en.Tlfn = dr["telefono"].ToString();
                        //DateTime.TryParse(dr["fecha_nac"].ToString(), out fecha_aux);
                        en.FNacimiento = dr.GetDateTime(dr.GetOrdinal("fecha_nac"));//fecha_aux;
                        en.Admin = dr.GetBoolean(dr.GetOrdinal("admin"));
                        found = true;
                        System.Diagnostics.Debug.WriteLine("Se ejecuta leer");
                        break;
                       
                    }
                }
                dr.Close();
            }
            catch (SqlException e)
            {
                //Falta indicar que ha habido un problema 
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
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
        /// Método que elimina un Usuario de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Delete(ENUsuario en)
        {
            bool exists = false, deleted = false;
            int id = 0;
            try
            {
                System.Diagnostics.Debug.WriteLine("Se inica borrar");
                connection.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM usuario", connection);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    if (dr.GetInt32(dr.GetOrdinal("id")) == en.Id)
                    {
                        exists = true;
                        id = dr.GetInt32(dr.GetOrdinal("id"));
                        System.Diagnostics.Debug.WriteLine("Existe");
                        break;
                    }
                }
                dr.Close();

                if (exists)
                {
                    SqlCommand dlt = new SqlCommand("DELETE FROM usuario WHERE id = '" + id + "';", connection);

                    dlt.ExecuteNonQuery();
                    deleted = true;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("An error ocurred while deleting on the Database: The given User (" + en.Id + ") doesn't exist");
                }

                connection.Close();
            }
            catch (SqlException e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
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
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool IsAdmin(ENUsuario en)
        {
            return true;
        }

        /// <summary>
        /// Método que lee el primer Usuario de la BD
        /// </summary>
        /// <param name="en">EN del usuario actual</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadFirst(ENUsuario en)
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
                    en.Dni = dr["dni"].ToString();
                    en.Email = dr["email"].ToString();
                    en.Nombre = dr["nombre"].ToString();
                    en.Apellidos = dr["apellidos"].ToString();
                    en.Tlfn = dr["telefono"].ToString();
                    //DateTime.TryParse(dr["fecha_nac"].ToString(), out fecha_aux);
                    en.FNacimiento = dr.GetDateTime(dr.GetOrdinal("fecha_nac"));//fecha_aux;
                    en.Admin = dr.GetBoolean(dr.GetOrdinal("admin"));
                    read = true;
                }
                else
                    System.Diagnostics.Debug.WriteLine("An error ocurred while reading the first element on the Database: There are no items on the Database");
                dr.Close();
            }
            catch (SqlException e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
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
        /// Método que lee el siguiente Usuario de la BD
        /// </summary>
        /// <param name="en">EN del usuario actual</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadNext(ENUsuario en)
        {
            bool found = false;
            try
            {
                connection.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM usuario", connection);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    if (dr.GetInt32(dr.GetOrdinal("id")) == en.Id)
                    {
                        if (dr.Read())
                        {
                            //Almacenamos en el EN de entrada los datos del nuevo elemento de testimonial
                            en.Id = dr.GetInt32(dr.GetOrdinal("id"));
                            en.Dni = dr["dni"].ToString();
                            en.Email = dr["email"].ToString();
                            en.Nombre = dr["nombre"].ToString();
                            en.Apellidos = dr["apellidos"].ToString();
                            en.Tlfn = dr["telefono"].ToString();
                            //DateTime.TryParse(dr["fecha_nac"].ToString(), out fecha_aux);
                            en.FNacimiento = dr.GetDateTime(dr.GetOrdinal("fecha_nac"));//fecha_aux;
                            en.Admin = dr.GetBoolean(dr.GetOrdinal("admin"));
                            found = true;
                            break;
                        }
                    }
                }
                dr.Close();
            }
            catch (SqlException e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
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
        /// Método que lee el anterior Usuario de la BD
        /// </summary>
        /// <param name="en">EN del usuario actual</param>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadPrev(ENUsuario en)
        {
            int id_aux = 0;
            string dni_aux = "", email_aux = "", nombre_aux = "", apellidos_aux = "", telefono_aux = "";
            DateTime fecha_nac_aux = DateTime.Now;
            bool admin_aux = false; ;
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
                        if (id_aux == -1)
                        {
                            dr.Close();
                            System.Diagnostics.Debug.WriteLine("An error ocurred while reading the previous element: The element doesn't exist");
                            return false;
                        }
                        else found = true;
                        break;
                    }

                    id_aux = dr.GetInt32(dr.GetOrdinal("id"));
                    dni_aux = dr["dni"].ToString();
                    email_aux = dr["email"].ToString();
                    nombre_aux = dr["nombre"].ToString();
                    apellidos_aux = dr["apellidos"].ToString();
                    telefono_aux = dr["telefono"].ToString();
                    //DateTime.TryParse(dr["fecha_nac"].ToString(), out fecha_aux);
                    fecha_nac_aux = dr.GetDateTime(dr.GetOrdinal("fecha_nac"));//fecha_aux;
                    admin_aux = dr.GetBoolean(dr.GetOrdinal("admin"));
                }
                dr.Close();
            }
            catch (SqlException e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            finally
            {
                connection.Close();
            }
            if (found)
            {
                en.Id = id_aux;
                en.Dni = dni_aux;
                en.Email = email_aux;
                en.Nombre = nombre_aux;
                en.Apellidos = apellidos_aux;
                en.Tlfn = telefono_aux;
                en.FNacimiento = fecha_nac_aux;
                en.Admin = admin_aux;
            }
            return found;
        }

        /// <summary>
        /// Obtiene un objeto que tenga el mismo email y contraseña que el objeto en
        /// </summary>
        /// <param name="en"></param>
        /// <returns>devuelve true o false dependiendo si ha encontrado el objeto o no</returns>
        public bool Read_Email_Con(ENUsuario en)
        {
            try
            {
                connection.Open();
                SqlCommand com = new SqlCommand("SELECT * FROM usuario where email=@email and contrasena=@con", connection);
                com.Parameters.AddWithValue("@con", en.Passwd);
                com.Parameters.AddWithValue("@email", en.Email);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    en.Id = Convert.ToInt32(dr["id"]);
                    en.Dni = dr["dni"].ToString();
                    en.Nombre = dr["nombre"].ToString();
                    en.Apellidos = dr["apellidos"].ToString();
                    en.Tlfn = dr["telefono"].ToString();
                    en.FNacimiento = dr.GetDateTime(dr.GetOrdinal("fecha_nac"));//fecha_aux;
                    en.Admin = dr.GetBoolean(dr.GetOrdinal("admin"));
                    
                    dr.Close();
                    return true;
                }

            }
            catch (SqlException e)
            {
                //Falta indicar que ha habido un problema 
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
                return false;
            }
            finally
            {
                connection.Close();
            }
            return false;
        }

        /// <summary>
        /// Método Read a partir de un ID de usuario
        /// </summary>
        /// <param name="en">EN del usuario actual</param>
        /// <returns>True si lo ha hecho correctamente; False si no</returns>
        public bool Read_Id(ENUsuario en)
        {
            try
            {
                connection.Open();
                SqlCommand com = new SqlCommand("select * from usuario where id=@id", connection);
                com.Parameters.AddWithValue("@id", en.Id);
                SqlDataReader reader = com.ExecuteReader();

                if (reader.Read())
                {
                    en.Email = reader["email"].ToString();
                    en.Nombre = reader["nombre"].ToString();
                    en.Apellidos = reader["apellidos"].ToString();
                    en.Dni = reader["dni"].ToString();
                    en.Passwd = reader["contrasena"].ToString();
                    en.Tlfn = reader["telefono"].ToString();
                    en.FNacimiento = reader.GetDateTime(reader.GetOrdinal("fecha_nac"));//fecha_aux;
                    en.Admin = reader.GetBoolean(reader.GetOrdinal("admin"));

                    return true;
                }
            }
            catch (SqlException e)
            {
                System.Diagnostics.Debug.WriteLine(e);
            }
            catch (Exception e)
            {
                //Falta indicar que ha habido un problema
                System.Diagnostics.Debug.WriteLine("An error ocurred while accessing the Database: ", e.Message);
                connection.Close();
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
