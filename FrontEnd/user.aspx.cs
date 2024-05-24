using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;


namespace FrontEnd
{
    public partial class user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                correo.Text = Site1.usuario.Email;
                contrasena.Attributes["value"] = Site1.usuario.Passwd;
                nombre.Text = Site1.usuario.Nombre;
                apellidos.Text = Site1.usuario.Apellidos;
                tlfno.Text = Site1.usuario.Tlfn;
                fechaNac.Attributes["value"] = Site1.usuario.FNacimiento.ToString("yyyy-MM-dd").ToString();
                dni.Text = Site1.usuario.Dni;
            }
            


        }

        protected void cuandoActualizar(object sender, EventArgs e)
        {
            ENUsuario usu = new ENUsuario();
            usu.Id = Site1.usuario.Id;
            if (string.IsNullOrEmpty(dni.Text)) 
                usu.Dni = Site1.usuario.Dni;
            else
                usu.Dni = dni.Text;
            if (string.IsNullOrEmpty(correo.Text))
                usu.Email = Site1.usuario.Email;
            else
                usu.Email = correo.Text;
            if (string.IsNullOrEmpty(nombre.Text))
                usu.Nombre = Site1.usuario.Nombre;
            else
                usu.Nombre = nombre.Text;
            if (string.IsNullOrEmpty(contrasena.Text))
                usu.Passwd = Site1.usuario.Passwd;
            else
                usu.Passwd = contrasena.Text;
            if (string.IsNullOrEmpty(apellidos.Text))
                usu.Apellidos = Site1.usuario.Apellidos;
            else
                usu.Apellidos = apellidos.Text;
            if (string.IsNullOrEmpty(tlfno.Text))
                usu.Tlfn = Site1.usuario.Tlfn;
            else
                usu.Tlfn = tlfno.Text;
            usu.Admin = Site1.usuario.Admin;
            //Para gestionar la fecha
            if (string.IsNullOrEmpty(fechaNac.Text))
                usu.FNacimiento = Site1.usuario.FNacimiento;
            else
            {
                string[] date_splitted = fechaNac.Text.Split('-');
                DateTime date = new DateTime(Convert.ToInt32(date_splitted[0]), Convert.ToInt32(date_splitted[1]), Convert.ToInt32(date_splitted[2]));
                usu.FNacimiento = date;
            }

            bool result = usu.Update();
            if (!result)
                error.Text = "Ha ocurrido algún error";
        }
    }
}