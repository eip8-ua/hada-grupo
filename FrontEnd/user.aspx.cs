using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;


namespace proyecto
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
            usu.Dni = dni.Text;
            usu.Email = correo.Text;
            usu.Nombre = nombre.Text;
            usu.Passwd = contrasena.Text;
            usu.Apellidos = apellidos.Text;
            usu.Tlfn = tlfno.Text;
            usu.Admin = Site1.usuario.Admin;
            //Para gestionar la fecha
            string[] date_splitted = fechaNac.Text.Split('-');
            DateTime date = new DateTime(Convert.ToInt32(date_splitted[0]), Convert.ToInt32(date_splitted[1]), Convert.ToInt32(date_splitted[2]));
            usu.FNacimiento = date;


            bool result = usu.Update();
            if (!result)
                error.Text = "Ha ocurrido algún error";       
            

        }
    }
}