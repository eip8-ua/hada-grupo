using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class ENProducto
    {
        
        private ENCategoria categoria;
        private int _id;
        private int _stock;
        private float _pvp;
        private string _nombre;
        private string _descripcion;
        private int _popularidad;
        private string _url_image;
        private int _promocion;

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
        public int stock
        {
            get { return _stock; }
            set { _stock = stock; }
        }
        public float pvp
        {
            get { return _pvp; }
            set { _pvp = pvp; }
        }

        public string descripcion
        {
            get { return _descripcion; }
            set { _descripcion = descripcion; }
        }
        public int popularidad
        {
            get { return _popularidad; }
            set { _popularidad = popularidad; }
        }

        public string url_image
        {
            get { return _url_image; }
            set { _url_image = url_image; }
        }

        public int promocion
        {
            get { return _promocion; }
            set { _promocion = promocion; }
        }

        public ENProducto()
        {

        }
        public ENProducto(int id, int stock, string descripcion, int popularidad, string nombre = "", ENCategoria cat = null, ENPromociones prom = null)
        {
            this.id = id;
            this.pvp = pvp;
            this.popularidad = popularidad;
            this.stock = stock;

            if (nombre != "")
                this.nombre = nombre;
            if (descripcion != "")
                this.descripcion = descripcion;
            if (cat != null)
                this.categoria = cat;
            if (prom != null)
                this.promocion = prom;
        
        }
    }
}
