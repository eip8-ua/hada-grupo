using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    class CADCarrito
    {
        private string connectionString { get; set; }

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADCarrito() {
            connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
        }

        /// <summary>
        /// Método que inserta un Carrito en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Carrito</param>
        /// <returns></returns>
        public bool Create(ENCarrito en)
        {
            // SQL query to insert a new shopping cart
            string insertQuery = "INSERT INTO Carrito (fecha) VALUES (@fecha)";

            // Current date and time
            DateTime currentDate = DateTime.Now;
            int cartNumber = en.Num_carrito;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        // Set parameters for the SQL query
                        command.Parameters.AddWithValue("@fecha", currentDate);

                        // Open the connection
                        connection.Open();

                        // Execute the SQL command
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Console.WriteLine($"Shopping cart {cartNumber} created successfully!");
                            return true;
                        }
                        else
                        {
                            Console.WriteLine($"Failed to create shopping cart {cartNumber}.");
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error creating shopping cart: {ex.Message}");
            }
            return true;
        }

        /// <summary>
        /// Método que actualiza un Carrito en la BD
        /// </summary>
        /// <param name="en">EN con los datos del Carrito</param>
        /// <returns></returns>
        public bool Update(ENCarrito en)
        {
            string updateQuery = "UPDATE Carrito SET fecha = @NewDate WHERE numero_carrito = @CartNumber";
            int cartNumber = en.Num_carrito;
            DateTime newDate = en.Fecha;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        command.Parameters.AddWithValue("@CartNumber", cartNumber);
                        command.Parameters.AddWithValue("@NewDate", newDate);

                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Console.WriteLine($"Shopping cart {cartNumber} updated successfully!");
                        }
                        else
                        {
                            Console.WriteLine($"Shopping cart {cartNumber} not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error updating shopping cart: {ex.Message}");
            }
            return true;
        }

        /// <summary>
        /// Método que lee los datos de un Carrito de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Carrito</param>
        /// <returns></returns>
        public bool Read(ENCarrito en)
        {
            string selectQuery = "SELECT * FROM Carrito WHERE num_carrito = @CartNumber";
            int cartNumber = en.Num_carrito;


            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(selectQuery, connection))
                    {
                        command.Parameters.AddWithValue("@CartNumber", cartNumber);

                        connection.Open();

                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            Console.WriteLine($"Shopping cart details - Number: {reader["num_cart"]}, Date: {reader["date"]}");
                        }
                        else
                        {
                            Console.WriteLine($"Shopping cart {cartNumber} not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading shopping cart: {ex.Message}");
            }
            return true;
        }

        /// <summary>
        /// Método que elimina un Carrito de la BD
        /// </summary>
        /// <param name="en">EN con los datos del Carrito</param>
        /// <returns></returns>
        public bool Delete(ENCarrito en)
        {
            string deleteQuery = "DELETE FROM Carrito WHERE num_carrito = @CartNumber";
            int cartNumber = en.Num_carrito;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                    {
                        command.Parameters.AddWithValue("@CartNumber", cartNumber);

                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Console.WriteLine($"Shopping cart {cartNumber} deleted successfully!");
                        }
                        else
                        {
                            Console.WriteLine($"Shopping cart {cartNumber} not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleting shopping cart: {ex.Message}");
            }
            return true;
        }

        public int getNextCartId()
        {
            string selectQuery = "SELECT MAX(num_carrito) AS max_id FROM Carrito";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(selectQuery, connection))
                    {

                        connection.Open();

                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            if((int)reader["max_id"] > 0)
                                return (int)reader["max_id"] + 1;

                            return 1;
                        }
                        else
                        {
                            Console.WriteLine($"Shopping cart not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading shopping cart: {ex.Message}");
            }
            return 1;
        }
    }
}
