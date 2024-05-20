<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="proyecto.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/index.css"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="welcome_screen">
        <div id="left_welcome">
            <p>¡Bienvenido!</p>
            <h1>Descubre nuestros productos</h1>
            <div id="button_welcome_screen">
                <asp:Button ID="contact_Button" runat="server" Text="Contáctanos" CssClass="ButtonStyle1" OnClick="contact_Button_Click"></asp:Button>
            </div>
        </div>
        <div id="right_welcome">
            <img id="us_showcase" src="Images/nosotros.jpg">
        </div>
    </div>

    <div id="popular_products_showcase">
        <h2>Nuestros productos más populares</h2>
        <div id="popular_products">
            <div id="popular_column1" runat="server" class="popular_column"></div>
            <div id="popular_column2" runat="server" class="popular_column"></div>
        </div>
        <asp:Button ID="see_more_pop_products" runat="server" Text="Ver más" OnClick="see_more_pop_products_Click" CssClass="ButtonStyle2 see_more_button"></asp:Button>
    </div>

    <div id="promotions_showcase">
        <div id="left_promotions">
            <h2>Promociones</h2>
            <p>¡Descubre nuestras mejores promociones!</p><br>
            <asp:Button ID="explore_more_promotions_Button" runat="server" Text="Explorar más" CssClass="ButtonStyle1" OnClick="explore_more_promotions_Button_Click"></asp:Button>
        </div>
        <div id="right_promotions"></div>
    </div>

    <div id="testimonies_showcase">
        <div id="left_testimonies">
            <p>Lee las opiniones de nuestros usuarios a través de sus</p>
            <div id="testimonies_Button_wrap">
                <asp:Button ID="testimonies_Button" runat="server" Text="Testimonios" CssClass="ButtonStyle2" OnClick="testimonies_Button_Click"></asp:Button>
            </div>
        </div>
        <div id="right_testimonies">
            <img id="testimony_showcase" src="Images/testimonio.jpg">
        </div>
    </div>
    
</asp:Content>