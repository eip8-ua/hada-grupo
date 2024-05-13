namespace Library
{
    /// <summary>
    /// Representa una dirección, si ciudad,provinica o pais están vacios pasan a ser null
    /// </summary>
    public class ENDireccion
    {
        private int _id;
        private string _calle, _cod_postal, _ciudad, _provincia, _pais;

        public int id
        {
            get { return _id; }
            set
            {
                if (value < 1)
                    _id = -1;
                else
                    _id = value;
            }
        }
        public string calle
        {
            get { return _calle; }
            set
            {
                _calle = value;
            }
        }
        public string ciudad
        {
            get { return _ciudad; }
            set { _ciudad = value; }
        }
        public string provincia
        {
            get { return _provincia; }
            set
            {
                if (value != "")
                    _provincia = value;
                else
                    _provincia = null;
            }
        }
        public string pais
        {
            get { return _pais; }
            set
            {
                if (value != "")
                    _pais = value;
                else
                    _pais = null;
            }
        }
        public string cod_postal
        {
            get { return _cod_postal; }
            set
            {
                if (value != "")
                    _cod_postal = value;
                else
                    _cod_postal = null;
            }
        }

        public ENDireccion()
        {

        }
        public ENDireccion(string calle, string cod_postal, string ciudad = null, string provincia = null, string pais = null)
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

        public string str()
        {
            return this.id.ToString() + " " + this.calle.ToString() + " " + this.cod_postal + " " + this.ciudad + " " + this.provincia + " " + this.pais;
        }
    }
}
