<%@page import="Visual.ParaderosYMicrosServlet"%>
<%@page import="Clases.Micro"%>
<%@page import="Clases.Paradero"%>
<%--
Document   : mapa
Created on : 16-09-2016, 20:55:47
Author     : Diego
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="mapa.css" rel="stylesheet" type="text/css"/>
    <script src="js/libs/jquery/jquery.js" type="text/javascript"></script>
    <script src="js/libs/ol3/ol-debug.js" type="text/javascript"></script>
    <script src="jsMapa.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- JQuery -->
    <script src="js/libs/jquery/jquery.min.js" type="text/javascript"></script>
    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-default"  role="navigation">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#" >Sistema de Micros</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="https://www.transantiago.cl/">Transantiago</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <p class="navbar-text">Logueado como ${username}</p>
                    </li>
                    <li><a href="index.html">Salir</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div>
    </nav>
<!--         <span class="glyphicon glyphicon-user navbar-right" aria-hidden="true">Logueado como ${username}</span>
-->    <%
ArrayList<Paradero> paraderos = new ArrayList<Paradero>();
ArrayList<Micro> micros = new ArrayList<Micro>();
try
{
    paraderos = ParaderosYMicrosServlet.getParaderos();
    micros = ParaderosYMicrosServlet.getMicros();
} catch (Exception ex)
{
    System.out.println(ex.getMessage());
}
for (Paradero p : paraderos)
    {
%>
<div hidden="true" id="<%=p.getNombre()%>">
    <div id="<%=p.getNombre() + "CoordenadaX"%>" ><%= p.getCoordenadas()[0]%></div>
    <div id="<%=p.getNombre() + "CoordenadaY"%>" ><%= p.getCoordenadas()[1]%></div>
    <%
    for (Micro m : p.getMicros())
    {
    %>
    <div id="<%=p.getNombre() + m.getCodigo()%>">
        <div class="<%=p.getNombre() + "nombre"%>"><%= m.getCodigo()%></div>
        <div id="<%=p.getNombre() + m.getCodigo()
        + "coordenadaX"%>"><%= m.getParaderoActual().getCoordenadas()[0]%></div>
        <div id="<%=p.getNombre() + m.getCodigo()
        + "coordenadaY"%>"><%= m.getParaderoActual().getCoordenadas()[1]%></div>
    </div>
    <%
}
%>
</div>
<%
}
for (Micro m : micros)
    {
%>
<div class="infoMicro" id="<%= m.getCodigo()%>" hidden="true" >
    <table border="1">
        <thead>
            <tr>
                <td>Codigo</td>
                <td><%= m.getCodigo()%></td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Horario</td>
                <td><%= m.getHorario()%></td>
            </tr>
            <tr>
                <td>Comuna</td>
                <td><%= m.getComuna()%></td>
            </tr>
            <tr>
                <td>Paradero Actual</td>
                <td><%= m.getParaderoActual().getNombre()%></td>
            </tr>
        </tbody>
    </table>
</div>
<%
}
%>
<script type="text/javascript">
    $(document).ready(function ()
    {
        crearMapa();
    });
