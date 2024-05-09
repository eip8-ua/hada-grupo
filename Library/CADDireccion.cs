using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;
namespace Library
{
    class CADDireccion
    {
        private string constring;
        private SqlConnection connection;

        public CADDireccion()
        {
            constring = "";
            connection = new SqlConnection(constring);
        }
        public bool Create(ENDireccion dir)
        {
            return false;
        }
        public bool Delete(ENDireccion dir)
        {
            return false;
        }
        public bool Update(ENDireccion dir)
        {
            return false;
        }
        public bool Read(ENDireccion dir)
        {
            return false;
        }
    }
}
