using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using Library;


namespace proyecto
{
    public partial class shopping_cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            

            if (!IsPostBack)
            {
                // Debugging: Check session data at the start of Page_Load
                List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();
                if (cart.Count > 0)
                {
                    Response.Write("Cart items count: " + cart.Count);
                }
                else
                {
                    Response.Write("Cart is empty");
                }
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
                    }
                        
                }
            }
        }

        protected void BindCart()
        {
            List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();
            List<Product> cartFormat = new List<Product>();
            foreach (ENLinCarr linCarr in cart)
            {
                ENProducto enProd = new ENProducto(linCarr.Producto, 1, "", 1);
                enProd.Read();
                Product prod = new Product(linCarr.Producto, enProd.nombre, enProd.pvp, linCarr.Cantidad);
                cartFormat.Add(prod);
            }

            gvCart.DataSource = cartFormat;
            gvCart.DataBind();
            divTotalAndBuy.Visible = cartFormat.Count > 0;
            UpdateTotal(cart);
        }

        protected void SaveCartToDataBase()
        {
            ENCarritoDe enCarritoDe = new ENCarritoDe();
            //List<Product> cart  cartItems = enCarritoDe.GetCartByUser();
        }

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
        }

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
                ENProducto product = (ENProducto)e.Row.DataItem;
                TextBox txtQuantity = (TextBox)e.Row.FindControl("txtQuantity");
                txtQuantity.TextChanged += (s, ev) =>
                {
                    int newQuantity;
                    if (int.TryParse(txtQuantity.Text, out newQuantity))
                    {
                        List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr>;
                        ENLinCarr productToUpdate = cart.Find(p => p.Id == product.id);
                        productToUpdate.Cantidad = newQuantity;
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
                List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr>;
                ENLinCarr productToUpdate = cart.Find(p => p.Id == productId);
                productToUpdate.Cantidad = newQuantity;
                Session["Cart"] = cart;
                UpdateTotal(cart);
            }
        }
        

        protected void UpdateTotal(List<ENLinCarr> cart)
        {
            float total = 0;
            foreach (ENLinCarr linCarr in cart)
            {
                ENProducto enProd = new ENProducto(linCarr.Carrito, 1, "", 1);
                enProd.Read();
                total += enProd.pvp * linCarr.Cantidad;
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