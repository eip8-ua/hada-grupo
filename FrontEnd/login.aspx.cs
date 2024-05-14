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
            usuario.email = email.Text;
            usuario.constrasena = password.Text;
            usuario.id = usuario.Registrado();
            if(usuario.id > 0)
            {
                usuario.Read();
            }
            else
            {
                //Debe dar el error
            }
        }
        protected void Register_Click(object sender, EventArgs e)
        {

        }
    }
}