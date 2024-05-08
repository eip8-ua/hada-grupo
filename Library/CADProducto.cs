using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
namespace Library
{
    class CADProducto
    {
        public string constring;
        public SqlConnection connection;

        public CADProducto()
        {

        }
        public bool Create(ENProducto prod)
        {
            return false;
        }
        public bool Delete(ENProducto prod)
        {
            return false;
        }
        public bool Update(ENProducto prod)
        {
            return false;
        }
        public bool Read(ENProducto prod)
        {
            return false;
        }
    }
}
