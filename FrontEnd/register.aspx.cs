using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;
namespace FrontEnd
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Se comprueba:
        ///     -Que no estén vacios los campos obligatorios
        ///     -Que el email tenga @
        ///     -Que el DNI tenga 9 digitos o menos
        ///     -Que sea mayor de 18
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Create_Account_Click(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty(email.Text)|| string.IsNullOrEmpty(password.Text) ||
               string.IsNullOrEmpty(dni.Text) || string.IsNullOrEmpty(nombre.Text) || 
               string.IsNullOrEmpty(apellidos.Text))
            {
                status_lbl.Text = "Los campos * son obligatorios";
                return;
            }

            if (!email.Text.Contains("@"))
            {
                status_lbl.Text = "El email es incorrecto debe contener @";
                return;
            }
            
            if(dni.Text.Length > 9)
            {
                status_lbl.Text = "El DNI tiene una longitud incorrecta";
                return;
            }

            string[] date_splitted = fecha_nacimiento.Text.Split('-');
            DateTime age = new DateTime(Convert.ToInt32(date_splitted[0]),Convert.ToInt32(date_splitted[1]),Convert.ToInt32(date_splitted[2]));
            TimeSpan difference = DateTime.Now - age;

            if((int)(difference.TotalDays / 365.25) < 18)
            {
                status_lbl.Text = "Tienes que ser mayor de 18 años";
                return;
            }


            Site1.usuario = new ENUsuario(-1, dni.Text, email.Text, nombre.Text, password.Text, apellidos.Text, age, false, telefono.Text);
            if(!Site1.usuario.Create())
            {
                status_lbl.Text = "Error creando el usuario. Este correo electronico ya tiene una cuenta asociada";
            }

            //Todo correcto
            Response.Redirect("~/user.aspx");
        }
    }
}