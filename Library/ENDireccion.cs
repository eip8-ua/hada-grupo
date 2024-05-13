using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENDireccion
    {
        private string _calle, _cod_postal, _ciudad,_provincia,_pais;
        private CADDireccion con;

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
            set { _provincia = provincia; }
        }
        public string pais
        {
            get { return _pais; }
            set { _pais = pais; }
        }
        public string cod_postal
        {
            get { return _cod_postal; }
            set { _cod_postal = cod_postal; }
        }

        public ENDireccion()
        {

        }
        public ENDireccion(string calle,string cod_postal,string ciudad = "",string provincia="",string pais = "")
        {
            this.calle = calle;
            this.cod_postal = cod_postal;
            if(ciudad != "")
                this.ciudad = ciudad;
            if (provincia != "")
                this.provincia = provincia;
            if (pais != "")
                this.pais = pais;
        }
        public ENDireccion(ENDireccion dir)
        {
            this.calle = dir.calle;
            this.cod_postal = dir.cod_postal;
            this.ciudad = dir.ciudad;
            this.provincia = dir.provincia;
            this.pais = dir.pais;
        }

        public bool Create()
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
        public bool Delete()
        {
            return false;
        }
    }
}
