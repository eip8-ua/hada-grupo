<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="proyecto.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Login</title>
    <link rel="stylesheet" href="estilos/login.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="central">
            <div class="logo">
                <img src="images/logo.png" />
            </div>
            
            <div class="txt_inicio_sesion">
                <label class="login_title">Inicio de sesión</label>

                    <div class="div-parametros">
                        <div class="div-parametro">
                            <div class="texto">
                                Correo electrónico
                            </div>
                            <!-- <div class="separadorhorizontal"></div> -->

                            <asp:TextBox ID="email" runat="server" TextMode="Email" name="email" class="input" />
                        </div>


                        <div class="div-parametro">
                            <div class="texto">
                                Contraseña
                            </div>
                            <!-- <div class="separadorhorizontal"></div> -->

                            <asp:TextBox ID="password" runat="server" TextMode="Password" name="password" class="input" />

                        </div>
                    </div>
                    
                    
                <asp:Button ID="login_btn"
                    Text="Iniciar sesión"
                    class="boton-login"
                    OnClick="Login_Click"
                    runat="server" />

            </div>
                
                
            <asp:Button ID="register_btn"
                Text="Crear una nueva cuenta"
                class="boton-register"
                OnClick="Register_Click"
                runat="server" />
            <!--<asp:label runat="server" id="botono1" Text="HOla"></asp:label> /!-->
        </div>

    </div>
</asp:Content>
