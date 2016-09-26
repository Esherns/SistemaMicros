
<%@page import="Visual.ParaderosYMicrosServlet"%>
<%@page import="Clases.Micro"%>
<%@page import="Clases.Paradero"%>
e<%-- 
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
        <script src="js/libs/ol3/ol.js" type="text/javascript"></script>
        <script src="js/libs/jquery/jquery.js" type="text/javascript"></script>
        <script src="jsMapa.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <%

            //Obteniendo información del servlet
            ArrayList<Paradero> paraderos;
            paraderos = ParaderosYMicrosServlet.getParaderos();

            for (Paradero p : paraderos)
            {
        %>
        <div hidden="true" id="<%=p.getNombre()%>">
            <%
                for (Micro m : p.getMicros())
                {
            %> 
            <div id="<%=p.getNombre() + m.getCodigo()%>">
                <div class="<%=p.getNombre() + "nombre"%>"><%= m.getCodigo()%></div>
                <div id="<%=p.getNombre() + m.getCodigo() + "coordenadaX"%>"><%= m.getParaderoActual().getCoordenadas()[0]%></div>
                <div id="<%=p.getNombre() + m.getCodigo() + "coordenadaY"%>"><%= m.getParaderoActual().getCoordenadas()[1]%></div>
            </div>
            <%
                }
            %>
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
        <div class="mainContainer">
            <script>
                function cargarMicros()
                {
                    var i = $('#ddlParaderos :selected').text();
                    if ('Please select an option' === i)
                    {
                        $('#ddlMicros').html('<option>Please select an option</option>');
                        $('#ddlMicros').prop('disabled', 'true');
                        return;
                    }
                    //alert('i = ' + i);
                    var result = '<option>Please select an option</option>';
                    $('#' + i).children().each(function (index)
                    {
                        var nom = $(this).find('.' + i + 'nombre').text();
                        result += '<option>' + nom + '</option>';
                    });
                    $('#ddlMicros').html(result);
                    $('#ddlMicros').prop('disabled', false);

                }

                function dibujarMicro()
                {
                    try
                    {

                        var i = $('#ddlParaderos :selected').text().replace(/ /g, '').replace(/(\n)+/g, '');
                        var j = $('#ddlMicros :selected').text().replace(/ /g, '').replace(/(\n)+/g, '');
                        if (j === 'Please select an option')
                        {
                            return;
                        }
                        var idX = parseFloat($('#' + i + j + 'coordenadaX').text());
                        var idY = parseFloat($('#' + i + j + 'coordenadaY').text());
                        //alert('idX = ' + idX+'\nidY = '+idY);
                        var coords = ol.proj.fromLonLat([idX, idY]);
                        //alert(coords);
                        //map.getView().setCenter(coords);
                        agregarLugar(i + j, coords);
                    } catch (err)
                    {
                        alert('Error en dibujarMicro() : '+err.message);
                    }

                }

            </script>      
            <div id="mapContent"></div>
            <input type="button" value="+" name="zoom+"  onclick="zoom(true)" />
            <input type="button" value="-" name="zoom-" onclick="zoom(false)" />
            <select onchange="cargarMicros()" name="ddlParaderos" id="ddlParaderos">
                <option>Please select an option</option>
                <%  for (Paradero p : paraderos)
                    {
                %>
                <option><%= p.getNombre()%></option>
                <%
                    }
                %>
            </select>
            <select name="ddlMicros" onchange="dibujarMicro()" id="ddlMicros"  disabled="true"> 
                <option>Please select an option</option>
            </select>
            <form action="main.jsp">
                <input class="boton" type="submit" value="Volver">
            </form>

            <div id="overlayInfo"></div>

        </div>
    </body>
</html>