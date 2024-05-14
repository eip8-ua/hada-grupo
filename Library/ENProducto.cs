using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class ENProducto
    {
        
        private ENCategoria _categoria;
        private int _id;
        private int _stock;
        private float _pvp;
        private string _nombre;
        private string _descripcion;
        private int _popularidad;
        private string _url_image;
        private ENPromociones _promocion;

        public ENCategoria categoria
        {
            get { return _categoria; }
            set { _categoria = categoria; }
        }

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

        public ENPromociones promocion
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
            {
                this.categoria.descripcion = cat.descripcion;
                this.categoria.tipo = cat.tipo;
            }
            if (prom != null)
            {
                this.promocion.Descuento = prom.Descuento;
                this.promocion.MiId = prom.MiId;
            }
                
        
        }

        public bool Create()
        {
            CADProducto cad = new CADProducto();
            if (cad.Create(this))
            {
                return true;
            }

            return false;
        }
        public bool Delete()
        {
            CADProducto cad = new CADProducto();
            if (cad.Delete(this))
            {
                return true;
            }

            return false;
        }
        public bool Update()
        {
            CADProducto cad = new CADProducto();
            if (cad.Update(this))
            {
                return true;
            }

            return false;
        }
        public bool Read()
        {
            CADProducto cad = new CADProducto();
            if (cad.Read(this))
            {
                return true;
            }

            return false;
        }
    }
}
