using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using Library;

namespace FrontEnd
{
    public partial class contact_us : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            status_lbl.Text = "";
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(email.Text) || String.IsNullOrEmpty(nombre.Text) || String.IsNullOrEmpty(telf.Text) || String.IsNullOrEmpty(mensaje.Text))
            {
                status_lbl.ForeColor = System.Drawing.Color.Red;
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

                

                ENContactUs en = new ENContactUs(email.Text, nombre.Text, telf.Text, mensaje.Text);
                if (en.Create())
                {
                    status_lbl.ForeColor = System.Drawing.Color.Green;
                    status_lbl.Text = "Mensaje enviado con éxito";
                }

                else
                {
                    status_lbl.ForeColor = System.Drawing.Color.Red;
                    status_lbl.Text = "Error al crear mensaje";
                }



            }
        }
    }
}