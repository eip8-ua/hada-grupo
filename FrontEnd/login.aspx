<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="proyecto.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="central">
            <div class="logo_marca">
                <label>
                    Aquí irá el logo de la tienda
                </label>
            </div>

            <div class="inicio_sesion">
                Inicio de sesión

                    <div class="div-parametros">
                        <div class="div-parametro">
                            <div class="texto">
                                Correo o nombre de usuario
                            </div>
                            <div class="separadorvertical"></div>

                            <asp:TextBox ID="email" runat="server" TextMode="Email" name="email" class="input" />
                        </div>

                        <div class="separadorvertical"></div>

                        <div class="div-parametro">
                            <div class="texto">
                                Contraseña
                            </div>
                            <div class="separadorvertical"></div>


                            <asp:TextBox ID="password" runat="server" TextMode="Password" name="password" class="input" />


                        </div>
                    </div>
            </div>



            <asp:Button ID="login_btn"
                Text="Login"
                class="boton-login"
                CommandName="Submit"
                OnClick="Login_Click"
                runat="server" />


        </div>
    </div>
</asp:Content>
