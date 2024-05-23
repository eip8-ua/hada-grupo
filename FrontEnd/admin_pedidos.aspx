<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="admin_pedidos.aspx.cs" Inherits="FrontEnd.admin_pedidos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/admin.css"/>

<div id="body">            
    <div id="items">
        <asp:Label runat="server" ID="problem"></asp:Label>
        <table width: 100%, display: flex;>
            <tr>
                <th>Número pedido</th>
                <th>Fecha del pedido</th>
                <th>Usuario del pedido</th>
            </tr>
            <asp:Repeater ID="rptListPedidos" runat="server">
                <ItemTemplate>
                    <tr>
                        <td class="element"><%# Eval("numpedido") %></td>
                        <td class="element"><%# Eval("fechaPedido") %></td>
                        <td class="element"><%# Eval("idUsuario") %></td>
                        <td class="element">
                            <button class="Button" onclick="EliminarPedido_Click(<%# Container.ItemIndex + 1 %>)">Eliminar</button>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
    </div>
</asp:Content>