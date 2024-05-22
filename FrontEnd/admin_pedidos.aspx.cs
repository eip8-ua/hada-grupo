using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;

namespace FrontEnd
{
    public partial class admin_pedidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ENPedido ped = new ENPedido(0, new DateTime(2000, 10, 01), 0);

                rptListPedidos.DataSource = ped.listPedidos();
                rptListPedidos.DataBind();
            }


        }

        protected void EliminarPedido_click(object sender, EventArgs e)
        {
            string idStr = Request.QueryString["index"];

            // Convertir el valor a un número entero (si es necesario)
            if (int.TryParse(idStr, out int index))
            {
                ENPedido ped = new ENPedido(index, new DateTime(2000, 10, 01), 0);

                ped.Delete();
            }
        }
    }

}