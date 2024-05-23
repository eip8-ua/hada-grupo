using System;
using System.Collections.Generic;
using System.Data;

namespace Library
{
    public class ENValoraciones
    {
        private ENUsuario _usuario;
        private ENProducto _producto;
        private int? _puntuacion;
        private string _descripcion;

        public ENUsuario Usuario
        {
            get { return _usuario; }
            set { _usuario = new ENUsuario(value); }
        }
        public ENProducto Producto
        {
            get { return _producto; }
            set { _producto = new ENProducto(value); }
        }
        public int? Puntuacion 
        {
            get { return _puntuacion; }
            set { _puntuacion = value; } 
        }
        public string Descripcion 
        {
            get { return _descripcion; }
            set { _descripcion = value; }
        }


        public ENValoraciones()
        {
            Usuario = new ENUsuario();
            Producto = new ENProducto();
        }

        public ENValoraciones(ENValoraciones val)
        {
            Usuario = val.Usuario;
            Producto = val.Producto;
            Puntuacion = val.Puntuacion;
            Descripcion = val.Descripcion;
        }

        /// <summary>
        /// Devuelve todas las reviews de este producto
        /// </summary>
        /// <returns></returns>
        public List<ENValoraciones> Get_All_Product_Reviews()
        {
            List<ENValoraciones> list_vals = new List<ENValoraciones>();
            CADValoraciones cad = new CADValoraciones();
            DataTable table = cad.ObtenerValoracionesAnteriores(this);

            foreach(DataRow i in table.Rows)
            {
                ENValoraciones val = new ENValoraciones();
                val.Usuario.Id = Convert.ToInt32(i["usuario"]);
                val.Usuario.Read_Id();
                val.Puntuacion = Convert.ToInt32(i["puntuacion"]);
                val.Descripcion = i["descripcion"].ToString();

                list_vals.Add(val);
            }

            return list_vals;
        }

        /// <summary>
        /// Añade esta valoracion a la db
        /// </summary>
        /// <returns></returns>
        public bool Add_Review()
        {
            CADValoraciones cad = new CADValoraciones();
            return cad.Create(this);
        }
    }
}
