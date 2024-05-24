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

                List<ENPedido> peds = ENPedido.ReadAll();
                if(peds.Count == 0)
                {
                    
                }
                rptListPedidos.DataSource = ENPedido.ReadAll();
                rptListPedidos.DataBind();
            }


        }

        protected void EliminarPedido_Click(object sender, EventArgs e)
        {
            Button btnEliminar = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnEliminar.NamingContainer;
            Label lblNumPedido = (Label)item.FindControl("lblNumPedido");

            if (lblNumPedido != null)
            {
                int numPedido = Convert.ToInt32(lblNumPedido.Text);
                ENPedido ped = new ENPedido();
                ped.Numpedido = numPedido;
                ped.Delete();
            }
        }

    }

}