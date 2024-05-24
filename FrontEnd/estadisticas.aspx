<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="estadisticas.aspx.cs" Inherits="FrontEnd.estadisticas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/estadisticas.css"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="titulo">Información adicional de los productos</h1>
    <div ID="product_list">
        <div id="column1" runat="server" class="product_col"></div>
        <div id="column2" runat="server" class="product_col"></div>
        <div id="column3" runat="server" class="product_col"></div>
    </div>
    <h1 class="titulo">Los diez mejores usuarios</h1>
    <div id="users" runat="server"></div>
    <h1 class="titulo">Provincia más popular</h1>
    <div id ="province" runat="server" class="province"></div>
</asp:Content>
