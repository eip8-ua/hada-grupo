using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class CADInformes
    {
        string miConexion;
        public string MiConexion { get { return miConexion; } set { miConexion = value; } }

        public CADInformes()
        {

            //miConexion = ConfigurationManager.ConnectionStrings["miconexion"].ToString();
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
