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
        public ENUsuario usuario = new ENUsuario();
        protected void Page_Load(object sender, EventArgs e) { 
        
            if (!IsPostBack)
            {   
                if(usuario.Admin == true)
                {
                    SetAdminOptions();
                } else if(usuario.Email != null) {
                    SetRegisteredOptions();
                } else
                {
                    SetUnregisteredOptions();
                }
                textbox.Text = "No Post Back";
            }
            else { 
                textbox.Text = "Post Back";
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
            log_out.NavigateUrl = "~/index.aspx";

            usr.ChildItems.Add(account);
            usr.ChildItems.Add(orders);
            usr.ChildItems.Add(log_out);
        }

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

            MenuItem log_out = new MenuItem("Cerrar sesión");
            log_out.Value = "log_out";
            log_out.NavigateUrl = "~/index.aspx";

            MenuItem admin_product = new MenuItem("Añadir artículo");
            admin_product.Value = "add_product";
            admin_product.NavigateUrl = "~/admin_productos.aspx";

            MenuItem admin_order = new MenuItem("Administrar pedidos");
            admin_order.Value = "admin_orders";
            admin_order.NavigateUrl = "~/admin_pedidos.aspx";

            MenuItem admin_user = new MenuItem("Administrar usuario");
            admin_user.Value = "admin_user";
            admin_user.NavigateUrl = "~/admin_usuarios.aspx";

            usr.ChildItems.Add(account);
            usr.ChildItems.Add(orders);
            usr.ChildItems.Add(log_out);
            usr.ChildItems.Add(admin_product);
            usr.ChildItems.Add(admin_order);
            usr.ChildItems.Add(admin_user);
        }
    }
}
