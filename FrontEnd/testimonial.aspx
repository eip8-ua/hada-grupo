<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="testimonial.aspx.cs" Inherits="proyecto.testimonial" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Testimonial</h3>

    <div id="testimonialContainer" class="testimonial_container">
        <asp:Label ID="lblNombreTestimonial" runat="server" Text=""></asp:Label>
        <div class="testimonial">
            <asp:Button ID="btn1" runat="server" Text="<" OnClick="btn1_Click" />
            <span class="testimonial_quote">“</span>
            <asp:Label ID="lblCita" runat="server" Text=""></asp:Label>            
            <span class="testimonial_quote">”</span>
            <asp:Button ID="btn2" runat="server" Text=">" OnClick="btn2_Click" />
        </div>
    </div>
</asp:Content>
