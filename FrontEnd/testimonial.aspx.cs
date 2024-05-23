using System;
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
                        lblNombreTestimonial.Text = testimonioActual.Id.ToString();
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
                    lblNombreTestimonial.Text = testimonioActual.Id.ToString();
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
                    lblNombreTestimonial.Text = testimonioActual.Id.ToString();
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
    }
}
