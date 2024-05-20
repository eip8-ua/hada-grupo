using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    class CADPromociones
    {
        //String para la conexión con la BD
        string miConexion;
        //Propiedad del string anterior
        public string MiConexion { get { return miConexion; } set { miConexion = value; } }

        //Constructor por defecto, solo establecemos el string interno para que tenga esta conexión
        public CADPromociones() {

           miConexion = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        //Método que recibe una lista vacía de promociones y devuelve
        public bool getPromociones(List<ENPromociones> promos)
        {
            //Declaramos la conexión
            SqlConnection connection = new SqlConnection(miConexion);

            try
            {
                //Abrimos la conexión
                connection.Open();

                //Creamos el comando con la conexión a nuestra BD y la ejecutamos
                SqlCommand command = new SqlCommand("SELECT * FROM Promocion", connection);
                SqlDataReader dr = command.ExecuteReader();

                //Se trata de un bucle while para conseguir la información de todas las filas del data reader e ir guardándolas una a una
                //en la lista para los promociones
                while(dr.Read())
                {   //Declaramos variables
                    int rId, rDescuento;
                    bool rDisponibilidad;
                    ENPromociones promocion = new ENPromociones();

                    //Conversión de los valores a sus respectivos tipos de datos
                    int.TryParse(dr["id"].ToString(), out rId);
                    int.TryParse(dr["descuento"].ToString(), out rDescuento);
                    bool.TryParse(dr["disponibilidad"].ToString(), out rDisponibilidad);

                    //Pasamos los valores a promocion
                    promocion.MiId = rId;
                    promocion.Descuento = rDescuento;
                    promocion.Disponibilidad = rDisponibilidad;

                    //Añadimos la promoción leída a la lista
                    promos.Add(promocion);
                }

                return true;

                //En caso de error
            } catch (SqlException ex) {
                Console.WriteLine("Error con la parte SQL en CADPromociones: {0}", ex.Message);
                return false;
            } finally
            {
                //Cerramos la conexión
                connection.Close();
            }
        }

        //Método que devuelve una promoción determinada en base a una id pasada
        public ENPromociones read(int idd)
        {
            //Declaramos la conexión y la promoción
            ENPromociones promo = new ENPromociones();
            SqlConnection connection = new SqlConnection(miConexion);

            try
            {
                //Abrimos la conexión
                connection.Open();

                //Creamos el comando con la conexión a nuestra BD y la ejecutamos
                SqlCommand command = new SqlCommand("SELECT * FROM Promocion WHERE id = " + idd.ToString(), connection);
                SqlDataReader dr = command.ExecuteReader();

                if(dr.Read())
                {
                    //Variables temporales para pasar los valores al objeto promo
                    int rId, rDescuento;
                    bool rDisponibilidad;

                    //Conversión de los valores a sus respectivos tipos de datos
                    int.TryParse(dr["id"].ToString(), out rId);
                    int.TryParse(dr["descuento"].ToString(), out rDescuento);
                    bool.TryParse(dr["disponibilidad"].ToString(), out rDisponibilidad);

                    //Pasamos los valores a promocion
                    promo.MiId = rId;
                    promo.Descuento = rDescuento;
                    promo.Disponibilidad = rDisponibilidad;
                }

                return promo;
                //En caso de error
            } catch (SqlException ex)
            {
                Console.WriteLine("Error con la parte SQL en CADPromociones: {0}", ex.Message);
                return promo;

            } finally
            {
                //Cerramos la conexión
                connection.Close();
            }
        }

        //Método que crea una promoción en la base de datos con la información pasada por el EN
        public void create(ENPromociones promo) { }

        //Método que elimina una promoción de la base de datos con los datos pasados por el EN
        public void delete(ENPromociones promo) { }
    }
}
