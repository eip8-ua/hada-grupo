using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;


namespace proyecto
{
    public partial class shopping_cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (User.Identity.IsAuthenticated)
                {
                    // Usuario autenticado: cargar datos del carrito desde la base de datos
                    int userId = ObtenerIdUsuarioAutenticado(); // Método para obtener el ID de usuario autenticado
                    List<ProductoCarrito> cartItems = ObtenerItemsCarritoDesdeBaseDeDatos(userId);

                    // Enlazar los datos al repeater u otros controles
                    rptCartItems.DataSource = cartItems;
                    rptCartItems.DataBind();

                    // Calcular y mostrar el total
                    decimal total = cartItems.Sum(item => item.Precio * item.Cantidad);
                    lblTotal.Text = total.ToString("0.00");
                }
                else
                {
                    // Usuario no autenticado: cargar datos del carrito desde las cookies
                    List<ProductoCarrito> cartItems = GetCartItemsFromCookie();

                    // Enlazar los datos al repeater u otros controles
                    rptCartItems.DataSource = cartItems;
                    rptCartItems.DataBind();

                    // Calcular y mostrar el total
                    decimal total = cartItems.Sum(item => item.Precio * item.Cantidad);
                    lblTotal.Text = total.ToString("0.00");
                }
            }
        }

        private List<ProductoCarrito> ObtenerItemsCarritoDesdeBaseDeDatos(int userId)
        {
            // Implementa la lógica para recuperar los datos del carrito desde la base de datos
            // Ejemplo: consulta SQL para obtener los detalles del carrito del usuario con ID userId
            // Puedes usar Entity Framework, ADO.NET u otros métodos de acceso a datos

            List<ProductoCarrito> cartItems = new List<ProductoCarrito>();
            // Ejemplo de consulta con Entity Framework:
            /*using (var dbContext = new YourDbContext())
            {
                cartItems = dbContext.CartItems
                    .Where(c => c.UserId == userId)
                    .ToList();
            }*/

            return cartItems;
        }

        private int ObtenerIdUsuarioAutenticado()
        {
            int userId = 0; // Valor por defecto si no hay usuario autenticado o no se puede obtener el ID

            if (User.Identity.IsAuthenticated)
            {
                // Obtener el nombre de usuario (o ID) del usuario autenticado
                string username = User.Identity.Name;

                // Aquí deberías implementar la lógica para buscar el ID del usuario en la base de datos
                // Por ejemplo, utilizando Entity Framework u otro método de acceso a datos
                // Supongamos que tienes una tabla de usuarios donde puedes buscar por nombre de usuario
                /*using (var dbContext = new YourDbContext())
                {
                    var user = dbContext.Users.FirstOrDefault(u => u.UserName == username);
                    if (user != null)
                    {
                        userId = user.Id; // Suponiendo que 'Id' es el campo que representa el ID del usuario
                    }
                }*/
            }

            return userId;
        }

        private List<ProductoCarrito> GetCartItemsFromCookie()
        {
            List<ProductoCarrito> cartItems = new List<ProductoCarrito>();

            // Obtener el valor de la cookie 'cartItems'
            string cartJson = string.Empty;
            if (Request.Cookies["cartItems"] != null)
            {
                cartJson = Request.Cookies["cartItems"].Value;
            }

            // Si hay datos en la cookie, parsearlos manualmente
            if (!string.IsNullOrEmpty(cartJson))
            {
                // Decodificar el valor de la cookie y convertirlo a una lista de objetos CartItem
                string decodedCartJson = Uri.UnescapeDataString(cartJson);
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                cartItems = serializer.Deserialize<List<ProductoCarrito>>(decodedCartJson);
            }

            return cartItems;
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