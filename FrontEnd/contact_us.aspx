<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="contact_us.aspx.cs" Inherits="FrontEnd.contact_us" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/login.css" />
    <title>Contáctanos</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div>
        
       <div class="central">
            <div class="logo">
                <img src="images/logo.png" />
            </div>
            <div class="div-parametros">
                        <div class="div_parametro">
                            <div class="texto">
                                Nombre
                            </div>
                            <asp:TextBox ID="nombre" class="input" type="password" runat="server" ValidateRequestMode="Enabled"/>
                        </div>
             
          
                        <div class="div_parametro">                            
                            <div class="texto">
                                Email
                            </div>                                
                            <asp:TextBox ID="email" class="input" runat="server" ValidateRequestMode="Enabled"/>
                        </div>
            
            
                        <div class="div_parametro">
                            <div class="texto">
                                Teléfono
                            </div>
                            <asp:TextBox ID="telf" class="input" runat="server" ValidateRequestMode="Enabled"/>
                        </div>
                    
            
                        <div class="div_parametro">
                            <div class="texto">
                                Mensaje
                            </div>
                            <asp:TextBox ID="mensaje" class="input" runat="server" ValidateRequestMode="Enabled"/>
                        </div>
            <div class="status-div">
                <asp:Label class="status-lbl" runat="server" ID="status_lbl"></asp:Label>
            </div>
        </div>
                <asp:Button ID="login_btn"
                    Text="Enviar mensaje y contacto"
                    class="boton-login"
                    OnClick="Login_Click"
                    runat="server" />
       </div>
    </div>
    
</asp:Content>
