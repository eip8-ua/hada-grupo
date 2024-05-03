<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="contact_us.aspx.cs" Inherits="proyecto.contact_us" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <h3>Contáctanos</h3>
       <div class="contact_us_menu">
        <div class="contact_us">
            <div class="campo_contact">
                        <div class="texto_contact">
                            Nombre:<br />
                            <asp:TextBox ID="password" CssClass="input-estilo" type="password" runat="server" ValidateRequestMode="Enabled"/>
                        </div>
             </div>
            <div class="campo_contact">
                        <div class="texto_contact">                            
                            Email:<br />                                  
                            <asp:TextBox ID="TextBox1" CssClass="input-estilo" type="password" runat="server" ValidateRequestMode="Enabled"/>
                        </div>
            </div>
            <div class="campo_contact">
                        <div class="texto_contact">
                            Teléfono:<br />
                            <asp:TextBox ID="TextBox2" CssClass="input-estilo" type="password" runat="server" ValidateRequestMode="Enabled"/>
                        </div>
                    </div>
            <div class="campo_contact">
                        <div class="texto_contact">
                            Mensaje:<br />
                            <asp:TextBox ID="TextBox3" CssClass="input-estilo" type="password" runat="server" ValidateRequestMode="Enabled" Height="100px"/>
                        </div>
            </div>
        </div>
       </div>
    </center>
    
</asp:Content>
