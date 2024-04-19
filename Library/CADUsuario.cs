using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class CADUsuario
    {
        private string conexion;
        
        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADUsuario() { }
        /// <summary>
        /// Método que inserta un Usuario en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public bool create(ENUsuario en)
        {
            return true;
        }
        /// <summary>
        /// Método que actualiza un Usuario en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public bool update(ENUsuario en)
        {
            return true;
        }
        /// <summary>
        /// Método que lee los datos de un Usuario de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public bool read(ENUsuario en)
        {
            return true;
        }
        /// <summary>
        /// Método que elimina un Usuario de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public bool delete(ENUsuario en)
        {
            return true;
        }
        /// <summary>
        /// Método que inserta un Usuario en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Usuario</param>
        /// <returns></returns>
        public bool admin(ENUsuario en)
        {
            return true;
        }
    }
}
