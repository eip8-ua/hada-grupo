using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class CADTestimonial
    {
        private string conexion;
        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADTestimonial() { }
        /// <summary>
        /// Método que inserta el Testimonio en la BD
        /// </summary>
        /// <param name="en">EN del testimonio</param>
        /// <returns></returns>
        public bool create(ENTestimonial en)
        {
            return true;
        }
        /// <summary>
        /// Método que actualiza el Testimonio en la BD
        /// </summary>
        /// <param name="en">EN del testimonio</param>
        /// <returns></returns>
        public bool update(ENTestimonial en)
        {
            return true;
        }
        /// <summary>
        /// Método que lee el Testimonio de la BD
        /// </summary>
        /// <param name="en">EN del testimonio</param>
        /// <returns></returns>
        public bool read(ENTestimonial en)
        {
            return true;
        }
        /// <summary>
        /// Método que elimina el Testimonio de la BD
        /// </summary>
        /// <param name="en">EN del testimonio</param>
        /// <returns></returns>
        public bool delete(ENTestimonial en)
        {
            return true;
        }
    }
}
