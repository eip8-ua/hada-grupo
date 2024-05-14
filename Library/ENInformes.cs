using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    //Esta clase no posee ninguna propiedad, debido a que su función es simplemente la de hacer selects de las diferentes tablas
    //para conseguir la información de los informes
    public class ENInformes
    {
        static public List<ENProducto> getTopProducts() {

            return null;
        }

        static public List<ENUsuario> getTopClients() {

            return null;
        }

        static public ENDireccion getMostPopularProvince() {

            return null;
        }

        static public int getProductIncome(ENProducto en) {

            return 0;
        }

        static public int getNumberOfSoldUnits(ENProducto en) {

            return 0;
        }

        static public int getNumberOfOrders(ENUsuario en) {

            return 0;
        }

        static public ENValoraciones getAverageProductRating(ENProducto en) {

            return null;
        }
    }
}
