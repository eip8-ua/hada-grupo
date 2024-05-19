<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="proyecto.user" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>User</title>
    <link rel="stylesheet" type="text/css" href="estilos/usuario.css"/>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class ="spacing">
    <h3>Datos del usuario</h3>

    <div class="user-data">
        <div class="user-side">
            <p>
                Dirección de correo:
            </p>
            <asp:TextBox runat="server" ID="correo" Width="220"></asp:TextBox>
            <p>
                Contraseña:
            </p>
            <asp:TextBox runat="server" ID="contrasena" Width="220"></asp:TextBox>
        </div>    
            
        <div class="user-side">
            <p>
                Nombre:                
            </p>
            <asp:TextBox runat="server" ID="nombre" Width="220"></asp:TextBox>
            <p>
                Apellidos: 
            </p>
            <asp:TextBox runat="server" ID="apellidos" Width="220"></asp:TextBox>
            <p>
                Número de teléfono:
            </p>
            <asp:TextBox runat="server" ID="tlfno" Width="220"></asp:TextBox>

            <p>
                Fecha de nacimiento:
            </p>
            <asp:TextBox runat="server" ID="direccion" Width="220"></asp:TextBox>

            <p>
                DNI: 
            </p>
            <asp:TextBox runat="server" ID="dni" Width="220"></asp:TextBox>
        </div>
        <div class="user-buttons">
            <asp:Button runat="server" class=ButtonStyle2 ID="actualizar" Width="100" Text="Actualizar" OnClick="cuandoActualizar"></asp:Button>
            <asp:Label runat="server" ID="error"></asp:Label>
        </div>
        
        
    </div>
    <asp:TextBox runat="server" ID="Salida"></asp:TextBox>
    </div>
</asp:Content>
