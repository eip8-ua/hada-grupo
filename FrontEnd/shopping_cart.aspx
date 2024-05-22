<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="shopping_cart.aspx.cs" Inherits="proyecto.shopping_cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/index.css"/>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .container {
            display: flex;
            flex-direction: row;   
            background-color: white;
            padding: 20px;
        }

        .cartMenu {
            flex: 2;
            border-right: 1px solid #e0e0e0;
        }

        .totalMenu {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background: #b88e2f;
            
            padding: 30px;
            padding-bottom: 100px;
            border-radius: 8px;
            align-items: center;
        }

        #titulo {
            margin-left: 80px;
        }

        .gridview-container {
            width: 100%;
            margin-bottom: 20px;
         
        }
        .gridview-container table {
            width: 100%;
            border-collapse: collapse;
        }
        .gridview-container th, .gridview-container td {
            border: 1px solid #dee2e6;
            padding: 10px;
            text-align: left;
        }
        .gridview-container th {
            border-radius: 8px;
            background: #b88e2f;
        }
        .gridview-container tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .gridview-container tr:hover {
            background-color: #e9ecef;
        }
        h2 {
            margin-bottom: 10px;
        }
        .message {
            margin: 20px 0;
            color: #dc3545;
            font-size: 24px;
            margin-left: 40px;
        }

        a {
            color: #b88e2f;
        }

        .form-group {
            margin-bottom: 15px;
        }
        .form-group input {
            padding: 10px;
            width: calc(100% - 22px);
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
        .form-group input:focus {
            outline: none;
            border-color: #007bff;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 50px
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-remove {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-remove:hover {
            background-color: #c82333;
        }
    </style>
    <h2 id="titulo">Carrito de la compra</h2>
    <div class="container">
        <div class="cartMenu">
            <div class="gridview-container">
                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" OnRowCommand="gvCart_RowCommand" OnRowDataBound="gvCart_RowDataBound" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="Name" HeaderText="Nombre" ReadOnly="True" />
                        <asp:BoundField DataField="Price" HeaderText="Precio" DataFormatString="{0:C}" ReadOnly="True" />
                        <asp:TemplateField HeaderText="Cantidad">
                            <ItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' AutoPostBack="True" OnTextChanged="txtQuantity_TextChanged"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnRemove" runat="server" CommandName="Remove" CommandArgument='<%# Eval("Id") %>' Text="Eliminar" CssClass="btn-remove" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <p class="message">
                            Tu carrito está vacío. <br />
                            Añade productos en la <a href="index.aspx">tienda</a> para poder verlos en el carrito.
                        </p>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
        <div id="divTotalAndBuy" class="totalMenu" runat="server">
            <h2>Total: <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></h2>
            <asp:Button ID="btnBuy" runat="server" Text="Comprar" CssClass="btn" OnClick="btnBuy_Click" />
        </div>
    </div>
            
        
</asp:Content>