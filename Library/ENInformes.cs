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

            List<ENProducto> productosPopulares = new List<ENProducto>();
            CADInformes cad = new CADInformes();
            cad.getTopProducts(productosPopulares);
            return productosPopulares;
        }

        static public List<ENUsuario> getTopClients() {

            List<ENUsuario> ballenas = new List<ENUsuario>();
            CADInformes cad = new CADInformes();
            cad.getTopClients(ballenas);
            return ballenas;
        }

        static public ENDireccion getMostPopularProvince() {

            ENDireccion direccion = new ENDireccion();
            CADInformes cad = new CADInformes();
            cad.getMostPopularProvince(direccion);
            return direccion;
        }

        static public int getProductIncome(ENProducto en) {

            CADInformes cad = new CADInformes();
            if (true) return 0;
            else
                return -101;
        }

        static public int getNumberOfSoldUnits(ENProducto en) {

            return -101;
        }

        static public int getNumberOfOrders(ENUsuario en) {

            return -101;
        }

        static public ENValoraciones getAverageProductRating(ENProducto en) {

            return null;
        }
    }
}
