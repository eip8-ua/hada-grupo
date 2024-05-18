using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace Library
{
    public class CADValoraciones
    {
        private string constring;

        public CADValoraciones()
        {
            constring = "Data Source=localhost;Initial Catalog=mydb;Integrated Security=True";
        }

        public DataTable getValoraciones()
        {
            SqlConnection conn = new SqlConnection(constring);
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Valora", conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        public double GetMediaEvaluaciones(int productoId)
        {
            SqlConnection conn = new SqlConnection(constring);
            SqlCommand cmd = new SqlCommand("SELECT AVG(Puntuacion) FROM Valora WHERE ProductoId = @ProductoId", conn);
            cmd.Parameters.AddWithValue("@ProductoId", productoId);
            conn.Open();
            var result = cmd.ExecuteScalar();
            conn.Close();
            return result != DBNull.Value ? Convert.ToDouble(result) : 0;
        }

        public void ValorarProducto(int usuarioId, int productoId, int puntuacion, string descripcion)
        {
            SqlConnection conn = new SqlConnection(constring);
            SqlCommand cmd = new SqlCommand("IF EXISTS (SELECT 1 FROM Valora WHERE UsuarioId = @UsuarioId AND ProductoId = @ProductoId) " +
                                             "UPDATE Valora SET Puntuacion = @Puntuacion, Descripcion = @Descripcion WHERE UsuarioId = @UsuarioId AND ProductoId = @ProductoId " +
                                             "ELSE " +
                                             "INSERT INTO Valora (UsuarioId, ProductoId, Puntuacion, Descripcion) VALUES (@UsuarioId, @ProductoId, @Puntuacion, @Descripcion)", conn);
            cmd.Parameters.AddWithValue("@UsuarioId", usuarioId);
            cmd.Parameters.AddWithValue("@ProductoId", productoId);
            cmd.Parameters.AddWithValue("@Puntuacion", puntuacion);
            cmd.Parameters.AddWithValue("@Descripcion", descripcion);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public DataTable ObtenerValoracionesAnteriores(int productoId)
        {
            SqlConnection conn = new SqlConnection(constring);
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Valora WHERE ProductoId = @ProductoId", conn);
            da.SelectCommand.Parameters.AddWithValue("@ProductoId", productoId);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }
}
