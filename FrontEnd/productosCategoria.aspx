<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="productosCategoria.aspx.cs" Inherits="FrontEnd.productosCategoria" MasterPageFile="~/Site1.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/productos.css" />

    <div>
        <h1>Productos de la Categoría: <asp:Literal ID="litCategoria" runat="server"></asp:Literal></h1>
        <div class="products-container">
            <asp:Repeater ID="RepeaterProductos" runat="server">
                <ItemTemplate>
                    <div class="product-card">
                        <asp:HyperLink ID="HyperLinkImage" runat="server" NavigateUrl='<%# "producto-seleccionado.aspx?id=" + Eval("Id") %>'>
                            <img src='<%# Eval("url_image") %>' alt="Producto" class="product-image" />
                        </asp:HyperLink>
                        <div class="discount-tag" style='<%# Convert.ToDecimal(Eval("Promocion.Descuento")) > 0 ? "" : "display:none;" %>'>
                            <%# Eval("Promocion.Descuento") %>% OFF
                        </div>
                        <div class="product-info">
                            <h3>
                                <asp:HyperLink ID="HyperLinkProductName" runat="server" 
                                               NavigateUrl='<%# "producto-seleccionado.aspx?id=" + Eval("Id") %>'
                                               Style="text-decoration:none; color:black;">
                                    <%# Eval("Nombre") %>
                                </asp:HyperLink>
                            </h3>
                            <p class="price">
                                <%# Convert.ToDecimal(Eval("Promocion.Descuento")) > 0 ? 
                                    $"<span class='original-price'>{Eval("Pvp", "{0:N2} EUR")}</span> <span class='discounted-price'>{(Convert.ToDecimal(Eval("Pvp")) * (1 - Convert.ToDecimal(Eval("Promocion.Descuento")) / 100)).ToString("N2")} EUR</span>" : 
                                    $"<span class='normal-price'>{Eval("Pvp", "{0:N2} EUR")}</span>" %>
                            </p>
                            <asp:Button ID="btnAddToCart" runat="server" CssClass="btnAddToCart" Text="Añadir al carrito" CommandArgument='<%# Eval("id") %>' CommandName="AddToCart" OnCommand="btnAddToCart_Click" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
