using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;

namespace Library
{
    class CADPedido
    {
        private string constring;

        public CADPedido()
        {
            constring = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        public bool Create(ENPedido en)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    if (en.is_correct())
                    {
                        string query = "INSERT INTO Pedido (num_pedido, fecha, usuario) VALUES (@NumPedido, @FechaPedido, @IdUsuario)";
                        SqlCommand cmd = new SqlCommand(query, connection);
                        cmd.Parameters.AddWithValue("@NumPedido", en.Numpedido);
                        cmd.Parameters.AddWithValue("@FechaPedido", en.FechaPedido);
                        cmd.Parameters.AddWithValue("@IdUsuario", en.IdUsuario);

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
                Console.WriteLine("Error al crear el pedido: " + e.Message);
                return false;
            }
        }
        public bool Update(ENPedido en)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    if (en.is_correct())
                    {
                        string query = "UPDATE Pedido SET fecha = @FechaPedido, usuario = @IdUsuario WHERE num_pedido = @NumPedido";
                        SqlCommand cmd = new SqlCommand(query, connection);
                        cmd.Parameters.AddWithValue("@NumPedido", en.Numpedido);
                        cmd.Parameters.AddWithValue("@FechaPedido", en.FechaPedido);
                        cmd.Parameters.AddWithValue("@IdUsuario", en.IdUsuario);

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
                Console.WriteLine("Error al actualizar el pedido: " + e.Message);
                return false;
            }
        }
        public bool Read(ENPedido en)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    string query = "SELECT num_pedido, fecha, usuario FROM Pedido WHERE num_pedido = @NumPedido";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@NumPedido", en.Numpedido);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        en.FechaPedido = reader.GetDateTime(1); // El índice 1 corresponde a la columna "fecha"
                        en.IdUsuario = reader.GetInt32(2); // El índice 2 corresponde a la columna "usuario"
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
                Console.WriteLine("Error al leer el pedido: " + e.Message);
                return false;
            }
        }

        public bool Delete(ENPedido en)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    string query = "DELETE FROM Pedido WHERE num_pedido = @NumPedido";
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@NumPedido", en.Numpedido);

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
        public List<ENPedido> ReadAll()
        {
            List<ENPedido> pedidos = new List<ENPedido>();

            try
            {
                using (SqlConnection connection = new SqlConnection(constring))
                {
                    connection.Open();

                    string query = "SELECT num_pedido, fecha, usuario FROM Pedido";
                    SqlCommand cmd = new SqlCommand(query, connection);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ENPedido pedido = new ENPedido
                        {
                            Numpedido = reader.GetInt32(0),
                            FechaPedido = reader.GetDateTime(1),
                            IdUsuario = reader.GetInt32(2)
                        };

                        pedidos.Add(pedido);
                    }
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine("Error al leer todos los pedidos: " + e.Message);
            }

            return pedidos;
        }

    }
}
