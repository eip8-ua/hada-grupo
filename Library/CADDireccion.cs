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
        private string constring = ConfigurationManager
        private SqlConnection connection;

        public CAADireccion()
        {
            connection = new SqlConnection(constring);
        }
        public bool Create(ENDireccion dir)
        {

        }
        public bool Delete(ENDireccion dir)
        {

        }
        public bool Update(ENDireccion dir)
        {

        }
        public bool Read(ENDireccion dir)
        {

        }
    }
}
