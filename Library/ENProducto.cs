using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENProducto
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
            set { _categoria = new ENCategoria(categoria); }
        }

        public int id
        {
            get { return _id; }
            set { _id = value; }
        }
        public string nombre
        {
            get { return _nombre; }
            set { _nombre = value; }
        }
        public int stock
        {
            get { return _stock; }
            set { _stock = value; }
        }
        public float pvp
        {
            get { return _pvp; }
            set { _pvp = value; }
        }

        public string descripcion
        {
            get { return _descripcion; }
            set { _descripcion = value; }
        }
        public int popularidad
        {
            get { return _popularidad; }
            set { _popularidad = value; }
        }

        public string url_image
        {
            get { return _url_image; }
            set { _url_image = value; }
        }

        public ENPromociones promocion
        {
            get { return _promocion; }
            set { _promocion = new ENPromociones(promocion); }
        }

        public ENProducto()
        {
            _promocion = new ENPromociones();
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

        static public List<ENProducto> productosPorColumna(string col, string valor)
        {

            CADProducto cad = new CADProducto();
            switch (col)
            {
                case "categoria":
                    
                    return cad.ProductosPorColumna(col, valor);

                case "id":
                    if (!Int32.TryParse(valor, out Int32 aux1))
                    {
                        Console.WriteLine("Valor no correcto");
                        return null;
                    }

                    else return cad.ProductosPorColumna(col, valor);

                case "stock":
                    if (!Int32.TryParse(valor, out Int32 aux2))
                    {
                        Console.WriteLine("Valor no correcto");
                        return null;
                    }

                    else return cad.ProductosPorColumna(col, valor);

                case "descripcion":
                    
                    return cad.ProductosPorColumna(col, valor);

                case "pvp":
                    if (!Double.TryParse(valor, out Double aux4))
                    {
                        Console.WriteLine("Valor no correcto");
                        return null;
                    }

                    else return cad.ProductosPorColumna(col, valor);

                case "nombre":
                    
                    return cad.ProductosPorColumna(col, valor);

                case "popularidad":
                    if (!Int32.TryParse(valor, out Int32 aux6))
                    {
                        Console.WriteLine("Valor no correcto");
                        return null;
                    }

                    else return cad.ProductosPorColumna(col, valor);

                case "url_image":
                    if (!Int32.TryParse(valor, out Int32 aux7))
                    {
                        Console.WriteLine("Valor no correcto");
                        return null;
                    }

                    else return cad.ProductosPorColumna(col, valor);

                case "promocion":
                    if (!Int32.TryParse(valor, out Int32 aux8))
                    {
                        Console.WriteLine("Valor no correcto");
                        return null;
                    }

                    else return cad.ProductosPorColumna(col, valor);

                default:
                    Console.WriteLine("Columna no correcta");
                    return null;

            }
        }


    }
}
