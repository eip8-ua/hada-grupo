<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="proyecto.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="index_showcase1" class="index_showcasetext">
        <div class="index_showcasetext_left">
            ¡En caso de preguntas o información adicional, no dudes en contactarnos!
            <br><br>
            <asp:Button ID="Button1" runat="server" Text="Contáctanos" OnClick="Button1_Click"/>
        </div>
        <div class="index_showcasetext_right"><img src="Images/nosotros.jpg"/></div>
    </div>
    <div class="index_seeMore">
        <div ID="popProduct1" runat="server" class="popProducts">
            <div class="imgSeeMore">
                <img src="Images/cascos 1.jpg"/>
                <p>Auriculares XYZ: 40€</p>
                <asp:Button Font-Size="15px" ID="AddCart1" runat="server" Text="Añadir al carrito"/>
            </div>
            <div class="imgSeeMore">
                <img src="Images/teclado1.jpg"/>
                <p>Teclado XYZ: 44€</p>
                <asp:Button Font-Size="15px" ID="AddCart2" runat="server" Text="Añadir al carrito"/>
            </div>
        </div>
        <div ID="popProduct2" runat="server" visible="false" class="popProducts">
            <div class="imgSeeMore" >
                <img src="Images/teclado 2.jpg">
                <p>Teclado ABC: 30€</p>
                <asp:Button Font-Size="15px" ID="AddCart3" runat="server" Text="Añadir al carrito"/>
            </div>
            <div class="imgSeeMore">
                <img src="Images/monitor 1.jpg"/>
                <p>Monitor XYZ: 80€</p>
                <asp:Button Font-Size="15px" ID="AddCart4" runat="server" Text="Añadir al carrito"/>
            </div>
        </div>
        <div ID="popProduct3" runat="server" visible="false" class="popProducts">
            <div class="imgSeeMore">
                <img src="Images/torre 1.jpg"/>
                <p>Torre XYZ: 400€</p>
                <asp:Button Font-Size="15px" ID="AddCart5" runat="server" Text="Añadir al carrito"/>
            </div>
            <div class="imgSeeMore">
                <img src="Images/raton 1.jpg"/>
                <p>Ratón XYZ: 20€</p>
                <asp:Button Font-Size="15px" ID="AddCart6" runat="server" Text="Añadir al carrito"/>
            </div>
        </div>
        <asp:Button CssClass="ButtonSeeMore" ID="ButtonSeeMore" runat="server" Text="Ver Más" OnClick="ButtonSeeMore_Click"></asp:Button>
    </div>
    <div class="index_promoExpo">
        <div class="index_promoExpo_left">
            <p>¡Recuerda mirar las ofertas para ver qué comprar!</p>
        </div>
        <div class="index_promoExpo_right">
            <p class="oferta">2x1 en teclados</p>
            <p class="oferta">20% de descuento los últimos 5 días del mes</p>
        </div>
    </div>   
    <div id="index_showcase2" class="index_showcasetext">
        <div class="index_showcasetext_left">
            No hace falta que te fíes solo de nuestra palabra. Comprueba la opinión de otros usuarios
            <br><br>
            <asp:Button ID="Button2" runat="server" Text="Testimonial" OnClick="Button2_Click"/>
        </div>
        <div class="index_showcasetext_right"><img src="Images/testimonio 1.jpg"/></div>
    </div>
</asp:Content>