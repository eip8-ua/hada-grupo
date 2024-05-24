using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Library;

namespace FrontEnd
{
    public partial class estadisticas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if(!IsPostBack)
            {
                User_Stats();
                Best_Province();
                Product_Stats();
            }

        }

        //Crea los bloques y carga la información relacionada con los mejores usuarios
        protected void User_Stats()
        {
            //Cogemos los mejores clientes
            List<ENUsuario> usuarios = ENInformes.getTopClients();

            //Contador para tener el cuenta en número del cliente
            int contador = 1;

            //Bucle para crear los bloques para todos los clientes
            foreach(ENUsuario usuario in usuarios)
            {
                //Bloque div que lo envuelve todo
                HtmlGenericControl div = new HtmlGenericControl("div");
                div.ID = "TopUser" + contador.ToString();
                div.Attributes["class"] = "top_user";

                //Párrafo con el email, nombre, apellidos, y número de pedidos
                HtmlGenericControl p1 = new HtmlGenericControl("p");
                p1.InnerText = "Email: " + usuario.Email + ",   Nombre: " + usuario.Nombre + ",   Apellidos: " + 
                    usuario.Apellidos + ",   Pedidos: " + ENInformes.getNumberOfOrders(usuario).ToString() + ", Total gastado: " + usuario.Tlfn + " €";
                div.Controls.Add(p1);

                users.Controls.Add(div);
                contador++;
            }

        }

        //Crea los bloques con la información de la provincia más popular
        protected void Best_Province()
        {
            //Creamos los bloques div, p y la dirección de la que vamos a coger la información
            HtmlGenericControl div = new HtmlGenericControl("div");
            HtmlGenericControl p1 = new HtmlGenericControl("p");
            ENDireccion dir = new ENDireccion(ENInformes.getMostPopularProvince());

            //Le asignames ids a los bloques creados y el texto correspondiente
            div.ID = "MostPopularProvinceWrap";
            p1.ID = "provinceText";
            p1.InnerText = dir.provincia + " es la provincia más popular con " + dir.calle + " pedidos";

            //Añadimos el p al div, y el div al bloque province
            div.Controls.Add(p1);
            province.Controls.Add(div);
        }

        //Crea los bloques con la información de los productos
        protected void Product_Stats()
        {

            //Cogemos todos los productos
            List<ENProducto> productos = ENProducto.ObtenerTodosLosProductos();

            //Contador para tener el cuenta en número del producto
            int contador = 1;

            //Bucle para crear los bloques para todos los productos
            foreach (ENProducto producto in productos)
            {
                //Bloque div que lo envuelve todo
                HtmlGenericControl div = new HtmlGenericControl("div");
                div.ID = "Product" + contador.ToString();
                div.Attributes["class"] = "product";

                //Párrafo con el email, nombre, número de unidades vendidas, puntuación promedia
                HtmlGenericControl p1 = new HtmlGenericControl("p");
                p1.InnerText = "ID: " + producto.id.ToString();
                div.Controls.Add(p1);

                HtmlGenericControl p2 = new HtmlGenericControl("p");
                p2.InnerText = "Nombre: " + producto.nombre;
                div.Controls.Add(p2);

                HtmlGenericControl p3 = new HtmlGenericControl("p");
                p3.InnerText = "Número de unidades vendidas: " + ENInformes.getNumberOfSoldUnits(producto).ToString();
                div.Controls.Add(p3);

                HtmlGenericControl p4 = new HtmlGenericControl("p");
                p4.InnerText = "Puntuación media: " + ENInformes.getAverageProductRating(producto).Puntuacion.ToString();
                div.Controls.Add(p4);

                if (contador % 3 == 1) column1.Controls.Add(div);
                if (contador % 3 == 2) column2.Controls.Add(div);
                if (contador % 3 == 0) column3.Controls.Add(div);

                contador++;
            }

        }
    }
}