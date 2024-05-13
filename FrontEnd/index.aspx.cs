using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;

namespace proyecto
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.popProduct2.Visible = false;
            this.popProduct3.Visible = false;
            this.ButtonSeeMore.Visible = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/contact_us.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/testimonial.aspx");
        }

        protected void ButtonSeeMore_Click(object sender, EventArgs e)
        {
            this.popProduct2.Visible = true;
            this.popProduct3.Visible = true;
            this.ButtonSeeMore.Visible = false;
        }

        protected void getPopularProducts()
        {
            List<ENProducto> lista = ENInformes.getTopProducts();
            foreach (ENProducto producto in lista) {
                //Código para añadir los productos
            }

        }

        protected void contact_Button_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/contact_us.aspx");
        }

        protected void explore_more_promotions_Button_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/productos.aspx");
        }

        protected void testimonies_Button_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/testimonial.aspx");
        }
    }
}