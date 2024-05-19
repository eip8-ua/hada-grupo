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
                BindCart();

                if (Site1.usuario != null)
                {
                    ENCarrito enCar = new ENCarrito(1, new DateTime());
                    enCar.Create();

                    ENLinCarr enLinCar = new ENLinCarr();
                    //int cantidad = Session[+]
                    //enLinCar.Create(1,);
                }
            }
        }

        protected void BindCart()
        {
            List<Product> cart = Session["Cart"] as List<Product> ?? new List<Product>();
            gvCart.DataSource = cart;
            gvCart.DataBind();
            divTotalAndBuy.Visible = cart.Count > 0;
            UpdateTotal(cart);
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
            decimal total = 0;
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