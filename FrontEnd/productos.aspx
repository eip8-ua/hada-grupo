<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.master" CodeBehind="productos.aspx.cs" Inherits="FrontEnd.productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Productos</title>
    <link rel="stylesheet" type="text/css" href="estilos/productos.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h1>PRODUCTOS</h1>
        <div class="products-container">
            <asp:Repeater ID="RepeaterProductos" runat="server">
                <ItemTemplate>
                    <div class="product-card">
                        <asp:HyperLink ID="HyperLinkImage" runat="server" NavigateUrl='<%# "producto-seleccionado.aspx?id=" + Eval("id") %>'>
                            <img src='<%# Eval("url_image") %>' alt="Producto" class="product-image" />
                        </asp:HyperLink>
                        <div class="discount-tag" style='<%# Convert.ToDecimal(Eval("promocion.Descuento")) > 0 ? "" : "display:none;" %>'>
                            <%# Eval("promocion.Descuento") %>% OFF
                        </div>
                        <div class="product-info">
                            <h3>
                                <asp:HyperLink ID="HyperLinkProductName" runat="server" 
                                               NavigateUrl='<%# "producto-seleccionado.aspx?id=" + Eval("id") %>'
                                               Style="text-decoration:none; color:black;">
                                    <%# Eval("nombre") %>
                                </asp:HyperLink>
                            </h3>
                            <p class="price">
                                <%# Eval("pvp", "{0:N2} EUR") %>
                            </p>
                            <asp:Button ID="btnAddToCart" runat="server" CssClass="btnAddToCart" Text="Añadir al carrito" CommandArgument='<%# Eval("id") %>' CommandName="AddToCart" OnCommand="btnAddToCart_Command" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
