using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;

namespace proyecto
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
                    Response.Redirect("~/user.aspx");
                }
                else
                {
                    Site1.usuario = new ENUsuario();
                    status_lbl.Text = "Correo electrónico o contraseña incorrecto";
                }
             }
            else
            {
                //Debe dar el error
            }
        }
        protected void Register_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/register.aspx");
        }
    }
}