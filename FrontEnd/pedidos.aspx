<%@ Page Title="Mis pedidos" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="pedidos.aspx.cs" Inherits="FrontEnd.pedidos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .order-table {
            width: 100%;
            border-collapse: collapse;
        }
        .order-table th, .order-table td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        .order-table th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #f2f2f2;
        }
        .no-orders-message {
            color: red;
            font-weight: bold;
            font-size: 1.5em;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Mis pedidos</h2>
    <asp:Label ID="NoOrdersLabel" runat="server" CssClass="no-orders-message" Visible="false" />
    <asp:GridView ID="OrdersGridView" runat="server" AutoGenerateColumns="False" CssClass="order-table">
        <Columns>
            <asp:BoundField DataField="Numpedido" HeaderText="Número de Pedido" />
            <asp:BoundField DataField="FechaPedido" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="IdUsuario" HeaderText="Usuario" />
        </Columns>
    </asp:GridView>
</asp:Content>
