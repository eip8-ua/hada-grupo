using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    public class ENPromociones
    {
        int miId;
        float descuento;
        bool disponibilidad;

        public int MiId { get { return miId; } set { miId = value; } }

        public float Descuento { get { return descuento; } set { descuento = value; } }

        public bool Disponibilidad { get { return disponibilidad; } set { disponibilidad = value; } }

        public ENPromociones() { }

        public ENPromociones(int Yd, float desc, bool disp) {

            miId = Yd;
            descuento = desc;
            disponibilidad = disp;
        }
        public ENPromociones(ENPromociones prom)
        {
            miId = prom.MiId;
            descuento = prom.Descuento;
            disponibilidad = prom.Disponibilidad;
        }

        public List<ENPromociones> getPromociones() {

            List<ENPromociones> lista = new List<ENPromociones>();
            CADPromociones cad = new CADPromociones();
            cad.getPromociones(lista);
            return lista;
        }

         public ENPromociones getPromocion(int idd) {

            CADPromociones cad = new CADPromociones();
            return cad.getPromocion(idd);
        }
    }
}
