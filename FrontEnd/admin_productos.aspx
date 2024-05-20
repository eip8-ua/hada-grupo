<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="admin_productos.aspx.cs" Inherits="FrontEnd.admin_productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>User</title>
    <link rel="stylesheet" type="text/css" href="estilos/admin_productos.css" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="central">

            <div class="txt_inicio_sesion">
                <label class="login_title">Añadir producto</label>

                <div class="div-parametros">
                    <div class="div-parametro">
                        <div class="texto">
                            Producto*
                        </div>

                        <asp:TextBox ID="producto" runat="server" TextMode="SingleLine" name="producto" class="input" />
                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Precio*
                        </div>

                        <asp:TextBox ID="precio" runat="server" TextMode="SingleLine" name="precio" class="input" />

                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Descripción
                        </div>

                        <asp:TextBox ID="descripcion" runat="server" name="descripcion" class="input" />

                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Stock*
                        </div>

                        <asp:TextBox ID="stock" runat="server" name="stock" class="input" />

                    </div>
                    <div class="div-parametro">
                        <div class="texto">
                            Imagen*
                        </div>

                        <asp:TextBox ID="imagen" runat="server" name="imagen" class="input" />

                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Categoría
                        </div>

                        <asp:DropDownList ID="categoria" runat="server"></asp:DropDownList>

                    </div>

                    <div class="div-parametro">
                        <div class="texto">
                            Promoción
                        </div>
                        <asp:DropDownList ID="promocion" runat="server"></asp:DropDownList>
                    </div>
                    <div class="status-div">
                        <asp:Label class="status-lbl" runat="server" ID="status_lbl"></asp:Label>
                    </div>
                </div>
            </div>


            <asp:Button ID="add_product"
                Text="Añadir"
                class="add_product_btn"
                OnClick="Add_Product_Click"
                runat="server" />
        </div>

    </div>
</asp:Content>

