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
                contrasena.Text = Site1.usuario.Passwd;
                nombre.Text = Site1.usuario.Nombre;
                apellidos.Text = Site1.usuario.Apellidos;
                tlfno.Text = Site1.usuario.Tlfn;
                //direccion.Text = Site1.usuario.;
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
            usu.FNacimiento = Site1.usuario.FNacimiento;


            bool result = usu.Update();
            if (!result)
                error.Text = "Ha ocurrido algún error";       
            

        }
    }
}