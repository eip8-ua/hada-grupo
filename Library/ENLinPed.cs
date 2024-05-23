using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENLinPed
    {
        private int? idLinPedido;
        private int? idPedido;
        private int idProducto;
        private int cantidad;


        public int? IdLinPedido
        {
            get { return idLinPedido; }
            set { idLinPedido = value; }
        }


        public int? IdPedido
        {
            get { return idPedido; }
            set { idPedido = value; }
        }

        public int IdProducto
        {
            get { return idProducto; }
            set { idProducto = value; }
        }

        public int Cantidad
        {
            get { return cantidad; }
            set { cantidad = value; }
        }

        public ENLinPed(int? idLinPedido,int? idPedido,int idProducto,int cantidad)
        {
            IdLinPedido = idLinPedido;
            IdPedido = idPedido;
            IdProducto = idProducto;
            Cantidad = cantidad;
        }

        public bool Create()
        {
            CADLinPed con=new CADLinPed();
            return con.Create(this);
        }
        public bool Delete()
        {
            CADLinPed con = new CADLinPed();
            return con.Delete(this);
        }
        public bool Update()
        {
            CADLinPed con = new CADLinPed();
            return con.Update(this);
        }
        public bool Read()
        {
            CADLinPed con = new CADLinPed();
            return con.Read(this);
        }

        public bool is_correct()
        {
            return idPedido != null && idLinPedido!=null;
        }
    }
}
