using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;

namespace proyecto
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        static public ENUsuario usuario = new ENUsuario();
        protected void Page_Load(object sender, EventArgs e) { 
        
            if (!IsPostBack)
            {   
                if(isAdmin(usuario))
                {
                    SetAdminOptions();
                } else if(isLogged(usuario)) {
                    SetRegisteredOptions();
                } else
                {
                    SetUnregisteredOptions();
                }
            }        
        }

        //Método para encontrar los objetos del menú en base a su valor
        private MenuItem FindMenuItemByValue(MenuItemCollection items, string targetValue)
        {
            foreach (MenuItem item in items)
            {
                // Verificar si el valor del elemento actual coincide con el valor buscado
                if (item.Value == targetValue)
                {
                    return item; // Se encontró el elemento, devolverlo
                }

                // Si el elemento actual tiene subelementos, buscar de manera recursiva en ellos
                if (item.ChildItems.Count > 0)
                {
                    MenuItem foundItem = FindMenuItemByValue(item.ChildItems, targetValue);
                    if (foundItem != null)
                    {
                        return foundItem; // Se encontró en los subelementos, devolverlo
                    }
                }
            }

            return null; // No se encontró el elemento con el valor buscado
        }

        //Método que establece las opciones para los usuarios no loggeados
        public void SetUnregisteredOptions() {

            MenuItem usr = FindMenuItemByValue(innerMenu.Items, "usr_option");

            // Crear una lista para almacenar los elementos a eliminar
            List<MenuItem> itemsToRemove = new List<MenuItem>();

            // Identificar los elementos que se van a eliminar
            foreach (MenuItem item in usr.ChildItems)
            {
                itemsToRemove.Add(item);
            }

            // Eliminar los elementos identificados
            foreach (MenuItem item in itemsToRemove)
            {
                usr.ChildItems.Remove(item);
            }

            //Añadimos los items para los usuarios no registrados
            MenuItem login = new MenuItem("Login");
            login.Value = "login";
            login.NavigateUrl = "~/login.aspx";

            MenuItem register = new MenuItem("Register");
            register.Value = "register";
            register.NavigateUrl = "~/register.aspx";

            usr.ChildItems.Add(login);
            usr.ChildItems.Add(register);
        }

        //Método que comprueba si está registrado
        public bool isAdmin(ENUsuario usuario)
        {
            if (usuario.Admin == true) return true;
            else return false;
        }

        //Método que comprueba si es admin
        public bool isLogged(ENUsuario usuario)
        {
            if (usuario.Email != null) return true;
            else return false;
        }

        //Método que establece las opciones para los usuarios registrados
        public void SetRegisteredOptions()
        {

            MenuItem usr = FindMenuItemByValue(innerMenu.Items, "usr_option");

            // Crear una lista para almacenar los elementos a eliminar
            List<MenuItem> itemsToRemove = new List<MenuItem>();

            // Identificar los elementos que se van a eliminar
            foreach (MenuItem item in usr.ChildItems)
            {
                itemsToRemove.Add(item);
            }

            // Eliminar los elementos identificados
            foreach (MenuItem item in itemsToRemove)
            {
                usr.ChildItems.Remove(item);
            }

            //Añadimos los items para los usuarios registrados
            MenuItem account = new MenuItem("Mi cuenta");
            account.Value = "user";
            account.NavigateUrl = "~/user.aspx";

            MenuItem orders = new MenuItem("Mis pedidos");
            orders.Value = "my_orders";
            orders.NavigateUrl = "~/pedidos.aspx";

            MenuItem log_out = new MenuItem("Cerrar sesión");
            log_out.Value = "log_out";

            usr.ChildItems.Add(account);
            usr.ChildItems.Add(orders);
            usr.ChildItems.Add(log_out);
        }

        //Método que establece las opciones para los usuarios que a su vez son administradores
        public void SetAdminOptions()
        {

            MenuItem usr = FindMenuItemByValue(innerMenu.Items, "usr_option");

            // Crear una lista para almacenar los elementos a eliminar
            List<MenuItem> itemsToRemove = new List<MenuItem>();

            // Identificar los elementos que se van a eliminar
            foreach (MenuItem item in usr.ChildItems)
            {
                itemsToRemove.Add(item);
            }

            // Eliminar los elementos identificados
            foreach (MenuItem item in itemsToRemove)
            {
                usr.ChildItems.Remove(item);
            }

            //Añadimos los items para los usuarios registrados
            MenuItem account = new MenuItem("Mi cuenta");
            account.Value = "user";
            account.NavigateUrl = "~/user.aspx";

            MenuItem orders = new MenuItem("Mis pedidos");
            orders.Value = "my_orders";
            orders.NavigateUrl = "~/pedidos.aspx";

            var log_out = new MenuItem("Cerrar sesión");
            log_out.Value = "log_out";

            MenuItem admin_product = new MenuItem("Añadir artículo");
            admin_product.Value = "add_product";
            admin_product.NavigateUrl = "~/admin_productos.aspx";

            MenuItem admin_order = new MenuItem("Administrar pedidos");
            admin_order.Value = "admin_orders";
            admin_order.NavigateUrl = "~/admin_pedidos.aspx";

            MenuItem admin_user = new MenuItem("Administrar usuarios");
            admin_user.Value = "admin_user";
            admin_user.NavigateUrl = "~/admin_usuarios.aspx";

            usr.ChildItems.Add(account);
            usr.ChildItems.Add(orders);
            usr.ChildItems.Add(log_out);
            usr.ChildItems.Add(admin_product);
            usr.ChildItems.Add(admin_order);
            usr.ChildItems.Add(admin_user);
        }

        //Método con los eventos OnClick del menú de usuario y carrito
        protected void innerMenu_MenuItemClick(object sender, MenuEventArgs e)
        {
            string item = e.Item.Value;

            if(item == "log_out")
            {
                usuario = new ENUsuario();
                Response.Redirect("~/index.aspx");
            }

        }
    }
}
