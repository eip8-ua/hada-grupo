using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Library
{
    class ENPedido
    {
        private int numpedido;
        private DateTime fechaPedido;
        private int idUsuario;

        public int Numpedido
        {
            get { return numpedido; }
            set { numpedido = value; }
        }

        public DateTime FechaPedido
        {
            get { return fechaPedido; }
            set { fechaPedido = value; }
        }

        public int IdUsuario
        {
            get { return idUsuario; }
            set { idUsuario = value; }
        }

        public ENPedido() { }


        public ENPedido(int numpedido, DateTime fechaPedido, int idUsuario)
        {
            Numpedido = numpedido;
            FechaPedido = fechaPedido;
            IdUsuario = idUsuario;
        }

        public bool Create()
        {
            CADPedido con = new CADPedido();
            return con.Create(this);
        }
        public bool Update()
        {
            CADPedido con = new CADPedido();
            return con.Update(this);
        }
        public bool Read()
        {
            CADPedido con = new CADPedido();
            return con.Read(this);
        }
        public bool Delete()
        {
            CADPedido con = new CADPedido();
            return con.Delete(this);
        }

        public bool is_correct()
        {
            return Numpedido > 0 && IdUsuario > 0;
        }

        public static List<ENPedido> ReadAll()
        {
            CADPedido cadPedido = new CADPedido();
            return cadPedido.ReadAll();
        }
    }
}
