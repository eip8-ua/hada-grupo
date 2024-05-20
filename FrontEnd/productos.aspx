<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="productos.aspx.cs" Inherits="proyecto.productos" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Productos</title>
    <link rel="stylesheet" type="text/css" href="productos.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>PRODUCTOS</h1>
            <div class="products-container">
                <asp:Repeater ID="RepeaterProductos" runat="server" OnItemCommand="RepeaterProductos_ItemCommand">
                    <ItemTemplate>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-image">
                                    <img src='<%# Eval("url_image", "{0}.webp") %>' alt="Producto" />
                                </div>
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
                                <asp:Button ID="btnAddToCart" runat="server" Text="Añadir al carrito" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>

