<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="admin_usuarios.aspx.cs" Inherits="FrontEnd.admin_usuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/admin.css"/>
    <script>
        function eliminarProducto(index) {
            if (confirm("¿Estás seguro de eliminar este producto?")) {
                // Lógica para eliminar el producto
                alert("Producto eliminado del carrito");
            }
        }
    </script>
<div id="body">            
    <div id="items">
        <asp:Label runat="server" ID="problem"></asp:Label>
        <table width: 100%, display: flex;>
            <tr>
                <th>Email</th>
                <th>Nombre</th>
                <th>Apellidos</th>
                <th>Admin</th>
                <th>Fecha de nacimiento</th>
                <th>DNI</th>
                <th>Teléfono</th>
            </tr>
            <asp:Repeater ID="rptListUsers" runat="server">
                <ItemTemplate>
                    <tr>
                        <td class="element"><%# Eval("Email") %></td>
                        <td class="element"><%# Eval("Nombre") %></td>
                        <td class="element"><%# Eval("Apellidos") %></td>
                        <td class="element"><%# Eval("Admin") %></td>
                        <td class="element"><%# Eval("Fecha") %></td>
                        <td class="element"><%# Eval("Dni") %></td>
                        <td class="element"><%# Eval("Telefono") %></td>
                        <td class="element">
                            <button class="Button" onclick="eliminarProducto(<%# Container.ItemIndex + 1 %>)">Eliminar</button>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
    </div>
</asp:Content>
