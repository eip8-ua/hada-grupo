using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENCarrito
    {
        private int _num_carrito;
        private DateTime _fecha;

        public int Num_carrito { set { _num_carrito = value; } get { return _num_carrito; } }
        public DateTime Fecha { set { _fecha = value; } get { return _fecha; } }
        

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public ENCarrito() { }

        /// <summary>
        /// Constructor con los todos los datos del Carrito
        /// </summary>
        /// <param name="num_carrito"></param>
        /// <param name="fecha"></param>
        public ENCarrito(int num_carrito, DateTime fecha)
        {
            Num_carrito = num_carrito;
            Fecha = fecha;
        }
        /// <summary>
        /// Método que crea un carrito con los datos almacenados en el objeto EN
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Create()
        {
            CADCarrito cadCarr = new CADCarrito();
            return cadCarr.Create(this);
        }

        /// <summary>
        /// Método que actualiza el carrito 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Update()
        {
            CADCarrito cadCarr = new CADCarrito();
            return cadCarr.Update(this);
        }
        /// <summary>
        /// Método que extrae los datos del carrito 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Read()
        {
            CADCarrito cadCarr = new CADCarrito();
            return cadCarr.Read(this);
        }
        /// <summary>
        /// Método que elimina el carrito 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Delete()
        {
            CADCarrito cadCarr = new CADCarrito();
            return cadCarr.Delete(this);
        }
    }
}
