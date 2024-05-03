<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="shopping_cart.aspx.cs" Inherits="proyecto.shopping_cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        #cartContainer {
            width: 80%;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        #cartHeader {
            background-color: #007bff;
            color: #ffffff;
            padding: 20px;
            text-align: center;
            font-size: 24px;
        }

        #cartItems {
            padding: 20px;
            flex-grow: 1;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #dddddd;
            padding: 12px;
            text-align: left;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        #cartSummary {
            background-color: #007bff;
            color: #ffffff;
            padding: 20px;
            text-align: center;
        }

        #cartSummary h2 {
            margin-bottom: 10px;
        }

        #btnComprar {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #ffffff;
            color: #007bff;
            border: 2px solid #007bff;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        #btnComprar:hover {
            background-color: #007bff;
            color: #ffffff;
        }

        .btnEliminar {
            padding: 8px 12px;
            font-size: 14px;
            background-color: #dc3545;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btnEliminar:hover {
            background-color: #c82333;
        }

        .cantidadInput {
            width: 60px;
            padding: 5px;
            font-size: 14px;
            text-align: center;
        }
    </style>
    <script>
        function eliminarProducto(index) {
            if (confirm("¿Estás seguro de eliminar este producto?")) {
                // Lógica para eliminar el producto
                alert("Producto eliminado del carrito");
            }
        }

        function actualizarCantidad(index, newValue) {
            // Lógica para actualizar la cantidad del producto en el carrito
            // newValue: nuevo valor de cantidad seleccionado por el usuario
            if (newValue >= 1 && newValue <= 10) {
                alert("Cantidad actualizada a " + newValue);
                // Aquí puedes enviar una solicitud al servidor para actualizar la cantidad del producto
            } else {
                alert("La cantidad debe estar entre 1 y 10");
                // Restaurar el valor anterior o tomar otra acción según sea necesario
            }
        }
    </script>
    <div id="body">
        <div id="cartContainer">
            <div id="cartHeader">Carrito de Compra</div>
            
            <div id="cartItems">
                <table>
                    <tr style="background-color: #007bff; color: #ffffff;">
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                        <th>Acciones</th>
                    </tr>
                    <asp:Repeater ID="rptCartItems" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Nombre") %></td>
                                <td>$<%# Eval("Precio", "{0:N2}") %></td>
                                <td>
                                    <input type="number" class="cantidadInput" min="1" max="10" value='<%# Eval("Cantidad") %>'
                                        onchange="actualizarCantidad(<%# Container.ItemIndex + 1 %>, this.value)" />
                                </td>
                                <td>$<%# Eval("Subtotal", "{0:N2}") %></td>
                                <td>
                                    <button class="btnEliminar" onclick="eliminarProducto(<%# Container.ItemIndex + 1 %>)">Eliminar</button>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
            
            <div id="cartSummary">
                <h2>Total: $<asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label></h2>
                <asp:Button ID="btnComprar" runat="server" Text="Comprar" OnClick="btnComprar_Click" />
            </div>
        </div>
    </div>
</asp:Content>

