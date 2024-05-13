using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENProducto
    {
        private ENPromociones promocion;
        private ENCategoria categoria;
        private int _id;
        private int _stock;
        private float _pvp;
        private string _nombre;
        private string _descripcion;
        private int _popularidad;

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
                this.categoria = new ENCategoria(cat);
            if (prom != null)
                this.promocion = new ENPromociones(prom);
        
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
