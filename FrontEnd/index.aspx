<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="proyecto.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="index_showcase1" class="index_showcasetext">
        <div class="index_showcasetext_left">
            ¡En caso de dudas o información adicional, no dudes en contactarnos!
            <br><br>
            <asp:Button BackColor="aqua" Font-Names="Poppins" ID="Button1" runat="server" Text="Contáctanos" Font-Size="Large" OnClick="Button1_Click"/>
        </div>
        <div class="index_showcasetext_right"><img src="Images/nosotros.jpg"/></div>
    </div>
    <div></div>
    <div></div>
    <div id="index_showcase2" class="index_showcasetext">
        <div class="index_showcasetext_left">
            No hace falta que te fíes solo de nuestra palabra. Comprueba la opinión de otros usuarios
            <br><br>
            <asp:Button ID="Button2" runat="server" Text="Testimonial" OnClick="Button2_Click" Font-Names="Poppins" BackColor="Aqua" Font-Size="Large"/>
        </div>
        <div class="index_showcasetext_right"><img src="Images/nosotros.jpg"/></div>
    </div>
</asp:Content>
