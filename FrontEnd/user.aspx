﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="FrontEnd.user" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>User</title>
    <link rel="stylesheet" type="text/css" href="estilos/usuario.css"/>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <script>
            function actualizarUsuario() {
                if (confirm("¿Estás seguro de que deseas cambiar los datos de este usuario? \n Puedes dejar los textos en blanco para los datos que no desees modificar")) {
                    alert("Usuario modificado");
                    return true;
                }
                else return false;
            }
     </script>
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
            <asp:TextBox runat="server" TextMode="Password" ID="contrasena" Width="220"></asp:TextBox>
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
            <asp:TextBox runat="server" TextMode="Date" ID="fechaNac" Width="220"></asp:TextBox>

            <p>
                DNI: 
            </p>
            <asp:TextBox runat="server" ID="dni" Width="220"></asp:TextBox>
        </div>
        <div class="user-buttons">
            <asp:Button runat="server" class=ButtonStyle2 ID="actualizar" Width="100" Text="Actualizar" OnClientClick="return actualizarUsuario()" OnClick="cuandoActualizar"></asp:Button>
            <asp:Label runat="server" ID="error"></asp:Label>
        </div>
        
        
    </div>
    <asp:TextBox runat="server" ID="Salida"></asp:TextBox>
    </div>
</asp:Content>
