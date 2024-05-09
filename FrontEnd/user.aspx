<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="proyecto.user" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                Dirección:
            </p>
            <asp:TextBox runat="server" ID="direccion" Width="220"></asp:TextBox>

            <p>
                DNI: 
            </p>
            <asp:TextBox runat="server" ID="dni" Width="220"></asp:TextBox>
        </div>
        <div class="user-buttons">
            <asp:Button runat="server" ID="actualizar" Width="100" Text="Actualizar" OnClick="cuandoActualizar"></asp:Button>
        </div>
        
        
    </div>
    <asp:TextBox runat="server" ID="Salida"></asp:TextBox>
</asp:Content>