</script>
<script>
    function cargarMicros()
    {
        try
        {
            //Limpiar puntos
            $('.puntoMapa').remove();
            $('.puntoMapaDeLaMuerte').remove();
            console.log('Entered cargarMicros()');
            var selectedParadero = $('#ddlParaderos :selected').text().replace(/ /g, '').replace(/(\n)+/g, '');
            if ('Please select an option' === selectedParadero)
            {
                $('#ddlMicros').html('<option>Please select an option</option>');
                $('#ddlMicros').prop('disabled', 'true');
                console.log("'Please select an option' === selectedParadero");
                return;
            }
            //alert('i = ' + i);
            //populate dropdownList
            var result = '<option>Please select an option</option>';
            console.log('selectedParadero + nombre = ' + '.' + selectedParadero + 'nombre');
            $('.' + selectedParadero + 'nombre').each(function (index)
            {
                var nom = $(this).text();
                console.log('foreach: nom = ' + nom);
                result += '<option>' + nom + '</option>';
            });
            $('#ddlMicros').html(result);
            $('#ddlMicros').prop('disabled', false);
            //draw on map
            var idX = parseFloat($('#' + selectedParadero + 'CoordenadaX').text());
            var idY = parseFloat($('#' + selectedParadero + 'CoordenadaY').text());
            console.log('idX = ' + idX + '\nidY = ' + idY);
            var coords = ol.proj.fromLonLat([idX, idY]);
            console.log(coords);
            agregarLugar(selectedParadero, coords, "puntoMapaDeLaMuerte");
            console.log('Exiting cargarMicros()');
        } catch (err)
        {
            alert('Error en cargarMicros(): ' + err.message);
        }
    }
    function dibujarMicro()
    {
        try
        {
            //Borrar ultima micro
            $('.puntoMapa').remove();
            $('.puntoMapaDeLaMuerte').show();
            $('.puntoMapaDeLaMuerte').css({'background-color': 'blue'});
            console.log('Entered dibujarMicro()');
            var selectedParadero = $('#ddlParaderos :selected').text().replace(/ /g, '').replace(/(\n)+/g, '');
            var selectedMicro = $('#ddlMicros :selected').text().replace(/ /g, '').replace(/(\n)+/g, '');
            if (selectedMicro === 'Seleccione una opción')
            {
                console.log("selectedMicro === 'Seleccione una opción'");
                return;
            }
            var idX = parseFloat($('#' + selectedParadero + selectedMicro + 'coordenadaX').text());
            var idY = parseFloat($('#' + selectedParadero + selectedMicro + 'coordenadaY').text());
            console.log('idX = ' + idX + '\nidY = ' + idY);
            var coords = ol.proj.fromLonLat([idX, idY]);
            console.log(coords);
            agregarLugar(selectedParadero + selectedMicro, coords, "puntoMapa");
        } catch (err)
        {
            alert('Error en dibujarMicro() : ' + err.message);
        }
    }
    function mostrarInfo()
    {
            //Prueba
            try
            {
                console.log('Entering Prueba');
                var selectedMicro = $('#ddlMicros :selected').text().replace(/ /g, '').replace(/(\n)+/g, '');
                console.log('Selected micro : ' + selectedMicro);
                var microInfo = $('#' + selectedMicro).html();
                console.log('Micro\'s info : ' + $(microInfo).text());
                $('#infoMicro').html(microInfo);
                $('#infoMicro').attr('hidden', false);
            } catch (err)
            {
                alert('Error on Prueba: ' + err.message);
                console.log('Error on Prueba: ' + err.message);
            }
        }
    </script>
    <div class="container" style="background: #ccccccc;"  >
        <div class="row">
            <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                <!-- Map column -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div id="mapContent"></div>
                    </div>
                </div>
            </div>
            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                <!-- Options column -->
                <div class="form-group">
                    <label for="ddlParaderos" class="col-sm-2 control-label">Paradero:</label>
                    <select onchange="cargarMicros()" name="ddlParaderos" id="ddlParaderos" class="form-control" >
                        <option>Seleccione una opción</option>
                        <% try
                        {
                        for (Paradero p : paraderos)
                        {
                        %>
                        <option><%= p.getNombre()%></option>
                        <%}} catch (Exception ex)
                        {%>
                        <%= ex.getMessage()%>
                        <%}
                        %>
                    </select>
                    <label for="ddlMicros" class="col-sm-2 control-label">Micro:</label>
                    <select name="ddlMicros" id="ddlMicros" onchange="dibujarMicro(); mostrarInfo();" class="form-control" >
                        <option>Seleccione una opción</option>
                        <% try
                        {
                        for (Micro p : micros)
                        {
                        %>
                        <option><%= p.getCodigo()%></option>
                        <%}} catch (Exception ex)
                        {%>
                        <%= ex.getMessage()%>
                        <%}%>
                    </select>
                </div>
                <div id="infoMicro" hidden="true"></div>
                <form action="index.html">
                    <input class="btn btn-block btn-primary " type="submit" value="Volver">
                    <input type="button" class="btn btn-block btn-primary" value="+" name="zoom+"  onclick="zoom(true)" />
                    <input type="button" class="btn btn-block btn-primary" value="-" name="zoom-" onclick="zoom(false)" />
                </form>
                <div id="overlayInfo"></div>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                <!-- Dummy column -->
            </div>
        </div>
    </div>
    <p id="info"></p>
</body>
<script type="text/javascript">
    jQuery(document).ready(function($) {
        setTimeout(function() {
            $('.ol-overlaycontainer-stopevent').attr({
                hidden: 'true',
            });
            $('canvas').attr({
                height: '',
                width: '',
            });
            $('.puntoMapa .puntoMapaDeLaMuerte').css('border-radius', '20px !important');
            $('.puntoMapa .puntoMapaDeLaMuerte').css('height', '30px !important');
            $('.puntoMapa .puntoMapaDeLaMuerte').css('width', '30px !important');
            $('.puntoMapa .puntoMapaDeLaMuerte').css('hidden', 'false');
            if (dummy) {clearTimeout(this);}
        }, 500);
    });
</script>
</html>