using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class ENLocker
    {
        private int _id;
        private string _nombre;
        private ENDireccion dir;
        private CADLocker con;

        public int id
        {
            get { return _id; }
            set { _id = id; }
        }
        public string nombre
        {
            get { return _nombre; }
            set { _nombre = nombre; }
        }

        public ENLocker()
        {

        }
        public ENLocker(int id, string nombre = "",ENDireccion dir = null)
        {
            this.id = id;
            if (nombre != "")
                this.nombre = nombre;
            if (dir != null)
                this.dir = new ENDireccion(dir);
        }

        public bool Create()
        {

        }
        public bool Delete()
        {

        }
        public bool Update()
        {

        }
        public bool Read()
        {

        }
    }
}
