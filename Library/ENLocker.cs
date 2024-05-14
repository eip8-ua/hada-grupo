using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENLocker
    {
        private int _id;
        private string _nombre;
        private ENDireccion _dir;

        public int id
        {
            get { return _id; }
            set { _id = value > 0 ? value : -1; }
        }
        public string nombre
        {
            get { return _nombre; }
            set { _nombre = value; }
        }
        public ENDireccion dir
        {
            get { return _dir; }
            set { _dir = new ENDireccion(value); }
        }

        /// <summary>
        /// Constructor vacio, inicializa las variables
        /// id = -1,nombre = null, dir(es una direccion) a un objeto vacio de ENDireccion();
        /// </summary>
        public ENLocker()
        {
            id = -1;
            nombre = null;
            dir = new ENDireccion();
        }

        /// <summary>
        /// Inicializa el objeto con los parametros recibidos
        /// </summary>
        /// <param name="id"></param>
        /// <param name="nombre"></param>
        /// <param name="dir"></param>
        public ENLocker(int id, string nombre = "",ENDireccion dir = null)
        {
            this.id = id;
            if (nombre != "")
                this.nombre = nombre;
            if (dir != null)
                this.dir = dir;
        }

        /// <summary>
        /// Añade el locker a la db
        /// </summary>
        /// <returns>Devuelve v o f si ha sido todo correcto</returns>
        public bool Create()
        {
            CADLocker con = new CADLocker();
            return con.Create(this);
        }

        /// <summary>
        /// Borra el locker de la db usando el id
        /// </summary>
        /// <returns>Devuelve v o f si ha sido todo correcto</returns>
        public bool Delete()
        {
            CADLocker con = new CADLocker();
            return con.Delete(this);
        }

        /// <summary>
        /// Actualiza el locker en la db usando el id
        /// </summary>
        /// <returns>Devuelve v o f si ha sido todo correcto</returns>
        public bool Update()
        {
            CADLocker con = new CADLocker();
            return con.Update(this);
        }

        /// <summary>
        /// Obtiene el locker de la db usando el id
        /// </summary>
        /// <returns>Devuelve v o f si ha sido todo correcto</returns>
        public bool Read()
        {
            CADLocker con = new CADLocker();
            return con.Read(this);
        }
    }
}
