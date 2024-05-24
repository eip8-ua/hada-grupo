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
        //Devuelve los productos más populares
        static public List<ENProducto> getTopProducts() {

            CADInformes cad = new CADInformes();
            return cad.getTopProducts();
        }

        //Devuelve los clientes que más han gastado
        static public List<ENUsuario> getTopClients() {

            List<ENUsuario> ballenas = new List<ENUsuario>();
            CADInformes cad = new CADInformes();
            cad.getTopClients(ballenas);
            return ballenas;
        }

        //Devuelve la provincia más popular
        static public ENDireccion getMostPopularProvince() {

            ENDireccion direccion = new ENDireccion();
            CADInformes cad = new CADInformes();
            cad.getMostPopularProvince(direccion);
            return direccion;
        }

        //Devuelve el número de unidades compradas de producto
        static public int getNumberOfSoldUnits(ENProducto en) {

            CADInformes cad = new CADInformes();
            return cad.getNumberOfSoldUnits(en);
        }

        //Devuelve el número de pedidos de un usuario
        static public int getNumberOfOrders(ENUsuario en) {

            CADInformes cad = new CADInformes();
            return cad.getNumberOfOrders(en);
        }

        //Devuelve la puntuación media de un producto
        static public ENValoraciones getAverageProductRating(ENProducto en) {

            CADInformes cad = new CADInformes();
            return cad.getAverageProductRating(en);
        }

        //Devuelve un par de productos con una promocion activa
        static public List<ENProducto> getPairPromoProducts()
        {
            CADInformes cad = new CADInformes();
            return cad.getPairPromoProducts();
        }
    }
}
