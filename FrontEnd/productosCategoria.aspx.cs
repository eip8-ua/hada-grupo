using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Library;

namespace FrontEnd
{
    public partial class productosCategoria : System.Web.UI.Page
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

        protected void btnAddToCart_Command(object sender, CommandEventArgs e)
        {
            // Obtener el ID del producto y la cantidad seleccionada
            int productId = Convert.ToInt32(e.CommandArgument);
            Console.WriteLine(productId);
            int quantity = 1;
            List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();

            ENLinCarr existingProduct = cart.Find(p => p.Producto == productId);

            if (existingProduct != null)
            {
                existingProduct.Cantidad += quantity;
                existingProduct.Carrito = -1;
            }
            else
            {
                cart.Add(new ENLinCarr(1, quantity, 1, productId));
            }

            Session["Cart"] = cart;
        }
    }
}
