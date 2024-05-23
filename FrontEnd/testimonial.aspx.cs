using System;
using System.Configuration;
using System.Data.SqlClient;
using Library;

namespace FrontEnd
{
    public partial class testimonial : System.Web.UI.Page
    {
        private ENTestimonial testimonioActual;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    testimonioActual = new ENTestimonial();
                    bool success = testimonioActual.ReadFirst();
                    if (success)
                    {
                        LoadUserName(testimonioActual.Id);
                        lblCita.Text = testimonioActual.Message;
                        System.Diagnostics.Debug.WriteLine("First testimonial loaded successfully.");
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("Failed to load the first testimonial.");
                    }

                    ViewState["TestimonioActual"] = testimonioActual;
                }
                else
                {
                    testimonioActual = (ENTestimonial)ViewState["TestimonioActual"];
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in Page_Load: " + ex.Message);
            }
        }

        protected void btn1_Click(object sender, EventArgs e)
        {
            try
            {
                bool success = testimonioActual.ReadPrev();
                if (success)
                {
                    LoadUserName(testimonioActual.Id);
                    lblCita.Text = testimonioActual.Message;
                    System.Diagnostics.Debug.WriteLine("Previous testimonial loaded successfully.");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Failed to load the previous testimonial.");
                }

                ViewState["TestimonioActual"] = testimonioActual;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in btn1_Click: " + ex.Message);
            }
        }

        protected void btn2_Click(object sender, EventArgs e)
        {
            try
            {
                bool success = testimonioActual.ReadNext();
                if (success)
                {
                    LoadUserName(testimonioActual.Id);
                    lblCita.Text = testimonioActual.Message;
                    System.Diagnostics.Debug.WriteLine("Next testimonial loaded successfully.");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Failed to load the next testimonial.");
                }

                ViewState["TestimonioActual"] = testimonioActual;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in btn2_Click: " + ex.Message);
            }
        }

        private void LoadUserName(int testimonialId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT testimonial.*, usuario.nombre " +
                                   "FROM testimonial " +
                                   "INNER JOIN califica ON testimonial.id = califica.testimonial " +
                                   "INNER JOIN usuario ON califica.usuario = usuario.id " +
                                   "WHERE testimonial.id = @id";

                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@id", testimonialId);

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        string userName = reader["nombre"].ToString();
                        lblNombreTestimonial.Text = userName;
                    }
                    else
                    {
                        lblNombreTestimonial.Text = "Usuario desconocido";
                    }

                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                // Manejar la excepción apropiadamente
                lblNombreTestimonial.Text = "Error al cargar el nombre del usuario";
                Console.WriteLine("An error occurred while loading user name: " + ex.Message);
            }
        }


    }
}
