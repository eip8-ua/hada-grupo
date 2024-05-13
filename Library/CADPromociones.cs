using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class CADPromociones
    {
        string miConexion;
        public string MiConexion { get { return miConexion; } set { miConexion = value; } }

        public CADPromociones() {

           //miConexion = ConfigurationManager.ConnectionStrings["miconexion"].ToString();
        }

        public void getPromociones(List<ENPromociones> promos)
        {

        }

        public ENPromociones getPromocion(int idd)
        {
            ENPromociones promo = new ENPromociones();

            return promo;
        }
    }
}
