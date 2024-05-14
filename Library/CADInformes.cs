using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    class CADInformes
    {
        //String para la conexión con la BD
        string miConexion;
        //Propiedad del string anterior
        public string MiConexion { get { return miConexion; } set { miConexion = value; } }

        public CADInformes()
        {

            miConexion = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        public bool getTopProducts(List<ENProducto> productos)
        {
            return true;
        }

        public bool getTopClients(List<ENUsuario> ballenas)
        {
            return true;
        }

        public bool getMostPopularProvince(ENDireccion direccion)
        {

            return true;
        }

        public bool getProductIncome(ENProducto en)
        {

            return true;
        }

        public bool getNumberOfSoldUnits(ENProducto en)
        {

            return true;
        }

        public bool getNumberOfOrders(ENUsuario en)
        {

            return true;
        }

        public bool getAverageProductRating(ENProducto en)
        {

            return true;
        }
    }
}
