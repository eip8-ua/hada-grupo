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
                ENPedido p1 = new ENPedido(1, new DateTime(1990, 1, 3), 1);
                ENPedido p2 = new ENPedido(2, new DateTime(1991, 1, 2), 2);
                ENPedido p3 = new ENPedido(3, new DateTime(1994, 1, 14), 3);
                List<ENPedido> lista = new List<ENPedido>();
                lista.Add(p1);
                lista.Add(p2);
                lista.Add(p3);
                //rptListPedidos.DataSource = ENPedido.ReadAll();
                rptListPedidos.DataSource = lista;
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