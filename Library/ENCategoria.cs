using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENCategoria
    {
        private string _tipo;
        private string _descripcion;

        public string tipo
        {
            get { return _tipo; }
            set { _tipo = tipo; }
        }
        public string descripcion
        {
            get { return _descripcion; }
            set { _descripcion = descripcion; }
        }

        public ENCategoria()
        {

        }
        public ENCategoria(string tipo = "", string descripcion = "")
        {
            if (tipo != "")
                this.tipo = tipo;
            if (descripcion != "")
                this.descripcion = descripcion;
           
        }
        public ENCategoria(ENCategoria cat)
        {

        }

        public bool Create()
        {
            return false;
        }
        public bool Delete()
        {
            return false;
        }
        public bool Update()
        {
            return false;
        }
        public bool Read()
        {
            return false;
        }

    }
}
