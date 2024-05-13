<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="shopping_cart.aspx.cs" Inherits="proyecto.shopping_cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <script>
        function actualizarCantidad(index, cantidad) {
            // Obtener el carrito actual desde la cookie
            var cart = getCartFromCookie();

            // Actualizar la cantidad del producto en el carrito
            cart[index - 1].Cantidad = parseInt(cantidad);

            // Guardar el carrito actualizado en la cookie
            setCartCookie(cart);

            // Recargar la página para reflejar los cambios
            location.reload();
        }

        function eliminarProducto(index) {
            // Obtener el carrito actual desde la cookie
            var cart = getCartFromCookie();

            // Eliminar el producto del carrito
            cart.splice(index - 1, 1);

            // Guardar el carrito actualizado en la cookie
            setCartCookie(cart);

            // Recargar la página para reflejar los cambios
            location.reload();
        }

        function getCartFromCookie() {
            // Obtener el valor de la cookie 'cartItems'
            var cartCookie = document.cookie.split('; ').find(row => row.startsWith('cartItems='));

            // Si la cookie existe, extraer el valor y convertirlo a un objeto
            if (cartCookie) {
                var cartJson = cartCookie.split('=')[1];
                return JSON.parse(decodeURIComponent(cartJson));
            } else {
                return [];
            }
        }

        function setCartCookie(cart) {
            // Convertir el carrito a JSON y codificarlo para almacenar en la cookie
            var cartJson = JSON.stringify(cart);
            document.cookie = 'cartItems=' + encodeURIComponent(cartJson) + ';path=/';
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

