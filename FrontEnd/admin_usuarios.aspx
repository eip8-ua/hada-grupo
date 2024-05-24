<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="admin_usuarios.aspx.cs" Inherits="FrontEnd.admin_usuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/admin.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script>
        function eliminarUsuario(email) {
            console.log("Función eliminarUsuario llamada"); // Verificar si la función 
            if (confirm("¿Estás seguro de eliminar este usuario?")) {
                // Llamar al método del servidor usando AJAX
                $.ajax({
                    type: "POST",
                    url: "YourPage.aspx/EliminarUsuario",
                    data: JSON.stringify({ email: email }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert(response.d); // Mostrar el mensaje del servidor
                        location.reload();
                    },
                    error: function (xhr, status, error) {
                        alert("Error al eliminar el usuario: " + error);
                    }
                });
                return false; // Evitar el postback
            }
            return false; // Evitar el postback si el usuario cancela
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
                         <td class="element">
                            <asp:Literal ID="EmailLiteral" runat="server" Text='<%# Eval("Email") %>'></asp:Literal>
                        </td>
                        <td class="element"><%# Eval("Nombre") %></td>
                        <td class="element"><%# Eval("Apellidos") %></td>
                        <td class="element"><%# Eval("Admin") %></td>
                        <td class="element"><%# Eval("Fecha") %></td>
                        <td class="element"><%# Eval("Dni") %></td>
                        <td class="element"><%# Eval("Telefono") %></td>
                        <td class="element">
                            <asp:LinkButton runat="server" class="Button" Text="Eliminar" OnCommand="EliminarUsuario" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Email") %>'/>

                            <%--<asp:Button runat="server" class="Button" Text="Eliminar" OnClientClick='<%# "return eliminarUsuario(\"" + Eval("Email") + "\");" %>' />--%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
    </div>
</asp:Content>
