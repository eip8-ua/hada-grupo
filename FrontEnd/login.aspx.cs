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
            Site1.usuario.Email = email.Text;
            Site1.usuario.Passwd = password.Text;
            //Site1.usuario.Id = Site1.usuario.Registrado();
            if(Site1.usuario.Id > 0)
            {
                //Site1.usuario.read();
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