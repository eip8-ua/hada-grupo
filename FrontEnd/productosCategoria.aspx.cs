using System;
using System.Collections.Generic;
using System.Web.UI;
using Library;

namespace FrontEnd
{
    public partial class productosCategoria : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string categoria = Request.QueryString["categoria"];
                if (!string.IsNullOrEmpty(categoria))
                {
                    litCategoria.Text = categoria;
                    List<ENProducto> productos = ENProducto.productosPorColumna("categoria", categoria);
                    RepeaterProductos.DataSource = productos;
                    RepeaterProductos.DataBind();
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Obtener el ID del producto y la cantidad seleccionada
            int productId = Convert.ToInt32(Request.QueryString["id"]);
            int quantity = 1;
            List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();

            ENLinCarr enLinCarr = new ENLinCarr(1, quantity, 1, productId);

            cart.Add(enLinCarr);
            Session["Cart"] = cart;
        }
    }
}
