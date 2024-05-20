using System;
using System.Collections.Generic;
using Library;

namespace proyecto
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

        protected void RepeaterProductos_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {

        }
    }
}
