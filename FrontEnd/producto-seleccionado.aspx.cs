using System;
using System.Web.UI;
using Library; // Asegúrate de importar el espacio de nombres donde están definidas las clases ENProducto y CADProducto
using System.Collections.Generic;
using System.Linq;

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
                        imgProducto.ImageUrl = producto.url_image;

                        // Mostrar el precio original y el precio con descuento si aplica
                        if (producto.promocion != null && producto.promocion.Descuento > 0)
                        {
                            lblPrecioOriginal.Text = producto.pvp.ToString("N2") + " EUR";
                            lblPrecioOriginal.CssClass = "original-price"; // Aplicar clase solo si hay descuento
                            lblPrecioRebajado.Text = (producto.pvp * (1 - producto.promocion.Descuento / 100)).ToString("N2") + " EUR";
                            lblPrecioRebajado.Visible = true;
                        }
                        else
                        {
                            lblPrecioOriginal.Text = producto.pvp.ToString("N2") + " EUR";
                            lblPrecioOriginal.CssClass = ""; // Remover cualquier clase si no hay descuento
                            lblPrecioRebajado.Visible = false; // Ocultar etiqueta de precio rebajado si no hay descuento
                        }
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



                Add_Valoraciones();
            }
        }
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Obtener el ID del producto y la cantidad seleccionada
            int productId = Convert.ToInt32(Request.QueryString["id"]);
            int quantity = Convert.ToInt32(ddlQuantity.SelectedValue);
            List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();

            ENLinCarr existingProduct = cart.Find(p => p.Producto == productId);

            if (existingProduct != null)
            {
                existingProduct.Carrito = -1;
                existingProduct.Cantidad += quantity;
            }
            else
            {
                cart.Add(new ENLinCarr(1, quantity, 1, productId));
            }

            Session["Cart"] = cart;
        }

        protected void Add_Valoraciones()
        {
            ENValoraciones val = new ENValoraciones();
            val.Producto.id = Convert.ToInt32(Request.QueryString["id"]);
            val.Producto.Read();
            List<ENValoraciones> vals = val.Get_All_Product_Reviews();

            foreach(ENValoraciones i in vals)
            {
                string stars = "";
                for (int j = 0; j < i.Puntuacion; j++)
                {
                    stars += "★";
                }
                string desc = String.IsNullOrEmpty(i.Descripcion) ? "(Sin comentario)" : i.Descripcion;
                var rowDiv = new LiteralControl
                {

                    Text = $@"<div class='row'>
                                <div class='email-puntuacion'>{i.Usuario.Email}    {stars}</div>
                                <div class='descripcion'>{desc}</div>
                               </div>"

                };
                valoraciones_container.Controls.Add(rowDiv);
                
            }
        }
    }
}
