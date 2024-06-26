﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENProducto
    {
        private int _id;
        private int _stock;
        private float _pvp;
        private string _nombre;
        private string _descripcion;
        private int _popularidad;
        private string _url_image;
        private ENPromociones _promocion;
        private ENCategoria _categoria;

        public ENCategoria categoria
        {
            get { return _categoria; }
            set
            {
                if (value != null)
                    _categoria = new ENCategoria(value);
                else
                    _categoria = null;
            }
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
            set
            {
                if (value != null)
                    _promocion = new ENPromociones(value);
                else
                    _promocion = null;
            }
        }

        public ENProducto()
        {
            _promocion = new ENPromociones();
        }
        public ENProducto(int id, float pvp, int stock, int popularidad, string descripcion = "", string nombre = "", string url_image = "", ENCategoria cat = null, ENPromociones prom = null)
        {
            this.id = id;
            this.pvp = pvp;
            this.popularidad = popularidad;
            this.stock = stock;

            if (nombre != "")
                this.nombre = nombre;
            if (descripcion != "")
                this.descripcion = descripcion;
            if (url_image != "")
                this.url_image = url_image;

            categoria = cat;
            promocion = prom;
        }

        public ENProducto(ENProducto prod)
        {
            id = prod.id;
            pvp = prod.pvp;
            stock = prod.stock;
            popularidad = prod.popularidad;
            nombre = prod.nombre;
            descripcion = prod.descripcion;
            url_image = prod.url_image;
            categoria = prod.categoria;
            promocion = prod.promocion;

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
        static public List<ENProducto> ObtenerTodosLosProductos()
        {
            CADProducto cad = new CADProducto();
            return cad.ObtenerProductos();
        }

        private ENProducto ObtenerProductoPorId(int productId)
        {
            // Implementa este método para obtener los detalles del producto desde la base de datos
            CADProducto cadProducto = new CADProducto();
            ENProducto producto = new ENProducto();
            producto.id = productId;

            if (cadProducto.Read(producto))
            {
                return producto;
            }
            return null;
        }

        public static List<ENProducto> FiltrarProductos(string categoria, decimal minPrice, decimal maxPrice)
        {
            CADProducto cadProducto = new CADProducto();
            return cadProducto.FiltrarProductos(categoria, minPrice, maxPrice);
        }


    }
}
