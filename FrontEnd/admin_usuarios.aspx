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

        function actualizarCantidad(index, newValue) {
            // Lógica para actualizar la cantidad del producto en el carrito
            // newValue: nuevo valor de cantidad seleccionado por el usuario
            if (newValue >= 1 && newValue <= 10) {
                alert("Cantidad actualizada a " + newValue);
                // Aquí puedes enviar una solicitud al servidor para actualizar la cantidad del producto
            } else {
                alert("La cantidad debe estar entre 1 y 10");
                // Restaurar el valor anterior o tomar otra acción según sea necesario
            }
        }
    </script>
<div id="body">            
    <div id="items">
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
                        <td><%# Eval("Email") %></td>
                        <td><%# Eval("Nombre") %></td>
                        <td><%# Eval("Apellidos") %></td>
                        <td><%# Eval("Admin") %></td>
                        <td><%# Eval("Fecha") %></td>
                        <td><%# Eval("Dni") %></td>
                        <td><%# Eval("Telefono") %></td>
                        <td>
                            <button class="Button" onclick="eliminarProducto(<%# Container.ItemIndex + 1 %>)">Eliminar</button>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
    </div>
</asp:Content>
