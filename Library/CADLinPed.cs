using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Library
{
    class CADLinPed
    {
        private string constring;
        private SqlConnection connection;

        public CADLinPed()
        {

        }
        public bool Create(ENLinPed en)
        {
            return true;
        }
        public bool Update(ENLinPed en)
        {
            return true;
        }
        public bool Read(ENLinPed en)
        {
            return true;
        }
        public bool Delete(ENLinPed en)
        {
            return true;
        }
    }
}
