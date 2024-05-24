using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;

namespace Library
{
    class CADLinPed
    {
        private string constring;

        public CADLinPed()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }
        public bool Create(ENLinPed en)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    if (en.is_correct())
                    {
                        string query = "INSERT INTO Linea_pedido (cantidad, pedido, producto) VALUES (@cantidad,@pedido, @producto)";
                        SqlCommand cmd = new SqlCommand(query, connection);
                        cmd.Parameters.AddWithValue("@cantidad", en.Cantidad);
                        cmd.Parameters.AddWithValue("@pedido", en.IdPedido);
                        cmd.Parameters.AddWithValue("@producto", en.IdProducto);


                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine("Error al crear la linea de pedido: " + e.Message);
                return false;
            }
        }
        public bool Update(ENLinPed en)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    if (en.is_correct())
                    {
                        string query = "UPDATE Pedido SET id = @id, cantidad = @cantidad,pedido=@pedido,producto=@producto WHERE id = @id";
                        SqlCommand cmd = new SqlCommand(query, connection);
                        cmd.Parameters.AddWithValue("@id", en.IdLinPedido);
                        cmd.Parameters.AddWithValue("@cantidad", en.Cantidad);
                        cmd.Parameters.AddWithValue("@pedido", en.IdPedido);
                        cmd.Parameters.AddWithValue("@producto", en.IdProducto);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine("Error al actualizar la linea de pedido: " + e.Message);
                return false;
            }
        }
        public bool Read(ENLinPed en)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    string query = "SELECT id, cantidad, pedido,producto FROM Linea_pedido WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@id", en.IdLinPedido);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        en.Cantidad = reader.GetInt32(1); // El índice 1 corresponde a la columna "Cantidad"
                        en.IdPedido = reader.GetInt32(2); // El índice 2 corresponde a la columna "IdPedido"
                        en.IdProducto = reader.GetInt32(3);//El índice 3 corresponde a la columna "IdProducto"
                        return true;
                    }
                    else
                    {
                        return false; // El pedido no fue encontrado
                    }
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine("Error al leer la linea de pedido: " + e.Message);
                return false;
            }
        }
        public bool Delete(ENLinPed en)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    string query = "DELETE FROM Linea_pedido WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@id", en.IdLinPedido);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine("Error al eliminar el pedido: " + e.Message);
                return false;
            }
        }
    }
}
