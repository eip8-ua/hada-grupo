using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    class CADLinCarr
    {
        public string connectionString;

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADLinCarr() 
        {
            this.connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        /// <summary>
        /// Método que inserta una Linea de Carrito en la BD
        /// </summary>
        /// <param name="en">EN con los datos de la Linea de Carrito</param>
        /// <returns></returns>
        public bool Create(ENLinCarr en)
        {
            string insertQuery = "INSERT INTO Linea_carrito (cantidad, carrito, producto) VALUES (@Quantity, @CartId, @ProductId)";
            int quantity = en.Cantidad;
            int cartId = en.Carrito;
            int productId = en.Producto;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Quantity", quantity);
                        command.Parameters.AddWithValue("@CartId", cartId);
                        command.Parameters.AddWithValue("@ProductId", productId);

                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Console.WriteLine("Line item added to shopping cart successfully!");
                        }
                        else
                        {
                            Console.WriteLine("Failed to add line item to shopping cart.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error creating line item: {ex.Message}");
            }
            return true;
        }

        /// <summary>
        /// Método que actualiza una Linea de Carrito en la BD
        /// </summary>
        /// <param name="en">EN con los datos de la Linea de Carrito</param>
        /// <returns></returns>
        public bool Update(ENLinCarr en)
        {
            string updateQuery = "UPDATE Linea_carrito SET cantidad = @NewQuantity WHERE id = @LinCartId";
            int cartId = en.Carrito;
            int productId = en.Producto;
            int newQuantity = en.Cantidad;
            int linCartId = en.Id;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        command.Parameters.AddWithValue("@LinCartId", linCartId);
                        command.Parameters.AddWithValue("@NewQuantity", newQuantity);

                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Console.WriteLine("Line item updated successfully!");
                            return true;
                        }
                        else
                        {
                            Console.WriteLine("Line item not found.");
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error updating line item: {ex.Message}");
            }
            return true;
        }

        /// <summary>
        /// Método que lee los datos de una Linea de Carrito de la BD
        /// </summary>
        /// <param name="en">EN con los datos de la Linea de Carrito</param>
        /// <returns></returns>
        public bool Read(ENLinCarr en)
        {

            string selectQuery = "SELECT * FROM Linea_carrito WHERE carrito = @CartId";
            int cartId = en.Carrito;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(selectQuery, connection))
                    {
                        command.Parameters.AddWithValue("@CartId", cartId);

                        connection.Open();

                        SqlDataReader reader = command.ExecuteReader();

                        if (!reader.HasRows)
                        {
                            Console.WriteLine("No line items found in the shopping cart.");
                            return false;
                        }

                        while (reader.Read())
                        {
                            Console.WriteLine($"ID: {reader["id"]}, Quantity: {reader["cantidad"]}, Product ID: {reader["producto"]}");
                            en.Id = (int)reader["id"];
                            en.Cantidad = (int)reader["cantidad"];
                            en.Producto = (int)reader["producto"];
                        }

                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading line items: {ex.Message}");
            }
            return true;
        }

        /// <summary>
        /// Método que elimina una Linea de Carrito de la BD
        /// </summary>
        /// <param name="en">EN con los datos de la Linea de Carrito</param>
        /// <returns></returns>
        public bool Delete(ENLinCarr en)
        {
            string deleteQuery = "DELETE FROM Linea_carrito WHERE carrito = @CartId and producto = @ProductId";
            int cartId = en.Carrito;
            int productId = en.Producto;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                    {
                        command.Parameters.AddWithValue("@CartId", cartId);
                        command.Parameters.AddWithValue("@ProductId",productId);

                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Console.WriteLine("Line item deleted successfully!");
                            return true;
                        }
                        else
                        {
                            Console.WriteLine("Line item not found.");
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleting line item: {ex.Message}");
            }
            return true;
        }

        public List<ENLinCarr> getItemsByCartId(int cartId)
        {
            string selectQuery = "SELECT * FROM Linea_carrito WHERE carrito = @CartId";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(selectQuery, connection))
                    {
                        command.Parameters.AddWithValue("@CartId", cartId);

                        connection.Open();

                        SqlDataReader reader = command.ExecuteReader();

                        
                        List<ENLinCarr> listLinCarr = new List<ENLinCarr>();
                        
                        if (!reader.HasRows)
                        {
                            Console.WriteLine("No line items found in the shopping cart.");
                            return null;
                        }
                        
                        while (reader.Read())
                        {
                            ENLinCarr enLinCarr = new ENLinCarr((int)reader["id"], (int)reader["cantidad"] , (int)reader["carrito"], (int)reader["producto"]);
                            listLinCarr.Add(enLinCarr);
                        }

                        return listLinCarr;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading line items: {ex.Message}");
            }
            return null;
        }
    }
}
