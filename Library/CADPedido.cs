using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Library
{
    class CADPedido
    {
        private string constring;
        private SqlConnection connection;

        public CADPedido(){

        }

        public bool Create(ENPedido en)
        {
            return true;
        }
        public bool Update(ENPedido en)
        {
            return true;
        }
        public bool Read(ENPedido en)
        {
            return true;
        }
        public bool Delete(ENPedido en)
        {
            return true;
        }
    }
}
