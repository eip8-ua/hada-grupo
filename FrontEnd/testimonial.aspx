<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="testimonial.aspx.cs" Inherits="FrontEnd.testimonial" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/testimoniales.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>TESTIMONIOS</h1>

    <div id="testimonialContainer" class="testimonial_container">
        <div class="testimonial">
            <button id="btn1" runat="server" onserverclick="btn1_Click" class="nav_button">&lt;</button>
            <div class="testimonial_content">
                <asp:Label ID="lblNombreTestimonial" runat="server" Text="" CssClass="testimonial_username"></asp:Label>
                <div class="testimonial_message">
                    <span class="testimonial_quote">“</span>
                    <asp:Label ID="lblCita" runat="server" Text="" CssClass="testimonial_text"></asp:Label>
                    <span class="testimonial_quote">”</span>
                </div>
            </div>
            <button id="btn2" runat="server" onserverclick="btn2_Click" class="nav_button">&gt;</button>
        </div>
    </div>
</asp:Content>
