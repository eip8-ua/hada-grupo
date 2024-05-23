using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Library;

namespace FrontEnd
{
    public partial class productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
            }
        }

        private void CargarProductos()
        {
            List<ENProducto> productos = ENProducto.ObtenerTodosLosProductos();
            RepeaterProductos.DataSource = productos;
            RepeaterProductos.DataBind();
        }

        protected void RepeaterProductos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                // Obtener la ID del producto desde el CommandArgument
                int productId = Convert.ToInt32(e.CommandArgument);

                // Aquí puedes agregar la lógica para añadir el producto al carrito
                // Por ejemplo:
                // AddToCart(productId);

                // Mostrar un mensaje o redirigir a otra página
                Response.Write("Producto añadido al carrito: " + productId);
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
            }
            else
            {
                cart.Add(new ENLinCarr(1, quantity, 1, productId));
            }

            Session["Cart"] = cart;
        }
    }
}
