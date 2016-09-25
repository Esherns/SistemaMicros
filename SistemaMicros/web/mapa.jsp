<%@page import="Servlets.ParaderosYMicrosServlet"%>
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
            ArrayList<Micro> micros;
            micros = ParaderosYMicrosServlet.getMicros();
        %>   
        <script type="text/javascript">
            $(document).ready(function ()
            {
                crearMapa();
            });

        </script>
        <div class="mainContainer">

            <div id="mapContent"></div>
            <input type="button" value="+" name="zoom+"  onclick="zoom(true)" />
            <input type="button" value="-" name="zoom-" onclick="zoom(false)" />
            <select name="ddlParaderos">
                <option>asd</option>
                <option>asd</option>
            </select>
            <select name="ddlMicros">
                <option>asd</option>
                <option>asd</option>
            </select>
            <form action="main.jsp">
                <input class="boton" type="submit" value="Volver">
            </form>

            <div id="overlayInfo"></div>

        </div>
    </body>
</html>