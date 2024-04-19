using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class CADLinCarr
    {
        public string constring;

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADLinCarr() { }

        /// <summary>
        /// Método que inserta una Linea de Carrito en la BD
        /// </summary>
        /// <param name="en">EN con los datos de la Linea de Carrito</param>
        /// <returns></returns>
        public bool Create(ENLinCarr en)
        {
            return true;
        }

        /// <summary>
        /// Método que actualiza una Linea de Carrito en la BD
        /// </summary>
        /// <param name="en">EN con los datos de la Linea de Carrito</param>
        /// <returns></returns>
        public bool Update(ENLinCarr en)
        {
            return true;
        }

        /// <summary>
        /// Método que lee los datos de una Linea de Carrito de la BD
        /// </summary>
        /// <param name="en">EN con los datos de la Linea de Carrito</param>
        /// <returns></returns>
        public bool Read(ENLinCarr en)
        {
            return true;
        }

        /// <summary>
        /// Método que elimina una Linea de Carrito de la BD
        /// </summary>
        /// <param name="en">EN con los datos de la Linea de Carrito</param>
        /// <returns></returns>
        public bool Delete(ENLinCarr en)
        {
            return true;
        }
    }
}
