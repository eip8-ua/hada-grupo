using System;
using System.Collections.Generic;
using Library;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontEnd
{
    public partial class pedidos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPedidos();
            }
        }

        private void CargarPedidos()
        {
            int userId = ObtenerIdUsuario();

            if (userId > 0)
            {
                List<ENPedido> pedidos = ENPedido.ReadAll();

                // Filtrar pedidos solo del usuario actual
                var userPedidos = pedidos.FindAll(p => p.IdUsuario == userId);

                if (userPedidos.Count > 0)
                {
                    OrdersGridView.DataSource = userPedidos;
                    OrdersGridView.DataBind();
                    NoOrdersLabel.Visible = false;
                }
                else
                {
                    OrdersGridView.Visible = false;
                    NoOrdersLabel.Text = "No se ha realizado ningún pedido aún.";
                    NoOrdersLabel.Visible = true;
                }
            }
            else
            {
                // Manejar el caso en que no se encuentre el ID del usuario
                // Por ejemplo, redirigir a la página de login
                Response.Redirect("~/login.aspx");
            }
        }

        private int ObtenerIdUsuario()
        {
            if (Session["UserID"] != null)
            {
                return (int)Session["UserID"];
            }
            else
            {
                return -1; // Usuario no autenticado
            }
        }

        protected void OrdersGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (OrdersGridView.SelectedDataKey == null)
            {
                return;
            }

            int pedidoId = Convert.ToInt32(OrdersGridView.SelectedDataKey.Value);

            // Obtener las líneas de pedido para el pedido seleccionado
            List<ENLinPed> lineasPedido = ENLinPed.GetLinesByPedidoId(pedidoId);
            List<dynamic> productos = new List<dynamic>();

            foreach (var linea in lineasPedido)
            {
                ENProducto producto = new ENProducto();
                producto.id = linea.IdProducto;
                if (producto.Read())
                {
                    productos.Add(new
                    {
                        producto.nombre,
                        producto.pvp,
                        cantidad = linea.Cantidad
                    });
                }
            }

            ProductsGridView.DataSource = productos;
            ProductsGridView.DataBind();
            ProductsGridView.Visible = true;
        }
    }
}
