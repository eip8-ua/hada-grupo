using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Library;

namespace proyecto
{

    public partial class index : System.Web.UI.Page
    {
        //Evento al cargar la página
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { 
                getPopularProducts(2);
                see_more_pop_products.Visible = true;
            }
            getPairPromoProducts();
        }

        //Evento al pulsar el botón de contáctanos
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/contact_us.aspx");
        }

        //Evento al pulsar el botón de testimonial
        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/testimonial.aspx");
        }

        //Método para coger una cantidad de productos populares igual al entero pasado
        protected void getPopularProducts(int num)
        {
            List<ENProducto> lista = ENInformes.getTopProducts();
            int contador = 1;
            foreach(ENProducto producto in lista) {

                //Creamos el div que contendrá el producto
                HtmlGenericControl div = new HtmlGenericControl("div");
                div.ID = "popular_product" + contador.ToString();

                //Creamos la imagen del producto
                Image productImage = new Image();
                productImage.ID = "popular_product" + contador.ToString() + "_Image";
                productImage.ImageUrl = producto.url_image + ".jpg";
                productImage.AlternateText = "Imagen producto";
                productImage.Width = 200;
                productImage.Height = 200;
                div.Controls.Add(productImage);

                //Creamos las cadenas de texto del nombre, descripción, y la que contiene el precio
                HtmlGenericControl p1 = new HtmlGenericControl("p");
                p1.InnerText = producto.nombre;
                div.Controls.Add(p1);

                HtmlGenericControl p3 = new HtmlGenericControl("p");
                if(producto.promocion.Descuento > 0 && producto.promocion.Disponibilidad) 
                    p3.InnerText = "Precio rebajado: " + (producto.pvp - (producto.promocion.Descuento/100) * producto.pvp).ToString() + " €";
                else
                    p3.InnerText = "Precio: " + (producto.pvp - producto.promocion.Descuento * producto.pvp).ToString() + " €";
                div.Controls.Add(p3);

                //Creamos un botón para (ir a la página del producto o añadirlo al carrito de la compra)
                Button boton_pop_product = new Button();
                boton_pop_product.ID = "pop_Button" + contador.ToString();
                boton_pop_product.Text = "Ver producto";
                boton_pop_product.CssClass = "ButtonStyle2";
                boton_pop_product.CommandArgument = producto.id.ToString();
                boton_pop_product.Click += new EventHandler(Boton_pop_product_Click);
                div.Controls.Add(boton_pop_product);

                if (contador % 2 != 0)
                {
                    div.Attributes["class"] = "left_popular_column";
                    popular_column1.Controls.Add(div);
                }
                else {
                    div.Attributes["class"] = "right_popular_column";
                    popular_column2.Controls.Add(div); 
                }
                contador++;
                if (contador > num) break;
            }
        }

        //Evento para llevarle a la página del producto cuando pulsan el botón de ver página
        protected void Boton_pop_product_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string cadena = "producto-seleccionado.aspx?id=" + btn.CommandArgument;
            Response.Redirect(cadena);
        }

        //Evento al pulsar el botón contáctanos
        protected void contact_Button_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/contact_us.aspx");
        }

        //Evento al pulsar el botón en promociones
        protected void explore_more_promotions_Button_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/productos.aspx");
        }

        //Evento al pulsar el botón en promociones
        protected void testimonies_Button_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/testimonial.aspx");
        }

        //Evento al pulsar el botón de ver más en productos populares
        protected void see_more_pop_products_Click(object sender, EventArgs e)
        {
            getPopularProducts(10);
            see_more_pop_products.Visible = false;

        }

        //Evento para conseguir dos productos que tienen una promoción
        protected void getPairPromoProducts()
        {
            List<ENProducto> pareja = ENInformes.getPairPromoProducts();
            int contador = 1;
            foreach (ENProducto producto in pareja)
            {
                //Creamos el div que contendrá el producto
                HtmlGenericControl div = new HtmlGenericControl("div");
                div.ID = "promo_product" + contador.ToString();
                div.Attributes["class"] = "promo_product";

                //Creamos la imagen del producto
                Image productImage = new Image();
                productImage.ID = "promo_product" + contador.ToString() + "_Image";
                productImage.ImageUrl = producto.url_image + ".jpg";
                productImage.AlternateText = "Imagen producto";
                productImage.Width = 200;
                productImage.Height = 200;
                div.Controls.Add(productImage);

                //Creamos las cadenas de texto del nombre, y la que contiene el precio
                HtmlGenericControl p1 = new HtmlGenericControl("p");
                p1.InnerText = producto.nombre;
                div.Controls.Add(p1);

                HtmlGenericControl p3 = new HtmlGenericControl("p");
                if (producto.promocion.Descuento > 0 && producto.promocion.Disponibilidad)
                    p3.InnerText = "Precio rebajado: " + (producto.pvp - (producto.promocion.Descuento / 100) * producto.pvp).ToString() + " €";
                else
                    p3.InnerText = "Precio: " + producto.pvp.ToString() + " €";
                div.Controls.Add(p3);
                if (contador % 2 != 0) right_promotions1.Controls.Add(div);
                else right_promotions2.Controls.Add(div);
                contador++;
            }
        }
    }
}