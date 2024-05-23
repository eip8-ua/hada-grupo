using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace FrontEnd
{
    public partial class contact_us : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(email.Text) || String.IsNullOrEmpty(nombre.Text) || String.IsNullOrEmpty(telf.Text) || String.IsNullOrEmpty(mensaje.Text))
            {
                status_lbl.Text = "Campo vacío";
            }

            else
            {
                try
                {
                    MailAddress mailCheck = new MailAddress(email.Text);
                }
                catch
                {
                    status_lbl.Text = "Formato email incorrecto";


                }

            }
        }
    }
}