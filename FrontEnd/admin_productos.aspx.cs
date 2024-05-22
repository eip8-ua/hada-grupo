using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using Library;

namespace FrontEnd
{
    public partial class admin_productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {          
            if (!IsPostBack)
            {
                List<ENCategoria> categorias = ENCategoria.Get_All_Categorias();
                list_categoria.Items.Add(new ListItem("Sin seleccionar", "0"));
                foreach (ENCategoria i in categorias)
                {
                    list_categoria.Items.Add(new ListItem(i.tipo));
                }

                List<ENPromociones> promociones = new List<ENPromociones>();
                list_promocion.Items.Add(new ListItem("Sin seleccionar", "0"));
                if (ENPromociones.getPromociones(promociones))
                {
                    foreach (ENPromociones i in promociones)
                    {
                        list_promocion.Items.Add(new ListItem(i.Descuento + "% " + (i.Disponibilidad == true ? "Disponible" : "No disponible"), i.MiId.ToString()));
                    }
                }
            }
        }


        /// <summary>
        /// Añade un producto a la web
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Add_Product_Click(object sender, EventArgs e)
        {
            ENCategoria categoria = null;
            if(list_categoria.SelectedValue != "0") //Comprueba si no hay categoria
            {
                categoria = new ENCategoria();
                categoria.tipo = list_categoria.SelectedValue;
                categoria.Read();
            }
            ENPromociones promocion = null;
            if (list_promocion.SelectedValue != "0") //Comprueba si no hay promocion
            {
                promocion = new ENPromociones();
                promocion.MiId = Convert.ToInt32(list_promocion.SelectedValue);
            }

            status_lbl.ForeColor = Color.Red;

            //Comprueba que los parámetros sean correctos
            if (string.IsNullOrEmpty(nombre.Text) || string.IsNullOrEmpty(precio.Text) ||
                string.IsNullOrEmpty(stock.Text))
            {
                status_lbl.Text = "Los campos * son obligatorios";
            }
            else if (string.IsNullOrEmpty(fileInput.PostedFile.FileName))
            {
                status_lbl.Text = "Debes seleccionar una fotografía del producto";
            }
            else if(Path.GetExtension(fileInput.PostedFile.FileName) != ".jpg")
            {
                status_lbl.Text = "La imagen debe ser .jpg";
            }
            else if(Convert.ToDouble(precio.Text) <= 0)
            {
                status_lbl.Text = "El precio debe ser mayor a 0";
            }
            else if(Convert.ToInt32(stock.Text) < 0)
            {
                status_lbl.Text = "El stock no puede ser menor a 0";
            }
            else
            {
                //añadir el producto
                ENProducto producto = new ENProducto(-1, (float)Convert.ToDouble(precio.Text), Convert.ToInt32(stock.Text), 0, descripcion.Text, nombre.Text, "", categoria, promocion);
                bool created = producto.Create();
                producto.url_image = "/Images/Productos/" + producto.id + Path.GetExtension(fileInput.PostedFile.FileName); 
                bool updated = producto.Update();

                if (!created || !updated)
                {
                    status_lbl.Text = "Error al añadir producto";
                }
                else
                {
                    fileInput.SaveAs(Server.MapPath(producto.url_image));
                    status_lbl.ForeColor = Color.Black;
                    status_lbl.Text = "Añadido correctamente";
                }
            }
        }
    }
}