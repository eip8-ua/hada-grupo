using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
namespace Library
{
    public class CADValoraciones
    {
        private string constring;
        private SqlConnection conn;
        public CADValoraciones()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        public DataTable getValoraciones()
        {
            conn = new SqlConnection(constring);
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Valora", conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        public double GetMediaEvaluaciones(int productoId)
        {
            conn = new SqlConnection(constring);
            SqlCommand cmd = new SqlCommand("SELECT AVG(Puntuacion) FROM Valora WHERE ProductoId = @ProductoId", conn);
            cmd.Parameters.AddWithValue("@ProductoId", productoId);
            conn.Open();
            var result = cmd.ExecuteScalar();
            conn.Close();
            return result != DBNull.Value ? Convert.ToDouble(result) : 0;
        }

        public bool Create(ENValoraciones val)
        {
            try
            {
                conn = new SqlConnection(constring);
                SqlCommand cmd = new SqlCommand("IF EXISTS (SELECT 1 FROM Valora WHERE usuario = @UsuarioId AND producto = @ProductoId) " +
                                                 "UPDATE Valora SET Puntuacion = @Puntuacion, descripcion = @Descripcion WHERE usuario = @UsuarioId AND prodcuto = @ProductoId " +
                                                 "ELSE " +
                                                 "INSERT INTO Valora (usuario, producto, puntuacion, descripcion) VALUES (@UsuarioId, @ProductoId, @Puntuacion, @Descripcion)", conn);
                cmd.Parameters.AddWithValue("@UsuarioId", val.Usuario.Id);
                cmd.Parameters.AddWithValue("@ProductoId", val.Producto.id);
                cmd.Parameters.AddWithValue("@Puntuacion", val.Puntuacion);
                cmd.Parameters.AddWithValue("@Descripcion", val.Descripcion);
                conn.Open();
                
                //Filas a las que afecta
                return cmd.ExecuteNonQuery() > 0;
            }
            catch (SqlException e)
            {
                Console.WriteLine(e);
            }
            finally
            {
                conn.Close();
            }

            return false;
        }

        public DataTable ObtenerValoracionesAnteriores(ENValoraciones val)
        {
            using (conn = new SqlConnection(constring))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT usuario,puntuacion,descripcion FROM Valora WHERE producto = @ProductoId", conn);
                da.SelectCommand.Parameters.AddWithValue("@ProductoId", val.Producto.id);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
    }
}
