<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="productos.aspx.cs" Inherits="proyecto.productos" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Productos</title>
    <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>PRODUCTOS</h1>
            <div class="products-container">
                <asp:Repeater ID="RepeaterProductos" runat="server" OnItemCommand="RepeaterProductos_ItemCommand">
                    <ItemTemplate>
                        <div class="product-card">
                            <div class="product-image">
                                <div class="product-image">
                                    <img src='<%# Eval("url_image", "{0}.webp") %>' alt="Producto" />
                                </div>
                                <div class="discount-tag">
                                    <%# Eval("promocion.Descuento") %>% OFF
                                </div>
                            </div>
                            <div class="product-info">
                                <h3><%# Eval("nombre") %></h3>
                                <p><%# Eval("descripcion") %></p>
                                <p class="price">
                                    <%# Eval("pvp", "{0:N2} EUR") %>
                                </p>
                                <asp:Button ID="btnAddToCart" runat="server" Text="Añadir al carrito" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>
body {
    font-family: Arial, sans-serif;
}

.products-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
}

.product-card {
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    margin: 16px;
    width: 300px;
    overflow: hidden;
}

.product-image {
    position: relative;
    height: 200px;
    overflow: hidden;
}

.product-image img {
    width: 100%;
    height: auto;
    display: block;
}

.discount-tag {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: red;
    color: white;
    padding: 5px;
    border-radius: 50%;
}

.product-info {
    padding: 16px;
    text-align: center;
}

.product-info h3 {
    margin: 0 0 10px;
}

.product-info p {
    margin: 0 0 10px;
    color: #666;
}

.price {
    font-size: 18px;
    color: #333;
}

.original-price {
    text-decoration: line-through;
    color: #999;
    font-size: 14px;
    margin-left: 8px;
}

button {
    background-color: #f0c14b;
    border: 1px solid #a88734;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 4px;
    font-size: 16px;
}

button:hover {
    background-color: #e2b33b;
}
