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
    }
}
