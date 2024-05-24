using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;
using System.Web.Services;
using System.Web.Script.Services;

namespace FrontEnd
{
    public partial class admin_usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Site1.usuario.Admin)
            {
                Response.Redirect("~/index.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ENUsuario usu = new ENUsuario();
                usu.ReadFirst();
                if (!usu.ReadNext())
                {
                    problem.Text = "No hay usuarios que administrar";
                }
                else
                {
                    List<UsuarioLista> listaUsuarios = new List<UsuarioLista>();

                    while (usu.ReadNext())
                    {
                        UsuarioLista usuLista = new UsuarioLista(usu.Email, usu.Nombre, usu.Apellidos, usu.Admin, usu.FNacimiento, usu.Dni, usu.Tlfn);
                        listaUsuarios.Add(usuLista);
                    }

                    rptListUsers.DataSource = listaUsuarios;
                    rptListUsers.DataBind();
                }


            }
        }

        //protected void rptListUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        //{
        //    if (e.CommandName == "Eliminar")
        //    {
        //        System.Diagnostics.Debug.WriteLine("Se ejecuta");
        //        string email = e.CommandArgument.ToString();
        //        ENUsuario usu = new ENUsuario();
        //        usu.Email = email;
        //        usu.Read();
        //        usu.Delete();
        //    }
        //}


        //[WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        //public static string EliminarUsuario(string email)
        //{
        //    System.Diagnostics.Debug.WriteLine("Se ejecuta");
        //    // Implementa la lógica para eliminar el usuario usando el email
        //    // Por ejemplo:
        //    // bool isDeleted = UserService.DeleteUserByEmail(email);
        //    ENUsuario usu = new ENUsuario();
        //    usu.Email = email;
        //    usu.Read();
        //    if(usu.Delete())
        //    {
        //        return "Usuario eliminado: " + email;
        //    }
        //    else
        //        return "Error";
        //    // Retorna un mensaje o resultado

        //}

        public void EliminarUsuario(object sender, CommandEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("Se ejecuta");
            string email = e.CommandArgument.ToString();
            System.Diagnostics.Debug.WriteLine("Email buscado = " + email);
            ENUsuario usu = new ENUsuario();
            usu.Email = email;
            usu.Read();
            System.Diagnostics.Debug.WriteLine("ID buscado = " + usu.Id);
            usu.Delete();
            Page_Load(sender, e);
        }


        
    }



        public class UsuarioLista
        {
            public string Email { get; set; }
            public string Nombre { get; set; }
            public string Apellidos { get; set; }
            public bool Admin { get; set; }
            public string Fecha { get; set; }
            public string Dni { get; set; }
            public string Telefono { get; set; }



            public UsuarioLista(string email, string nombre, string apellidos, bool admin, DateTime fecha, string dni, string telefono = null)
            {
                Email = email;
                Nombre = nombre;
                Apellidos = apellidos;
                Admin = admin;
                Fecha = fecha.ToString("yyyy-MM-dd").ToString();
                Telefono = telefono;
                Dni = dni;
            }
        }
}