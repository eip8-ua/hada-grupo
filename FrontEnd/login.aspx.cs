using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;

namespace FrontEnd
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(email.Text) && !string.IsNullOrEmpty(password.Text) && email.Text.Contains("@"))
            {
                Site1.usuario.Email = email.Text;
                Site1.usuario.Passwd = password.Text;

                if (Site1.usuario.Validate())
                {
                    // Almacenar el ID del usuario en la sesión
                    Session["UserID"] = Site1.usuario.Id;
                    Response.Redirect("~/user.aspx");
                }
                else
                {
                    email.Text = "";
                    password.Text = "";
                    Site1.usuario = new ENUsuario();
                    status_lbl.Text = "Correo electrónico o contraseña incorrecto";
                }
            }
            else
            {
                email.Text = "";
                password.Text = "";
                Site1.usuario = new ENUsuario();
                status_lbl.Text = "Algún campo vacio o falta el @";
            }
        }
        protected void Register_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/register.aspx");
        }
    }
}
