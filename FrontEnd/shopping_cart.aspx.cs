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
                BindCart();
            }
        }

        protected void BindCart()
        {
            List<Product> cart = Session["Cart"] as List<Product> ?? new List<Product>();
            gvCart.DataSource = cart;
            gvCart.DataBind();

            bool isCartEmpty = cart.Count == 0;
            btnComprar.Visible = !isCartEmpty;

            if (!isCartEmpty)
            {
                divTotalAndBuy.Visible = true;
                UpdateTotal(cart);
            }
            else
            {
                divTotalAndBuy.Visible = false;
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int productId = int.Parse(txtProductId.Text);
            string productName = txtProductName.Text;
            decimal productPrice = decimal.Parse(txtProductPrice.Text);
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

        protected void UpdateTotal(List<Product> cart)
        {
            decimal total = 0;
            foreach (Product product in cart)
            {
                total += product.Price * product.Quantity;
            }
            lblTotal.Text = total.ToString("C");
        }

        protected void btnComprar_Click(object sender, EventArgs args)
        {
            // Redirigir a la página de pedido
            Response.Redirect("pedidos.aspx");
        }
    }
    
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }

        public Product(int id, string name, decimal price, int quantity)
        {
            Id = id;
            Name = name;
            Price = price;
            Quantity = quantity;
        }
    }
}