using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    //Clase que representa las diferentes promociones y ofertas que puede haber en la base de datos
    public class ENPromociones
    {
        //Id la promoción
        int? miId;
        //El porcentaje de descuento del producto de 0-100
        float descuento;
        //Condicional: verdadero, el descuento se aplica; falso, no se aplica
        bool disponibilidad;

        //Propiedades de la clase
        public int? MiId { get { return miId; } set { miId = value; } }

        public float Descuento { get { return descuento; } set { descuento = value; } }

        public bool Disponibilidad { get { return disponibilidad; } set { disponibilidad = value; } }

        public ENPromociones() {
            descuento = 0;
            disponibilidad = false;
        }

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

        public static bool getPromociones(List<ENPromociones> promos) {

            CADPromociones cad = new CADPromociones();
            return cad.getPromociones(promos);
        }

         public ENPromociones read() {
            if (miId != null)
            {
                int id = (int)miId;
                CADPromociones cad = new CADPromociones();
                return cad.getPromocion(id);
            } else
            {
                return new ENPromociones();
            }
        }
    }
}
