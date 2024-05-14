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
        /// <summary>
        /// Si el id es negativo se establecerá a -1
        /// </summary>
        /// <param name="id"></param>
        /// <param name="calle"></param>
        /// <param name="cod_postal"></param>
        /// <param name="ciudad"></param>
        /// <param name="provincia"></param>
        /// <param name="pais"></param>
        public ENDireccion(int id,string calle, string cod_postal, string ciudad = null, string provincia = null, string pais = null)
        {
            this.id = id;
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

        /// <summary>
        /// Añade la direccion a la db
        /// </summary>
        /// <returns>Devuelve v o f si ha sido todo correcto</returns>
        public bool Create()
        {
            CADDireccion con = new CADDireccion();
            return con.Create(this);
        }

        /// <summary>
        /// Actualiza los datos de este objeto en la db
        /// </summary>
        /// <returns>Devuelve v o f si ha sido todo correcto</returns>
        public bool Update()
        {
            CADDireccion con = new CADDireccion();
            return con.Update(this);
        }

        /// <summary>
        /// Obtiene los datos de la direccion con el id de este objeto
        /// </summary>
        /// <returns>Devuelve v o f si ha sido todo correcto</returns>
        public bool Read()
        {
            CADDireccion con = new CADDireccion();
            return con.Read(this);
        }

        /// <summary>
        /// Borra la direccion con el id de este objeto
        /// </summary>
        /// <returns>Devuelve v o f si ha sido todo correcto</returns>
        public bool Delete()
        {
            CADDireccion con = new CADDireccion();
            return con.Delete(this);
        }
        /// <summary>
        /// Comprueba si la direccion existe en la base de datos
        /// </summary>
        /// <returns></returns>
        public bool Exists()
        {
            CADDireccion con = new CADDireccion();
            return con.Exists(this);
        }
        public bool is_correct()
        {
            if (string.IsNullOrEmpty(calle) && string.IsNullOrEmpty(cod_postal))
                return false;
            return true;
        }

        public string str()
        {
            string out1 = "";
            if(this.calle != null)
                out1 += " "+calle;
            if(this.cod_postal != null)
                out1 += " "+cod_postal;
            if (this.ciudad != null)
                out1 += " "+ciudad;
            if (this.provincia != null)
                out1 += " "+provincia;
            if (this.pais != null)
                out1 += " "+pais;
            return out1;
        }
    }
}
