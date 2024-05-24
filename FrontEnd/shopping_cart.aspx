<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="shopping_cart.aspx.cs" Inherits="FrontEnd.shopping_cart" %>
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

                /* Estilos para la ventana modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.6);
            background-color: #b88e2f;
            padding-top: 60px;
        }

        .modal-content {
            background-color: #ffffff;
            margin: 5% auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            width: 80%;
            font-size: 42px;
            font-weight: bold;
            max-width: 400px;
            position: relative;
        }

        .close, .confirm, .cancel {
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
        }

        .close {
            color: #aaa;
            position: absolute;
            top: 15px;
            right: 15px;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
        }

        .button-container {
            text-align: center;
            margin-top: 30px;
        }

        .button {
            margin: 10px;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .button.cancel {
            background-color: #f44336;
        }

        .button:hover {
            background-color: #45a049;
        }

        .button.cancel:hover {
            background-color: #e53935;
        }


    </style>

    <script type="text/javascript">
            function showModal() {
                document.getElementById('myModal').style.display = 'block';
                return false; // Prevent postback
            }

            function closeModal() {
                document.getElementById('myModal').style.display = 'none';
            }

            function confirmAction() {
                document.getElementById('btnBuy').click();
            }

            // Close the modal when clicking outside of the modal content
            window.onclick = function(event) {
                var modal = document.getElementById('myModal');
                if (event.target == modal) {
                    modal.style.display = 'none';
                }
            }
    </script>

    <h2 id="titulo">Carrito de la compra</h2>
    <div class="container">
        <!-- Ventana Modal -->
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <p>¿Estás seguro de que quieres continuar?</p>
                <div class="button-container">
                    <asp:Button ID="Button2" class="button confirm" runat="server" Text="Finalizar Compra" OnClick="btnBuy_Click" />
                    <button class="button cancel" onclick="closeModal()">Cancelar Compra</button>
                </div>
            </div>
        </div>
        <div class="cartMenu">
            <div class="gridview-container">
                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" OnRowCommand="gvCart_RowCommand" OnRowDataBound="gvCart_RowDataBound" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="Name" HeaderText="Nombre" ReadOnly="True" />
                        <asp:BoundField DataField="Price" HeaderText="Precio" DataFormatString="{0:C}" ReadOnly="True" />
                        <asp:TemplateField HeaderText="Precio con Descuento">
                            <ItemTemplate>
                                <%# GetDiscountedPrice((float)Eval("Price"), (float)Eval("Discount")) %>
                            </ItemTemplate>
                        </asp:TemplateField>
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
            <h3>Total sin descuentos: <asp:Label ID="lblTotalPvp" runat="server" Text="0"></asp:Label></h3>
            <h3>Total ahorrado con descuentos: <asp:Label ID="lblTotalDesc" runat="server" Text="0"></asp:Label></h3>
            <h2>Total: <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></h2>
            <asp:Button ID="btnBuy" runat="server" Text="Comprar" CssClass="btn" OnClick="btnBuy_Click" />
        </div>
    </div>
            
        
</asp:Content>