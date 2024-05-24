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
            int lineCartId = en.Id;
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
            string updateQuery = "UPDATE Linea_carrito SET cantidad = @NewQuantity WHERE id = @LineCartId";
            int lineCartId = en.Id;
            int newQuantity = en.Cantidad;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        command.Parameters.AddWithValue("@NewQuantity", newQuantity);
                        command.Parameters.AddWithValue("@LineItemId", lineCartId);

                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Console.WriteLine("Line item updated successfully!");
                        }
                        else
                        {
                            Console.WriteLine("Line item not found.");
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

            string selectQuery = "SELECT * FROM Linea_carrito WHERE id = @LineCartId";
            int lineCartId = en.Id;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(selectQuery, connection))
                    {
                        command.Parameters.AddWithValue("@CartId", lineCartId);

                        connection.Open();

                        SqlDataReader reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            Console.WriteLine($"ID: {reader["id"]}, Quantity: {reader["quantity"]}, Product ID: {reader["product"]}");
                        }

                        if (!reader.HasRows)
                        {
                            Console.WriteLine("No line items found in the shopping cart.");
                        }
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
            string deleteQuery = "DELETE FROM Linea_carrito WHERE id = @LineCartId";
            int lineCartId = en.Id;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                    {
                        command.Parameters.AddWithValue("@LineItemId", lineCartId);

                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Console.WriteLine("Line item deleted successfully!");
                        }
                        else
                        {
                            Console.WriteLine("Line item not found.");
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

        public List<ENProducto> getItemsByCartId(int cartId)
        {
            string selectQuery = "SELECT * FROM Linea_carrito carrito id = @CartId";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(selectQuery, connection))
                    {
                        command.Parameters.AddWithValue("@CartId", cartId);

                        connection.Open();

                        SqlDataReader reader = command.ExecuteReader();

                        List<ENProducto> products = new List<ENProducto>();
                        while (reader.Read())
                        {
                            ENProducto enProd = new ENProducto((int)reader["producto"], 1, 1, 1);
                            enProd.Read();
                            products.Add(enProd);
                        }

                        return products;
                        

                        if (!reader.HasRows)
                        {
                            Console.WriteLine("No line items found in the shopping cart.");
                        }
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
