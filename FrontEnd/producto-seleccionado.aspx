<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.master" CodeBehind="producto-seleccionado.aspx.cs" Inherits="FrontEnd.ProductoSeleccionado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Producto Seleccionado</title>
    <link rel="stylesheet" type="text/css" href="estilos/producto-seleccionado.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="product-detail-container">
        <div class="product-image">
            <asp:Image ID="imgProducto" runat="server" AlternateText="Producto" CssClass="product-image" />
        </div>
        <div class="product-details">
            <h1><asp:Label ID="lblNombreProducto" runat="server" Text=""></asp:Label></h1>
            <p><asp:Label ID="lblDescripcionProducto" runat="server" Text=""></asp:Label></p>
            <p class="price"><asp:Label ID="lblPrecioProducto" runat="server" Text=""></asp:Label></p>
            <div class="quantity-selection">
                <label for="quantity">Cantidad:</label>
                <asp:DropDownList ID="ddlQuantity" runat="server">
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />
                    <asp:ListItem Text="5" Value="5" />
                    <asp:ListItem Text="6" Value="6" />
                    <asp:ListItem Text="7" Value="7" />
                    <asp:ListItem Text="8" Value="8" />
                    <asp:ListItem Text="9" Value="9" />
                    <asp:ListItem Text="10" Value="10" />
                </asp:DropDownList>
            </div>
            <asp:Button ID="btnAddToCart" runat="server" Text="Añadir al carrito" CssClass="btnAddToCart" OnClick="btnAddToCart_Click" />
        </div>
    </div>

    <div class="reviews">
        <table width: 100%, display: flex>
            <asp:Repeater ID="rptListReviews" runat="server">
                    <ItemTemplate>
               <tr>
                    <td class="email"><%# Eval("Usuario.email") %></td>
                    <td class="puntuacion"> <%# Eval("puntuacion") %></td>
                </tr>
                <tr>
                    <td class="descripcion" colspan="4"><%# Eval("descripcion") %></td>
                </tr>
                    </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
</asp:Content>
