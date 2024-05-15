using System;
using Library;

namespace proyecto
{
    public partial class testimonial : System.Web.UI.Page
    {
        // Variable para mantener el estado del testimonio actual
        private ENTestimonial testimonioActual;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Aquí lees los testimonios de la base de datos
                // Supongamos que tienes un objeto de la clase CADTestimonial llamado cadTestimonial
                CADTestimonial cadTestimonial = new CADTestimonial();
                testimonioActual = new ENTestimonial();

                // Leer el primer testimonio y mostrarlo
                bool success = cadTestimonial.ReadFirst(testimonioActual);
                if (success)
                {
                    lblNombreTestimonial.Text = testimonioActual.Id.ToString(); // Suponiendo que lblNombreTestimonial es para el ID del testimonio
                    lblCita.Text = testimonioActual.Message;
                }

                // Guardar el estado del testimonio actual en la vista de estado de ASP.NET
                ViewState["TestimonioActual"] = testimonioActual;
            }
            else
            {
                // Restaurar el estado del testimonio actual desde la vista de estado de ASP.NET
                testimonioActual = (ENTestimonial)ViewState["TestimonioActual"];
            }
        }


        protected void btn1_Click(object sender, EventArgs e)
        {
            // Leer el testimonio anterior y mostrarlo
            CADTestimonial cadTestimonial = new CADTestimonial();
            bool success = cadTestimonial.ReadPrev(testimonioActual);
            if (success)
            {
                lblNombreTestimonial.Text = testimonioActual.Id.ToString(); // Suponiendo que lblNombreTestimonial es para el ID del testimonio
                lblCita.Text = testimonioActual.Message;
            }

            // Guardar el estado actualizado del testimonio actual en la vista de estado de ASP.NET
            ViewState["TestimonioActual"] = testimonioActual;
        }

        protected void btn2_Click(object sender, EventArgs e)
        {
            // Leer el siguiente testimonio y mostrarlo
            CADTestimonial cadTestimonial = new CADTestimonial();
            bool success = cadTestimonial.ReadNext(testimonioActual);
            if (success)
            {
                lblNombreTestimonial.Text = testimonioActual.Id.ToString(); // Suponiendo que lblNombreTestimonial es para el ID del testimonio
                lblCita.Text = testimonioActual.Message;
            }

            // Guardar el estado actualizado del testimonio actual en la vista de estado de ASP.NET
            ViewState["TestimonioActual"] = testimonioActual;
        }

    }
}
