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

        public void getTopProducts()
        {

        }

        public void getTopClients()
        {

        }

        public void getMostPopularProvince()
        {


        }

        public void getProductIncome(ENProducto en)
        {


        }

        public void getNumberOfSoldUnits(ENProducto en)
        {


        }

        public void getNumberOfOrders(ENUsuario en)
        {

  
        }

        public void getAverageProductRating(ENProducto en)
        {

        }
    }
}
