using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENCarritoDe
    {
        private int _usuario;
        private int _carrito;

        public int Usuario { set { _usuario = value; } get { return _usuario; } }
        public int Carrito { set { _carrito = value; } get { return _carrito; } }
       
        /// <summary>
        /// Constructor vacío
        /// </summary>
        public ENCarritoDe() { }

        /// <summary>
        /// Constructor con los todos los datos de la linea de Carrito
        /// </summary>
        /// <param name="usuario"></param>
        /// <param name="cantidad"></param>
        public ENCarritoDe(int usuario, int carrito)
        {
            Usuario = usuario;
            Carrito = carrito;
        }
        /// <summary>
        /// Método que crea una linea de carrito con los datos almacenados en el objeto EN
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Create()
        {
            CADCarritoDe cadCarritoDe = new CADCarritoDe();
            return cadCarritoDe.Create(this);
        }

        /// <summary>
        /// Método que actualiza la linea de carrito 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Update()
        {
            CADCarritoDe cadCarritoDe = new CADCarritoDe();
            return cadCarritoDe.Update(this);
        }
        /// <summary>
        /// Método que extrae los datos de la linea de carrito 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Read()
        {
            CADCarritoDe cadCarritoDe = new CADCarritoDe();
            return cadCarritoDe.Read(this);
        }
        /// <summary>
        /// Método que elimina la linea de carrito 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Delete()
        {
            CADCarritoDe cadCarritoDe = new CADCarritoDe();
            return cadCarritoDe.Delete(this);
        }

        public bool UserExists(ENUsuario user)
        {
            CADCarritoDe cadCarritoDe = new CADCarritoDe();
            return cadCarritoDe.UserExists(user);
        }

        public int GetCartIdByUser(ENUsuario user)
        {
            CADCarritoDe cadCarritoDe = new CADCarritoDe();
            return cadCarritoDe.GetCartIdByUser(user);
        }
    }
}
