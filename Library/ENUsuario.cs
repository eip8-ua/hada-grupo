using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENUsuario
    {
        int _id;
        String _dni;
        String _email;
        String _nombre;
        string _passwd;
        String _apellidos;
        String _tlfn;
        DateTime _fNacimiento;
        bool _admin;
        

        public int Id { set { _id = value; } get { return _id; } }
        public String Dni { set { _dni = value; } get { return _dni; } }
        public String Email { set { _email = value; } get { return _email; } }
        public String Nombre { set { _nombre = value; } get { return _nombre; } }
        public String Passwd { set { _passwd = value; } get { return _passwd; } }
        public String Apellidos { set { _apellidos = value; } get { return _apellidos; } }
        public String Tlfn { set { _tlfn = value; } get { return _tlfn; } }
        public DateTime FNacimiento { set { _fNacimiento = value; } get { return _fNacimiento; } }
        public bool Admin { set { _admin = value; } get { return _admin; } }
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
        /// <param name="passwd"></param>
        /// <param name="apellidos"></param>
        /// <param name="tlfn"></param>
        /// <param name="fNacimiento"></param>
        /// <param name="admin"></param>
        public ENUsuario(int id, String dni, String email, String nombre, String passwd, String apellidos, String tlfn, DateTime fNacimiento, bool admin)
        {
            Id = id;
            Dni = dni;
            Email = email;
            Nombre = nombre;
            Passwd = passwd;
            Apellidos = apellidos;
            Tlfn = tlfn;
            FNacimiento = fNacimiento;
            Admin = admin;
        }

        /// <summary>
        /// Constructor de copia
        /// </summary>
        /// <param name="to_copy">Objeto a copiar</param>
        public ENUsuario(ENUsuario to_copy)
        {
            Id = to_copy.Id;
            Dni = to_copy.Dni;
            Email = to_copy.Email;
            Nombre = to_copy.Nombre;
            Passwd = to_copy.Passwd;
            Apellidos = to_copy.Apellidos;
            Tlfn = to_copy.Tlfn;
            FNacimiento = to_copy.FNacimiento;
            Admin = to_copy.Admin;
        }

        /// <summary>
        /// Método que crea un usuario con los datos almacenados en el objeto EN
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Create()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.Create(this);
        }

        /// <summary>
        /// Método que actualiza el usuario 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Update()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.Update(this);
        }

        /// <summary>
        /// Método que extrae los datos del usuario 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Read()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.Read(this);
        }

        /// <summary>
        /// Método que elimina el usuario 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Delete()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.Delete(this);
        }


        // *****     MÉTODOS EXTRA     *****


        /// <summary>
        /// Método que comprueba si un usuario está registrado
        /// </summary>
        /// <returns>True si lo está; False si no</returns>
        public bool Registrado()
        {
            return Read();
        }

        /// <summary>
        /// Método que comprueba si un usuario es Administrador
        /// </summary>
        /// <returns>True si lo es; False si no</returns>
        public bool IsAdmin()
        {         
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.IsAdmin(this);
        }

        /// <summary>
        /// Método que extrae los datos del primer usuario encontrado en la base de datos
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadFirst()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.ReadFirst(this);
        }

        /// <summary>
        /// Método que extrae los datos del siguiente usuario encontrado en la base de datos
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadNext()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.ReadNext(this);
        }

        /// <summary>
        /// Método que extrae los datos del siguiente usuario encontrado en la base de datos
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadPrev()
        {
            CADUsuario cadUsu = new CADUsuario();
            return cadUsu.ReadPrev(this);
        }

        /// <summary>
        /// Si el usuario es válido cambia todos los datos del objeto 
        /// por los de la base de datos, si no los deja igual. 
        /// </summary>
        /// <returns>Devuelve si el usuario es válido o no</returns>
        public bool Validate()
        {
            ENUsuario test = new ENUsuario(this);
            CADUsuario cad = new CADUsuario();
            if (cad.Validate(test) && this.Email == test.Email && this.Passwd == test.Passwd)
            {
                Id = test.Id;
                Dni = test.Dni;
                Email = test.Email;
                Nombre = test.Nombre;
                Passwd = test.Passwd;
                Apellidos = test.Apellidos;
                Tlfn = test.Tlfn;
                FNacimiento = test.FNacimiento;
                Admin = test.Admin;
                return true;
            }

            return false;
        }




    }
}
