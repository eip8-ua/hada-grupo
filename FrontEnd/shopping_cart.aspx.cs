using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using Library;


namespace FrontEnd
{
    public partial class shopping_cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Debugging: Check session data at the start of Page_Load
                List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();
                BindCart();

                if (Site1.usuario != null)
                {
                    //List<Product> cart = Session["Cart"] as List<Product> ?? new List<Product>();
                    ENCarritoDe enCarritoDe = new ENCarritoDe();

                    // Ver si existe el usuario en la base de datos
                    if (enCarritoDe.UserExists(Site1.usuario))
                    {
                        // Consegir Id del carrito ligada al usuario
                        int cartDataBase = enCarritoDe.GetCartIdByUser(Site1.usuario);

                        // Conseguir Productos del carrito con la Id anterior
                        ENLinCarr enLinCarr = new ENLinCarr();
                        List<ENProducto> cartDBItems = enLinCarr.getItemsByCartId(cartDataBase);

                        // Añadir los Productos al GridView
                        Session["CartItems"] = cartDBItems;
                        BindCart();
                    }
                    else
                    {
                        // Si no existe crear una base de datos con el usuario y el carrito actual
                        enCarritoDe.Create();
                        BindCart();
                    }
                        
                }
                else
                {
                    BindCart();
                }
            }
        }

        protected void BindCart()
        {
            List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();
            List<Product> cartFormat = new List<Product>();
            /*
            Product prod1 = new Product(12, "Tempest K20 Beast", 32.44f, 3);
            Product prod2 = new Product(10, "Logitech G915 TKL RGB", 139f, 1);
            Product prod3 = new Product(6, "Apple Magic Mouse Plata", 85f, 2);
            Product prod4 = new Product(5, "Logitech M185 Ratón Inalámbrico", 12f, 2);

            cartFormat.Add(prod1);
            cartFormat.Add(prod2);
            cartFormat.Add(prod3);
            cartFormat.Add(prod4);
            */
            
            foreach (ENLinCarr linCarr in cart)
            {
                ENProducto enProd = new ENProducto(linCarr.Producto, 1, 1, 1);
                enProd.Read();
                Product prod = new Product(linCarr.Producto, enProd.nombre, enProd.pvp, linCarr.Cantidad);
                cartFormat.Add(prod);
            }

            gvCart.DataSource = cartFormat;
            gvCart.DataBind();
            divTotalAndBuy.Visible = cartFormat.Count > 0;
            UpdateTotal(cartFormat);
        }

        protected void SaveCartToDataBase()
        {
            ENCarritoDe enCarritoDe = new ENCarritoDe();
            //List<Product> cart  cartItems = enCarritoDe.GetCartByUser();
        }

        /*
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int productId = int.Parse(txtProductId.Text);
            string productName = txtProductName.Text;
            float productPrice = float.Parse(txtProductPrice.Text);
            int productQuantity = int.Parse(txtProductQuantity.Text);

            List<Product> cart = Session["Cart"] as List<Product> ?? new List<Product>();
            Product existingProduct = cart.Find(p => p.Id == productId);

            if (existingProduct != null)
            {
                existingProduct.Quantity += productQuantity;
            }
            else
            {
                cart.Add(new Product(productId, productName, productPrice, productQuantity));
            }

            Session["Cart"] = cart;
            BindCart();
        }*/

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int productId = int.Parse(e.CommandArgument.ToString());
                List<Product> cart = Session["Cart"] as List<Product>;

                if (cart != null)
                {
                    Product productToRemove = cart.Find(p => p.Id == productId);
                    if (productToRemove != null)
                    {
                        cart.Remove(productToRemove);
                    }

                    Session["Cart"] = cart;
                    BindCart();
                }
            }
        }

        
        protected void gvCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Product product = (Product)e.Row.DataItem;
                TextBox txtQuantity = (TextBox)e.Row.FindControl("txtQuantity");
                txtQuantity.TextChanged += (s, ev) =>
                {
                    int newQuantity;
                    if (int.TryParse(txtQuantity.Text, out newQuantity))
                    {
                        List<Product> cart = Session["Cart"] as List<Product>;
                        Product productToUpdate = cart.Find(p => p.Id == product.Id);
                        productToUpdate.Quantity = newQuantity;
                        Session["Cart"] = cart;
                        UpdateTotal(cart);
                    }
                };
            }
        }
        

        protected void txtQuantity_TextChanged(object sender, EventArgs e)
        {
            TextBox txtQuantity = sender as TextBox;
            GridViewRow row = txtQuantity.NamingContainer as GridViewRow;
            int productId = Convert.ToInt32(gvCart.DataKeys[row.RowIndex].Value);

            int newQuantity;
            if (int.TryParse(txtQuantity.Text, out newQuantity))
            {
                List<Product> cart = Session["Cart"] as List<Product>;
                Product productToUpdate = cart.Find(p => p.Id == productId);
                productToUpdate.Quantity = newQuantity;
                Session["Cart"] = cart;
                UpdateTotal(cart);
            }
        }
        

        protected void UpdateTotal(List<Product> cart)
        {
            float total = 0;
            foreach (Product product in cart)
            {
                total += product.Price * product.Quantity;
            }
            lblTotal.Text = total.ToString("C");
        }

        protected void btnBuy_Click(object sender, EventArgs e)
        {
            // Redirect to the Finish Purchase page
            Response.Redirect("Pedidos.aspx");
        }
    }
    
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public float Price { get; set; }
        public int Quantity { get; set; }

        public Product(int id, string name, float price, int quantity)
        {
            Id = id;
            Name = name;
            Price = price;
            Quantity = quantity;
        }
    }
}