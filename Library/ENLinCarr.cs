using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class ENLinCarr
    {
        private int _id;
        private int _cantidad;
        private int _carrito;
        private int _producto;

        public int Id { set { _id = value; } get { return _id; } }
        public int Cantidad { set { _cantidad = value; } get { return _cantidad; } }
        public int Carrito { set { _carrito = value; } get { return _carrito; } }
        public int Producto { set { _producto = value; } get { return _producto; } }



        /// <summary>
        /// Constructor vacío
        /// </summary>
        public ENLinCarr() { }

        /// <summary>
        /// Constructor con los todos los datos de la linea de Carrito
        /// </summary>
        /// <param name="id"></param>
        /// <param name="cantidad"></param>
        public ENLinCarr(int id, int cantidad)
        {
            Id = id;
            Cantidad = cantidad;
        }
        /// <summary>
        /// Método que crea una linea de carrito con los datos almacenados en el objeto EN
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Create()
        {
            CADLinCarr cadLinCarr = new CADLinCarr();
            return cadLinCarr.Create(this);
        }

        /// <summary>
        /// Método que actualiza la linea de carrito 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Update()
        {
            CADLinCarr cadLinCarr = new CADLinCarr();
            return cadLinCarr.Update(this);
        }
        /// <summary>
        /// Método que extrae los datos de la linea de carrito 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Read()
        {
            CADLinCarr cadLinCarr = new CADLinCarr();
            return cadLinCarr.Read(this);
        }
        /// <summary>
        /// Método que elimina la linea de carrito 
        /// </summary>
        /// <returns>True si lo ha realizado con éxito; False si no</returns>
        public bool Delete()
        {
            CADLinCarr cadLinCarr = new CADLinCarr();
            return cadLinCarr.Delete(this);
        }
    }
}
