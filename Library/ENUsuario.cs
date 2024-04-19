using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class ENUsuario
    {
        String _dni;
        String _email;
        String _nombre;
        String _apellidos;
        String _tlfn;
        DateTime _fNacimiento;
        bool _admin;

        String Dni { set { _dni = value; } get { return _dni; } }
        String Email { set { _email = value; } get { return _email; } }
        String Nombre { set { _nombre = value; } get { return _nombre; } }
        String Apellidos { set { _apellidos = value; } get { return _apellidos; } }
        String Tlfn { set { _tlfn = value; } get { return _tlfn; } }
        DateTime FNacimiento { set { _fNacimiento = value; } get { return _fNacimiento; } }
        bool Admin { set { _admin = value; } get { return _admin; } }
        CADUsuario cadUsuario;

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public ENUsuario() {}

        /// <summary>
        /// Constructor con los todos los datos del Usuario
        /// </summary>
        /// <param name="dni"></param>
        /// <param name="email"></param>
        /// <param name="nombre"></param>
        /// <param name="apellidos"></param>
        /// <param name="tlfn"></param>
        /// <param name="fNacimiento"></param>
        /// <param name="admin"></param>
        public ENUsuario(String dni, String email, String nombre, String apellidos, String tlfn, DateTime fNacimiento, bool admin)
        {
            Dni = dni;
            Email = email;
            Nombre = nombre;
            Apellidos = apellidos;
            Tlfn = tlfn;
            FNacimiento = fNacimiento;
            Admin = admin;
        }
        /// <summary>
        /// Método que crea un usuario con los datos almacenados en el objeto EN
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool create()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.create(this);
        }
        /// <summary>
        /// Método que actualiza el usuario 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool update()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.update(this);
        }
        /// <summary>
        /// Método que extrae los datos del usuario 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool read()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.read(this);
        }
        /// <summary>
        /// Método que elimina el usuario 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool delete()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.delete(this);
        }

        /// <summary>
        /// Método que comprueba si un usuario está registrado
        /// </summary>
        /// <returns>True si lo está; False si no</returns>
        public bool registrado()
        {
            return read();
        }

        /// <summary>
        /// Método que comprueba si un usuario es Administrador
        /// </summary>
        /// <returns>True si lo es; False si no</returns>
        public bool admin()
        {         
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.admin(this);
        }




    }
}
