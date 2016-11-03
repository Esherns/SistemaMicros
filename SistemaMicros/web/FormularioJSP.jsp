<%-- 
    Document   : FormularioJSP
    Created on : 25-09-2016, 18:31:58
    Author     : Silvio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrarse</title>
    </head>
    <body>
        <form action="/SistemaMicros/Formulario" method="post">  
        Nombre:<input type="text" name="nombre"/><br/>  
        Mail:<input type="text" name="mail"/><br/>
        Rut:<input type="text" name="pais"/><br/>
        Numero:<input type="text" name="numero"/><br/>
        Contraseña:<input type="text" name="pass"/><br/><br/>
        <input type="submit" value="Registrarse"/>  
        </form>
        <form action="/SistemaMicros/index.html" method="post">
        <input type="submit" value="Volver"/> 
        </form>
    </body>
</html>
