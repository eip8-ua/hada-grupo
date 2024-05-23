<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="productosCategoria.aspx.cs" Inherits="FrontEnd.productosCategoria" MasterPageFile="~/Site1.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h1>Productos de la Categoría: <asp:Literal ID="litCategoria" runat="server"></asp:Literal></h1>
        <div class="products-container">
            <asp:Repeater ID="RepeaterProductos" runat="server">
                <ItemTemplate>
                    <div class="product-card">
                        <div class="product-image">
                            <img src='<%# ResolveUrl("~/Images/Productos/" + Eval("url_image")) %>' alt="Producto" />
                            <div class="discount-tag">
                                <%# Eval("promocion.Descuento") %>% OFF
                            </div>
                        </div>
                        <div class="product-info">
                            <h3><%# Eval("nombre") %></h3>
                            <p><%# Eval("descripcion") %></p>
                            <p class="price">
                                <%# Eval("pvp", "{0:N2} EUR") %>
                            </p>
                            <asp:Button ID="btnAddToCart" runat="server" Text="Añadir al carrito" CommandArgument='<%# Eval("id") %>' CommandName="AddToCart" onClick="btnAddToCart_Click" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
