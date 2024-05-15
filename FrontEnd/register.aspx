<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="proyecto.register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Register</title>
    <link rel="stylesheet" href="estilos/register.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="central">
            <div class="logo">
                <img src="images/logo.png" />
            </div>

            <div class="txt_inicio_sesion">
                <label class="login_title">Registro</label>

                <div class="div-parametros">
                    <div class="div-parametro">
                        <div class="texto">
                            Correo electronico*
                        </div>

                        <asp:TextBox ID="email" runat="server" TextMode="Email" name="email" class="input" />
                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Contraseña*
                        </div>

                        <asp:TextBox ID="password" runat="server" TextMode="Password" name="password" class="input" />

                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            DNI*
                        </div>

                        <asp:TextBox ID="dni" runat="server" name="dni" class="input" />

                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Nombre*
                        </div>

                        <asp:TextBox ID="nombre" runat="server" name="nombre" class="input" />

                    </div>
                    <div class="div-parametro">
                        <div class="texto">
                            Apellidos*
                        </div>

                        <asp:TextBox ID="apellidos" runat="server" name="apellidos" class="input" />

                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Teléfono
                        </div>

                        <asp:TextBox ID="telefono" runat="server" name="telefono" class="input" />

                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Fecha nacimiento
                        </div>

                        <asp:TextBox ID="fecha_nacimiento" TextMode="Date" runat="server" name="fecha_nacimiento" class="input" />

                    </div>
                    <div class="status-div">
                        <asp:Label class="status-lbl" runat="server" ID="status_lbl"></asp:Label>
                    </div>
                </div>
            </div>


            <asp:Button ID="create_account_btn"
                Text="Crear cuenta"
                class="create_account_btn"
                OnClick="Create_Account_Click"
                runat="server" />
            <!--<asp:label runat="server" id="botono1" Text="HOla"></asp:label> /!-->
        </div>

    </div>
</asp:Content>
