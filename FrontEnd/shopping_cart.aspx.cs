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
            btnBuy.Attributes["OnClick"] = "return showModal();";
            if (!IsPostBack)
            {
                if (Site1.usuario.Email!=null)
                {
                    ENCarritoDe enCarritoDe = new ENCarritoDe(Site1.usuario.Id,0);

                    // Ver si existe el usuario en la base de datos
                    if (enCarritoDe.Read())
                    { 
                        ENLinCarr enLinCarr = new ENLinCarr();

                        // Conseguir Id del carrito ligada al usuario
                        int cartDataBase = enCarritoDe.Carrito;

                        // Añadir los productos de la Variable Session a la base de datos
                        if (Session["Cart"] != null)
                        {
                            List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();

                            List<ENLinCarr> cartDB = enLinCarr.getItemsByCartId(cartDataBase);
                            

                            foreach (ENLinCarr item in cart)
                            {
                                bool existsInCartDB = cartDB != null ? cartDB.Any(dbItem => dbItem.Producto == item.Producto) : false;

                                if (!existsInCartDB)
                                {
                                    item.Carrito = cartDataBase;
                                    item.Create();
                                } else if (item.Carrito == -1)
                                {
                                    item.Carrito = cartDataBase;
                                    item.Update();
                                }
                            }
                        }

                        // Conseguir Productos del carrito con la Id anterior
                        List<ENLinCarr> cartDBItems = enLinCarr.getItemsByCartId(cartDataBase);

                        // Añadir los Productos al GridView
                        Session["Cart"] = cartDBItems;
                        BindCart();
                    }
                    else
                    {
                        if (Session["Cart"] != null) 
                        {
                            // Si no existe crear una linea de la base de datos con el usuario y el carrito actual
                            ENCarrito enCarrito = new ENCarrito();
                            enCarrito.Create();

                            enCarritoDe = new ENCarritoDe(Site1.usuario.Id, enCarrito.Num_carrito);
                            enCarritoDe.Create();

                            ENLinCarr enLinCarr = new ENLinCarr();

                            // Conseguir Id del carrito ligada al usuario
                            int cartDataBase = enCarrito.Num_carrito;

                            // Añadir los productos de la Variable Session a la base de datos
                            if (Session["Cart"] != null)
                            {
                                List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();

                                foreach (ENLinCarr item in cart)
                                {
                                    item.Carrito = cartDataBase;
                                    item.Create();
                                }
                            }

                            
                        }
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
            
            foreach (ENLinCarr linCarr in cart)
            {
                ENProducto enProd = new ENProducto(linCarr.Producto, 1, 1, 1);
                enProd.Read();
                Product prod = new Product(linCarr.Producto, enProd.nombre, enProd.pvp, linCarr.Cantidad, enProd.promocion != null ? enProd.promocion.Descuento : 0);
                cartFormat.Add(prod);
            }

            gvCart.DataSource = cartFormat;
            gvCart.DataBind();
            divTotalAndBuy.Visible = cartFormat.Count > 0;
            UpdateTotal(cartFormat);
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int productId = int.Parse(e.CommandArgument.ToString());
                List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr>;

                if (cart != null)
                {
                    ENLinCarr productToRemove = cart.Find(p => p.Producto == productId);
                    if (productToRemove != null)
                    {
                        cart.Remove(productToRemove);
                    }

                    Session["Cart"] = cart;
                    BindCart();
                }

                if(Site1.usuario.Email != null)
                {
                    ENCarritoDe enCarritoDe = new ENCarritoDe(Site1.usuario.Id, 0);
                    if (enCarritoDe.Read())
                    {
                        ENLinCarr enLinCarr = new ENLinCarr();
                        enLinCarr.Producto = int.Parse(e.CommandArgument.ToString());
                        enLinCarr.Carrito = enCarritoDe.Carrito;
                        enLinCarr.Delete();
                    }
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
                        List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr>;
                        ENLinCarr productToUpdate = cart.Find(p => p.Producto == product.Id);
                        productToUpdate.Cantidad = newQuantity;
                        Session["Cart"] = cart;

                        List<Product> cartFormat = new List<Product>();

                        foreach (ENLinCarr linCarr in cart)
                        {
                            ENProducto enProd = new ENProducto(linCarr.Producto, 1, 1, 1);
                            enProd.Read();
                            Product prod = new Product(linCarr.Producto, enProd.nombre, enProd.pvp, linCarr.Cantidad, enProd.promocion != null ? enProd.promocion.Descuento : 0);
                            cartFormat.Add(prod);
                        }
                    }
                };
            }
        }
        

        protected void txtQuantity_TextChanged(object sender, EventArgs e)
        {
            TextBox txtQuantity = sender as TextBox;

            txtQuantity.Attributes["type"] = "number";
            txtQuantity.Attributes["min"] = "1";

            GridViewRow row = txtQuantity.NamingContainer as GridViewRow;
            int productId = Convert.ToInt32(gvCart.DataKeys[row.RowIndex].Value);

            int newQuantity;
            if (int.TryParse(txtQuantity.Text, out newQuantity))
            {
                if (newQuantity < 1)
                {
                    newQuantity = 1;
                    txtQuantity.Text = "1";
                }

                List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr>;
                ENLinCarr productToUpdate = cart.Find(p => p.Producto == productId);
                productToUpdate.Cantidad = newQuantity;
                Session["Cart"] = cart;

                List<Product> cartFormat = new List<Product>();

                foreach (ENLinCarr linCarr in cart)
                {
                    ENProducto enProd = new ENProducto(linCarr.Producto, 1, 1, 1);
                    enProd.Read();
                    Product prod = new Product(linCarr.Producto, enProd.nombre, enProd.pvp, linCarr.Cantidad, enProd.promocion != null ? enProd.promocion.Descuento : 0);
                    cartFormat.Add(prod);
                }


                if (Site1.usuario.Email != null)
                {
                    ENCarritoDe enCarritoDe = new ENCarritoDe(Site1.usuario.Id, 0);
                    if (enCarritoDe.Read())
                    {
                        ENLinCarr enLinCarr = new ENLinCarr();
                        enLinCarr.Id = productToUpdate.Id;
                        enLinCarr.Cantidad = newQuantity;
                        enLinCarr.Update();
                    }
                }

                UpdateTotal(cartFormat);
            }
        }
        

        protected void UpdateTotal(List<Product> cart)
        {
            float totalPvp = 0;
            foreach (Product product in cart)
            {
                totalPvp += product.Price * product.Quantity;
            }
            lblTotalPvp.Text = totalPvp.ToString("C");

            float totalDesc = 0;
            foreach (Product product in cart)
            {
                totalDesc += (product.Price - (product.Price * (1 - product.Discount / 100))) * product.Quantity;
            }
            lblTotalDesc.Text = totalDesc.ToString("C");

            float total = 0;    
            total += totalPvp - totalDesc;
            lblTotal.Text = total.ToString("C");
        }

        protected void btnBuy_Click(object sender, EventArgs e)
        {
            
            ENPedido enPedido = new ENPedido(1, DateTime.Now, Site1.usuario.Id);
            enPedido.Create();

            List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();

            foreach (ENLinCarr item in cart)
            {
                ENLinPed enLinPed = new ENLinPed(item.Id, enPedido.Numpedido, item.Producto, item.Cantidad);
                enLinPed.Create();

                ENLinCarr enLinCarr = new ENLinCarr(item.Id, item.Cantidad, item.Carrito, item.Producto);
                enLinCarr.Delete();
            }

            Response.Redirect("Pedidos.aspx");
        }

        protected string GetDiscountedPrice(float price, float discount)
        {
            float discountedPrice = price * (1 - discount / 100); // Calcular el precio con descuento
            return discountedPrice.ToString("C"); // Formatear el precio con descuento como una moneda
        }

    }

    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public float Price { get; set; }
        public int Quantity { get; set; }
        public float Discount { get; set; }

        public Product(int id, string name, float price, int quantity, float discount)
        {
            Id = id;
            Name = name;
            Price = price;
            Quantity = quantity;
            Discount = discount;
        }
    }
}