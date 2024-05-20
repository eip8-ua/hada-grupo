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
            set { _tipo = value; }
        }
        public string descripcion
        {
            get { return _descripcion; }
            set { _descripcion = value; }
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
            tipo = cat.tipo;
            descripcion = cat.descripcion;
        }

        public bool Create()
        {
            CADCategoria cad = new CADCategoria();
            return cad.Create(this);
        }
        public bool Delete()
        {
            CADCategoria cad = new CADCategoria();
            return cad.Delete(this);
        }
        public bool Update()
        {
            CADCategoria cad = new CADCategoria();
            return cad.Update(this);
        }
        public bool Read()
        {
            CADCategoria cad = new CADCategoria();
            return cad.Read(this);
        }

        public static ENCategoria getCategoria(string tipo)
        {
            CADCategoria categ = new CADCategoria();

            ENCategoria cat = new ENCategoria(tipo);
            categ.Read(cat);
            
            return cat;
        }

        /// <summary>
        /// Devuelve una lista con todas las categorías. 
        /// Si da error devuelve una lista vacía 
        /// </summary>
        /// <returns></returns>
        public static List<ENCategoria> Get_All_Categorias()
        {
            CADCategoria cad = new CADCategoria();        
            return cad.Read_All();
        }
    }
}
