using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    [Serializable]
    public class ENTestimonial
    {
        int _id;
        String _message;

        public int Id { set { _id = value;  } get { return _id;  } }
        public String Message { set { _message = value; } get { return _message; } }

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public ENTestimonial(){}

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
        public bool Create() 
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.Create(this);
        }
        /// <summary>
        /// Método que actualiza el testimonio
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Update()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.Update(this);
        }
        /// <summary>
        /// Método que extrae los datos del testimonio
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Read()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.Read(this);
        }
        /// <summary>
        /// Método que elimina el testimonio
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Delete()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.Delete(this);
        }

        // *****     MÉTODOS EXTRA     *****
        /// <summary>
        /// Método que lee el primer testimonio almacenado en la BD
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadFirst()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.ReadFirst(this);
        }
        /// <summary>
        /// Método que lee el testimonio almacenado justo después del actual  en la BD
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadNext()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.ReadNext(this);
        }

        /// <summary>
        /// Método que lee el testimonio almacenado justo antes del actual  en la BD
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool ReadPrev()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.ReadPrev(this);
        }

        public List<ENTestimonial> ObtenerTestimonios()
        {
            CADTestimonial cadTes = new CADTestimonial();
            return cadTes.ObtenerTestimonios();
        }

    }
}
