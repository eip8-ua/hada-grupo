using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
                foreach (ENCategoria i in categorias)
                {
                    list_categoria.Items.Add(new ListItem(i.tipo));
                }

                List<ENPromociones> promociones = new List<ENPromociones>();
                if (ENPromociones.getPromociones(promociones))
                {
                    foreach (ENPromociones i in promociones)
                    {
                        list_promocion.Items.Add(new ListItem(i.Descuento + "% " + (i.Disponibilidad == true ? "Disponible" : "No disponible"), i.MiId.ToString()));
                    }
                }
            }
        }

        protected void Add_Product_Click(object sender, EventArgs e)
        {
            ENCategoria categoria = new ENCategoria();
            categoria.tipo = list_categoria.SelectedValue;
            categoria.Read();

            ENPromociones promocion = new ENPromociones();
            promocion.MiId = Convert.ToInt32(list_promocion.SelectedValue);
            //promocion.Read();

            ENProducto producto = new ENProducto(-1,Convert.ToInt32(precio.Text),Convert.ToInt32(stock.Text),0,descripcion.Text,nombre.Text,"",categoria,promocion);
            //producto.url_image = "";
            
        }
        /*protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (fileInput.HasFile)
            {
                try
                {
                    string filename = Path.GetFileName(fileInput.FileName);
                    // Specify the path where you want to save the file
                    fileInput.SaveAs(Server.MapPath("~/Uploads/" + filename));
                    // Optionally, you can do something with the uploaded file here
                    // For example, you can save the file path to a database
                    // or display a success message to the user
                    Response.Write("File uploaded successfully.");
                }
                catch (Exception ex)
                {
                    // Handle any exceptions that may occur during file upload
                    Response.Write("Error: " + ex.Message);
                }
            }
            else
            {
                // If no file was selected, display a message to the user
                Response.Write("Please select a file to upload.");
            }
        }*/
    }
}