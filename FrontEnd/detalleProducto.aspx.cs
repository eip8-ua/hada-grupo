using System;
using System.Web.UI;
using Library;

namespace proyecto
{
    public partial class detalleProducto : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string productId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(productId) && int.TryParse(productId, out int id))
                {
                    ENProducto producto = new ENProducto { id = id };
                    if (producto.Read())
                    {
                        imgProducto.Src = ResolveUrl("~/Images/Productos/" + producto.url_image);
                        litNombre.Text = producto.nombre;
                        litDescripcion.Text = producto.descripcion;
                        litPvp.Text = producto.pvp.ToString("F2") + " EUR";
                        litStock.Text = producto.stock.ToString();
                    }
                    else
                    {
                        // Manejar el caso donde el producto no se encontró
                        Response.Redirect("~/error.aspx");
                    }
                }
                else
                {
                    // Manejar el caso donde el ID no es válido
                    Response.Redirect("~/error.aspx");
                }
            }
        }
    }
}
