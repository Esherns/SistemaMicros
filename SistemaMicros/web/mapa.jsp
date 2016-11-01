
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
        <script src="js/libs/jquery/jquery.js" type="text/javascript"></script>
        <script src="js/libs/ol3/ol.js" type="text/javascript"></script>
        <script src="jsMapa.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <%

            //Obteniendo información del servlet
            ArrayList<Paradero> paraderos;
            paraderos = ParaderosYMicrosServlet.getParaderos();
            ArrayList<Micro> micros;
            micros = ParaderosYMicrosServlet.getMicros();

            for (Paradero p : paraderos) {
        %>
        <div hidden="true" id="<%=p.getNombre()%>">
            <div id="<%=p.getNombre() + "CoordenadaX"%>" ><%= p.getCoordenadas()[0]%></div>
            <div id="<%=p.getNombre() + "CoordenadaY"%>" ><%= p.getCoordenadas()[1]%></div>
            <%
                for (Micro m : p.getMicros()) {
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
            for (Micro m : micros) {
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
        <div class="mainContainer">
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
                        $('.puntoMapaDeLaMuerte').css({'background-color':'blue'});

                        console.log('Entered dibujarMicro()');
                        var selectedParadero = $('#ddlParaderos :selected').text().replace(/ /g, '').replace(/(\n)+/g, '');
                        var selectedMicro = $('#ddlMicros :selected').text().replace(/ /g, '').replace(/(\n)+/g, '');
                        if (selectedMicro === 'Please select an option')
                        {
                            console.log("selectedMicro === 'Please select an option'");
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
                    //Prueba 



                    /* < %                   String s1 = "<script>document.writeln(yx) < /script>";
                     String s2 = "<script>document.writeln(zx)< /script>";
                     String s3 = "";
                     for (Paradero p : paraderos)
                     {
                     
                     if (p.getNombre().equals(s1))
                     {
                     
                     for (Micro m : p.getMicros())
                     {
                     if (m.getCodigo().equals("312"))
                     {
                     s3 = "Nombre: " + m.getCodigo()
                     + " Horario: " + m.getHorario()
                     + " Comuna: " + m.getComuna();
                     break;
                     }
                     
                     }
                     }
                     }
                     */
                    /*    
                     %  >
                     var x = "< %=//s3%>";
                     var y = document.getElementById("ddlParaderos").selectedIndex;
                     var yx = document.getElementById("ddlParaderos")[y].text;
                     var z = document.getElementById("ddlMicros").selectedIndex;
                     var zx = document.getElementById("ddlMicros")[z].text;
                     document.getElementById("info").innerHTML = x;*/
                }

            </script>      
            <div id="mapContent"></div>
            <input type="button" value="+" name="zoom+"  onclick="zoom(true)" />
            <input type="button" value="-" name="zoom-" onclick="zoom(false)" />
            <select onchange="cargarMicros()" name="ddlParaderos" id="ddlParaderos">
                <option>Please select an option</option>
                <% try {
                        for (Paradero p : paraderos) {
                %>
                <option><%= p.getNombre()%></option>
                <%
                        }
                    } catch (Exception ex) {
                        System.out.println("Error while loading ddl: " + ex.getMessage());
                    }
                %>
            </select>
            <select name="ddlMicros" onchange="dibujarMicro();
                    mostrarInfo();" id="ddlMicros"  disabled="true"> 
                <option>Please select an option</option>

            </select>
            <div id="infoMicro" hidden="true">

            </div>
            <form action="index.html">
                <input class="boton" type="submit" value="Volver">
            </form>

            <div id="overlayInfo"></div>

        </div>
        <p id="info"></p>
    </body>
</html>