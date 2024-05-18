using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;

namespace FrontEnd
{
    public partial class admin_usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ENUsuario usu = new ENUsuario();
                UsuarioLista usuPrimeroLista = new UsuarioLista(usu.Email, usu.Nombre, usu.Apellidos, usu.Admin, usu.FNacimiento, usu.Dni, usu.Tlfn);
                List<UsuarioLista> listaUsuarios = new List<UsuarioLista> { usuPrimeroLista };
                
                while(usu.ReadNext())
                {
                    UsuarioLista usuLista = new UsuarioLista(usu.Email, usu.Nombre, usu.Apellidos, usu.Admin, usu.FNacimiento, usu.Dni, usu.Tlfn);
                    listaUsuarios.Add(usuLista);
                }

                // Asignar lista de productos al repeater
                rptListUsers.DataSource = listaUsuarios;
                rptListUsers.DataBind();
            }
        }

        public class UsuarioLista
        {
            public string Email { get; set; }
            public string Nombre { get; set; }
            public string Apellidos { get; set; }
            public bool Admin { get; set; }
            public DateTime Fecha { get; set; }
            public string Dni { get; set; }
            public string Telefono { get; set; }



            public UsuarioLista(string email, string nombre, string apellidos, bool admin, DateTime fecha, string dni, string telefono = null)
            {
                Email = email;
                Nombre = nombre;
                Apellidos = apellidos;
                Admin = admin;
                Fecha = fecha;
                Telefono = telefono;
            }
        }
    }
}