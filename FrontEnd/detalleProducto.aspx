<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="detalleProducto.aspx.cs" Inherits="proyecto.detalleProducto" MasterPageFile="~/Site1.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h1>Detalles del Producto</h1>
        <div class="product-detail">
            <img id="imgProducto" runat="server" alt="Imagen del Producto" />
            <h2><asp:Literal ID="litNombre" runat="server"></asp:Literal></h2>
            <p><asp:Literal ID="litDescripcion" runat="server"></asp:Literal></p>
            <p><strong>Precio:</strong> <asp:Literal ID="litPvp" runat="server"></asp:Literal></p>
            <p><strong>Stock:</strong> <asp:Literal ID="litStock" runat="server"></asp:Literal></p>
            <asp:Button ID="btnAddToCart" runat="server" Text="Añadir al carrito" />
        </div>
    </div>
</asp:Content>

