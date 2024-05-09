using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
namespace Library
{
    class CADLocker
    {
        public string constring;
        public SqlConnection connection;

        public CADLocker()
        {

        }
        public bool Create(ENLocker loc)
        {
            return false;
        }
        public bool Delete(ENLocker loc)
        {
            return false;
        }
        public bool Update(ENLocker loc)
        {
            return false;
        }
        public bool Read(ENLocker loc)
        {
            return false;
        }
    }
}
