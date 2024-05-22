using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FrontEnd
{
    public partial class shopping_cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ejemplo: Simular productos en el carrito
                List<ProductoCarrito> productosEnCarrito = new List<ProductoCarrito>
                {
                    new ProductoCarrito("Producto 1", 20.00m, 2),
                    new ProductoCarrito("Producto 2", 35.50m, 1),
                    new ProductoCarrito("Producto 3", 50.00m, 1)
                };

                // Asignar lista de productos al repeater
                rptCartItems.DataSource = productosEnCarrito;
                rptCartItems.DataBind();

                // Calcular y mostrar el total
                decimal total = CalcularTotal(productosEnCarrito);
                lblTotal.Text = total.ToString("N2");
            }
        }

        protected void btnComprar_Click(object sender, EventArgs e)
        {
            // Lógica para finalizar la compra
            // Aquí puedes agregar la funcionalidad necesaria al hacer clic en el botón "Comprar"
            // Por ejemplo, redirigir a otra página para finalizar la transacción.
            //Response.Redirect("ConfirmacionCompra.aspx");
        }

        private decimal CalcularTotal(List<ProductoCarrito> productos)
        {
            decimal total = 0;
            foreach (var producto in productos)
            {
                total += producto.Precio * producto.Cantidad;
            }
            return total;
        }

        public class ProductoCarrito
        {
            public string Nombre { get; set; }
            public decimal Precio { get; set; }
            public int Cantidad { get; set; }

            public ProductoCarrito(string nombre, decimal precio, int cantidad)
            {
                Nombre = nombre;
                Precio = precio;
                Cantidad = cantidad;
            }

            public decimal Subtotal
            {
                get { return Precio * Cantidad; }
            }
        }
    }
}