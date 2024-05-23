using System;
using System.Web.UI;
using Library; // Asegúrate de importar el espacio de nombres donde están definidas las clases ENProducto y CADProducto

namespace FrontEnd
{
    public partial class ProductoSeleccionado : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar si se pasó un ID de producto en la URL
                if (Request.QueryString["id"] != null)
                {
                    int productId = Convert.ToInt32(Request.QueryString["id"]);

                    // Obtener el producto por su ID desde la base de datos
                    ENProducto producto = new ENProducto { id = productId };
                    if (producto.Read())
                    {
                        // Si se encuentra el producto, asignarlo a los controles de la página para mostrar la información
                        lblNombreProducto.Text = producto.nombre;
                        lblDescripcionProducto.Text = producto.descripcion;
                        lblPrecioProducto.Text = producto.pvp.ToString("N2") + " EUR";
                        imgProducto.ImageUrl = producto.url_image;
                    }
                    else
                    {
                        // Manejar el caso en que no se encuentre el producto
                        Response.Redirect("productos.aspx"); // Redirigir a la página de productos
                    }
                }
                else
                {
                    // Manejar el caso en que no se haya proporcionado un ID de producto en la URL
                    Response.Redirect("productos.aspx"); // Redirigir a la página de productos
                }



                //Añadir valoraciones
                ENValoraciones val = new ENValoraciones();
                val.Producto.id = Convert.ToInt32(Request.QueryString["id"]);
                val.Producto.Read();
                rptListReviews.DataSource = val.Get_All_Product_Reviews();
                rptListReviews.DataBind();
            }
        }
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Obtener el ID del producto y la cantidad seleccionada
            int productId = Convert.ToInt32(Request.QueryString["id"]);
            int quantity = Convert.ToInt32(ddlQuantity.SelectedValue);

            

            Response.Redirect("shopping_cart.aspx");
        }

    }
}
