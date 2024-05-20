<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="producto-seleccionado.aspx.cs" Inherits="proyecto.ProductoSeleccionado" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Producto Seleccionado</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Detalles del Producto</h1>
            <div>
                <asp:Label ID="lblNombreProducto" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="lblDescripcionProducto" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="lblPrecioProducto" runat="server" Text=""></asp:Label><br />
                <asp:Image ID="imgProducto" runat="server" AlternateText="Producto" />
                <asp:Button ID="btnAddToCart" runat="server" Text="Añadir al carrito" />
            </div>
        </div>
    </form>
</body>
</html>
