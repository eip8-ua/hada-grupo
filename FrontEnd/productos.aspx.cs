﻿using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Library;

namespace FrontEnd
{
    public partial class productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
            }
        }

        private void CargarProductos()
        {
            List<ENProducto> productos = ENProducto.ObtenerTodosLosProductos();
            RepeaterProductos.DataSource = productos;
            RepeaterProductos.DataBind();
        }

        protected void FilterProducts(object sender, EventArgs e)
        {
            string categoria = ddlCategory.SelectedValue;
            decimal minPrice = string.IsNullOrEmpty(txtMinPrice.Text) ? 0 : Convert.ToDecimal(txtMinPrice.Text);
            decimal maxPrice = string.IsNullOrEmpty(txtMaxPrice.Text) ? decimal.MaxValue : Convert.ToDecimal(txtMaxPrice.Text);

            List<ENProducto> productosFiltrados = ENProducto.FiltrarProductos(categoria, minPrice, maxPrice);
            RepeaterProductos.DataSource = productosFiltrados;
            RepeaterProductos.DataBind();
        }

        protected void btnAddToCart_Command(object sender, CommandEventArgs e)
        {
            // Obtener el ID del producto y la cantidad seleccionada
            int productId = Convert.ToInt32(e.CommandArgument);
            Console.WriteLine(productId);
            int quantity = 1;
            List<ENLinCarr> cart = Session["Cart"] as List<ENLinCarr> ?? new List<ENLinCarr>();

            ENLinCarr existingProduct = cart.Find(p => p.Producto == productId);

            if (existingProduct != null)
            {
                existingProduct.Cantidad += quantity;
            }
            else
            {
                cart.Add(new ENLinCarr(1, quantity, 1, productId));
            }

            Session["Cart"] = cart;
        }
    }
}
