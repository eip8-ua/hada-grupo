using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENContactUs
    {

        private int _id;
        private string _nombre;
        private string _email;
        private string _telefono;
        private string _mensaje;

        public int id
        {
            get { return _id; }
            set { _id = value; }
        }

        public string telefono
        {
            get { return _telefono; }
            set { _telefono = value; }
        }
        public string nombre
        {
            get { return _nombre; }
            set { _nombre = value; }
        }
        public string email
        {
            get { return _email; }
            set { _email = value; }
        }
        public string mensaje
        {
            get { return _mensaje; }
            set { _mensaje = value; }
        }

        public ENContactUs()
        {

        }

        public ENContactUs(int id = -1, string nombre = "", string email = "", string telefono = "", string mensaje ="" )
        {
            this.id = id;

            if (nombre != "")
                this.nombre = nombre;
            if (email != "")
                this.email = email;
            if (mensaje != "")
                this.mensaje = mensaje;
            if (telefono != "")
                this.telefono = telefono;
        }

        public bool Create()
        {
            CADContactUs cad = new CADContactUs();
            return cad.Create(this);
        }
        public bool Delete()
        {
            CADContactUs cad = new CADContactUs();
            return cad.Delete(this);
        }
        public bool Update()
        {
            CADContactUs cad = new CADContactUs();
            return cad.Update(this);
        }
        public bool Read()
        {
            CADContactUs cad = new CADContactUs();
            return cad.Read(this);
        }

        public bool SolicitudExiste()
        {
            CADContactUs cad = new CADContactUs();
            return cad.SolicitudExiste(this);
        }
    }
}
