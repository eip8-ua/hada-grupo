<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="testimonial.aspx.cs" Inherits="proyecto.testimonial" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h3>Testimonial</h3>
       <div id="testimonialContainer" class="testimonial_container">
        <div class="testimonial">
            <p id="nombre_testimonial"></p>

            <button id="btn1"><</button>
            <span class="testimonial_quote">“</span>
                <span id="testimonialText"></span>
                <span class="testimonial_quote">”</span>
            <button id="btn2">></button>
            </div>
        </div>
<script>

    var nombres = [
        'Nombre 1',
        'Nombre 2',
        'Nombre 3',
        'Nombre 4'
    ];

    var citas = [
        'Esta es la cita del testimonio 1.',
        'Esta es la cita del testimonio 2.',
        'Esta es la cita del testimonio 3.',
        'Esta es la cita del testimonio 4.'
    ];

    var indiceActual = 0;

    document.getElementById('nombre_testimonial').innerHTML = nombres[indiceActual];
    document.getElementById('testimonialText').innerHTML = citas[indiceActual];

    document.getElementById('btn1').addEventListener('click', function (event) {
        event.preventDefault(); 

        indiceActual = (indiceActual - 1 + citas.length) % citas.length;

        document.getElementById('nombre_testimonial').innerHTML = nombres[indiceActual];
        document.getElementById('testimonialText').innerHTML = citas[indiceActual];
    });

    document.getElementById('btn2').addEventListener('click', function (event) {
        event.preventDefault(); // Evita el postback

        indiceActual = (indiceActual + 1) % citas.length;

        document.getElementById('nombre_testimonial').innerHTML = nombres[indiceActual];
        document.getElementById('testimonialText').innerHTML = citas[indiceActual];
    });
</script>



</asp:Content>




