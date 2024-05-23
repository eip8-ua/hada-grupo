<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="contact_us.aspx.cs" Inherits="FrontEnd.contact_us" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Contáctanos</title>
    <link rel="stylesheet" type="text/css" href="estilos/login.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="central">
            <div class="logo">
                <img src="images/logo.png" />
            </div>

            <div class="txt_inicio_sesion">
                <label class="login_title">Contáctanos</label>

                <div class="div-parametros">
                    <div class="div-parametro">
                        <div class="texto">
                            Nombre
                        </div>
                        <asp:TextBox ID="nombre" runat="server" class="input" />
                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Email
                        </div>
                        <asp:TextBox ID="email" runat="server" TextMode="Email" class="input" />
                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Teléfono
                        </div>
                        <asp:TextBox ID="telf" runat="server" class="input" />
                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Mensaje
                        </div>
                        <asp:TextBox ID="mensaje" runat="server" TextMode="MultiLine" class="input" />
                    </div>

                    <div class="status-div">
                        <asp:Label class="status-lbl" runat="server" ID="status_lbl"></asp:Label>
                    </div>
                </div>

                <asp:Button ID="login_btn"
                    Text="Contactar"
                    class="boton-login"
                    OnClick="Login_Click"
                    runat="server" />
            </div>
        </div>
    </div>
</asp:Content>
