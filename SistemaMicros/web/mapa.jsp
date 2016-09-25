<%@page import="Servlets.ParaderosYMicrosServlet"%>
<%@page import="Clases.Micro"%>
<%@page import="Clases.Paradero"%>
<!-- -->
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
        <script src="jsMapa.js" type="text/javascript"></script>
        <script src="js/libs/jquery/jquery.js" type="text/javascript"></script>
        <script src="js/libs/ol3/ol.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body >
        <%!
            public static HashMap<String, Double[]> lugares = new HashMap<String, Double[]>();
        %>
        <%

            //Obteniendo información del servlet
            ArrayList<Paradero> paraderos;
            paraderos = ParaderosYMicrosServlet.getParaderos();
            ArrayList<Micro> micros;
            micros = ParaderosYMicrosServlet.getMicros();
        %>   
        <div class="mainContainer">

            <form action="main.jsp">
                <input class="boton" type="submit" value="Volver"
                       style="position:absolute; top: 10%; left: 60px;">
            </form>

            <div class="simbolo" id="SimboloDeUbicacion" style="background-color: red">    
                <div style="position:relative;left: 55px;width: 100px">
                    Ubicacion Buscada                   
                </div>    
            </div>

            <div  class="simbolo" id="SimboloDeUbicacionActual" style="background-color: yellow">    
                <div style="position:relative; left: 55px;width: 100px">
                    Ubicacion Actual                   
                </div>    
            </div>

            <div id="coordContainer"></div>
            <div id="mapContent"></div>


        </div>
    </body>
</html>