using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace Library
{
    class CADCarritoDe
    {
        public string connectionString;

        /// <summary>
        /// Constructor vacío
        /// </summary>
        public CADCarritoDe()
        {
            this.connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        /// <summary>
        /// Método que inserta una Linea de Carrito en la BD
        /// </summary>
        /// <param name="en">EN con los datos de la Linea de Carrito</param>
        /// <returns></returns>
        public bool Create(ENCarritoDe en)
        {
            this.connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string insertQuery = "INSERT INTO Carrito_de (usuario, carrito) VALUES (@UserId, @CartId)";
            int userId = en.Usuario;
            int cartId = en.Carrito;


            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserId", userId);
                        command.Parameters.AddWithValue("@CartId", cartId);
                        
                        connection.Open();

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Console.WriteLine("Line item added to shopping cart successfully!");
                            return true;
                        }
                        else
                        {
                            return false;
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
        public bool Update(ENCarritoDe en)
        {
            string updateQuery = "UPDATE Carrito_de SET carrito = @CartId WHERE id = @UserId";
            int userId = en.Usuario;
            int cartId = en.Carrito;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserId", userId);
                        command.Parameters.AddWithValue("@CartId", cartId);

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
        public bool Read(ENCarritoDe en)
        {
            string selectQuery = "SELECT * FROM Carrito_de WHERE id = @UserId";
            int userId = en.Usuario;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(selectQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserId", userId);

                        connection.Open();

                        SqlDataReader reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            en.Carrito = (int)reader["carrito"];
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
        public bool Delete(ENCarritoDe en)
        {
            string deleteQuery = "DELETE FROM Carrito_de WHERE usuario = @UserId";
            int userId = en.Usuario;
            int cartId = en.Carrito;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserId", userId);

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
        
        public bool UserExists(ENUsuario User)
        {
            string selectQuery = "SELECT * FROM Carrito_de WHERE id = @UserId";
            int userId = User.Id;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(selectQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserId", userId);

                        connection.Open();

                        SqlDataReader reader = command.ExecuteReader();

                        if (!reader.HasRows)
                        {
                            return false;
                        }

                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading line items: {ex.Message}");
            }
            return false;
        }

        public int GetCartIdByUser(ENUsuario User)
        {
            string selectQuery = "SELECT carrito FROM Carrito_de WHERE id = @UserId";
            int userId = User.Id;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(selectQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserId", userId);

                        connection.Open();

                        SqlDataReader reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            return (int)reader["carrito"];
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error reading line items: {ex.Message}");
            }
            return 0;
        }
    }
}
