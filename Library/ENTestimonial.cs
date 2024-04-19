using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class ENTestimonial
    {
        int _id;
        String _message;

        int Id { set { _id = value;  } get { return _id;  } }
        String Message { set { _message = value; } get { return _message; } }

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public ENTestimonial() { }
        /// <summary>
        /// Constructor con los datos del Testimonio
        /// </summary>
        /// <param name="id"></param>
        /// <param name="message"></param>
        public ENTestimonial(int id, String message)
        {
            Id = id;
            Message = message;
        }
        /// <summary>
        /// Método que crea un nuevo Testimonio con los datos almacenados en el objeto EN
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool create() 
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.create(this);
        }
        /// <summary>
        /// Método que actualiza el testimonio
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool update()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.update(this);
        }
        /// <summary>
        /// Método que extrae los datos del testimonio
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool read()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.read(this);
        }
        /// <summary>
        /// Método que elimina el testimonio
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool delete()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.delete(this);
        }
    }
}
