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

        static public List<ENProducto> getAllProducts()
        {

            List<ENProducto> productos = new List<ENProducto>();
            CADInformes cad = new CADInformes();
            cad.getAllProducts(productos);
            return productos;
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
            return cad.getProductIncome(en);
        }

        static public int getNumberOfSoldUnits(ENProducto en) {

            CADInformes cad = new CADInformes();
            return cad.getNumberOfSoldUnits(en);
        }

        static public int getNumberOfOrders(ENUsuario en) {

            CADInformes cad = new CADInformes();
            return cad.getNumberOfOrders(en);
        }

        static public ENValoraciones getAverageProductRating(ENProducto en) {

            CADInformes cad = new CADInformes();
            return cad.getAverageProductRating(en);
        }
    }
}
