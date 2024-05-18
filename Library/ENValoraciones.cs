using System;

namespace Library
{
    public class ENValoraciones
    {
        public int UsuarioId { get; set; }
        public int ProductoId { get; set; }
        public int Puntuacion { get; set; }
        public string Descripcion { get; set; }

        // Relaciones
        public ENValoracionUsuario Usuario { get; set; }
        public ENValoracionProducto Producto { get; set; }

        public ENValoraciones()
        {
        }
    }

    public class ENValoracionUsuario
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        // Otras propiedades relevantes

        public ENValoracionUsuario()
        {
        }
    }

    public class ENValoracionProducto
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        // Otras propiedades relevantes

        public ENValoracionProducto()
        {
        }
    }
}
