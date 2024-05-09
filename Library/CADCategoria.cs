using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Library
{
    class CADCategoria
    {
        public string constring;
        public SqlConnection connection;

        public CADCategoria()
        {

        }
        public bool Create(ENCategoria cat)
        {
            return false;
        }
        public bool Delete(ENCategoria cat)
        {
            return false;
        }
        public bool Update(ENCategoria cat)
        {
            return false;
        }
        public bool Read(ENCategoria cat)
        {
            return false;
        }
    }
}
