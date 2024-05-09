using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    /// <summary>
    /// Representa una dirección, si ciudad,provinica o pais están vacios pasan a ser null
    /// </summary>
    class ENDireccion
    {
        private int _id;
        private string _calle, _cod_postal, _ciudad,_provincia,_pais;

        public int id
        {
            get { return _id; }
            set 
            {
                if (id < 1)
                    _id = -1;
                else
                    _id = id;
            }
        }
        public string calle
        {
            get { return _calle; }
            set { _calle = calle; }
        }
        public string ciudad
        {
            get { return _ciudad; }
            set {_ciudad = ciudad; }
        }
        public string provincia
        {
            get { return _provincia; }
            set 
            { 
                if (provincia != "")
                    _provincia = provincia;
                else
                    _provincia = null;
            }
        }
        public string pais
        {
            get { return _pais; }
            set 
            {
                if (pais != "")
                    _pais = pais;
                else
                    _pais = null;
            }
        }
        public string cod_postal
        {
            get { return _cod_postal; }
            set 
            {
                if (cod_postal != "")
                    _cod_postal = cod_postal;
                else
                    _cod_postal = null;
            }
        }

        public ENDireccion()
        {

        }
        public ENDireccion(string calle,string cod_postal,string ciudad = "",string provincia="",string pais = "")
        {
            this.calle = calle;
            this.cod_postal = cod_postal;
            if (ciudad != "")
                this.ciudad = ciudad;
            else
                this.ciudad = null;

            if (provincia != "")
                this.provincia = provincia;
            else
                this.provincia = null;
            if (pais != "")
                this.pais = pais;
            else
                this.pais = null;
        }
        public ENDireccion(ENDireccion dir)
        {
            this.id = dir.id;
            this.calle = dir.calle;
            this.cod_postal = dir.cod_postal;
            this.ciudad = dir.ciudad;
            this.provincia = dir.provincia;
            this.pais = dir.pais;
        }

        public bool Create()
        {
            CADDireccion con = new CADDireccion();
            return con.Create(this);
        }
        public bool Update()
        {
            CADDireccion con = new CADDireccion();
            return con.Update(this);
        }
        public bool Read()
        {
            CADDireccion con = new CADDireccion();
            return con.Read(this);
        }
        public bool Delete()
        {
            CADDireccion con = new CADDireccion();
            return con.Delete(this);
        }

        public bool is_correct()
        {
            if (string.IsNullOrEmpty(calle) && string.IsNullOrEmpty(cod_postal))
                return false;
            return true;
        }
    }
}
