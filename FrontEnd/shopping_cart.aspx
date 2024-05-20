<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="shopping_cart.aspx.cs" Inherits="proyecto.shopping_cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="estilos/index.css"/>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        #body {
            display: flex;
            justify-content: center;
            align-items: center;
            
            margin: 0;
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            background-color: #6b551d;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 600px;
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
            background-color: #007bff;
            color: white;
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
    <div id="body">
        <div class="container">
            <h2 id="titulo">Carrito de la compra</h2>
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
                                <asp:Button ID="btnRemove" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' Text="Remove" CssClass="btn-remove" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <p class="message">Tu carrito está vacío.</p>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>

            <div id="divTotalAndBuy" runat="server">
                <h2>Total: <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></h2>
                <asp:Button ID="btnBuy" runat="server" Text="Comprar" CssClass="btn" OnClick="btnBuy_Click" />
            </div>

            <h2>Add Product</h2>
            <div class="form-group">
                <asp:TextBox ID="txtProductId" runat="server" Placeholder="Product ID"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtProductName" runat="server" Placeholder="Product Name"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtProductPrice" runat="server" Placeholder="Product Price"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtProductQuantity" runat="server" Placeholder="Quantity"></asp:TextBox>
            </div>
            <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn" OnClick="btnAddToCart_Click" />
        </div>
    </div>
            
        
</asp:Content>