using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace Library
{
    class CADCarrito
    {
        private string constring { get; set; }

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADCarrito() {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        /// <summary>
        /// Método que inserta un Carrito en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Carrito</param>
        /// <returns></returns>
        public bool Create(ENCarrito en)
        {
          
            return true;
        }

        /// <summary>
        /// Método que actualiza un Carrito en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Carrito</param>
        /// <returns></returns>
        public bool Update(ENCarrito en)
        {
            return true;
        }

        /// <summary>
        /// Método que lee los datos de un Carrito de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Carrito</param>
        /// <returns></returns>
        public bool Read(ENCarrito en)
        {
            return true;
        }

        /// <summary>
        /// Método que elimina un Carrito de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Carrito</param>
        /// <returns></returns>
        public bool Delete(ENCarrito en)
        {
            return true;
        }
    }
}
