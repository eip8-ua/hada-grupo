using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    class ENPromociones
    {
        int miId;
        float descuento;

        public int MiId { get { return miId; } set { miId = value; } }

        public float Descuento { get { return descuento; } set { descuento = value; } }

        public ENPromociones() { }

        public ENPromociones(int Yd, float desc) {

            miId = Yd;
            descuento = desc;
        }

        public List<ENPromociones> getPromociones() {

            return null;
        }

         public DateTime getDisponibilidad() {

            return new DateTime();
         }

        public int getNumberOfDaysRemaining() {

            return 0;
        }
  
    }
}
