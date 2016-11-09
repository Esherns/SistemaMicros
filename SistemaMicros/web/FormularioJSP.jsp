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
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <!-- JQuery include -->
        <script
        src="https://code.jquery.com/jquery-3.1.1.min.js"
        integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
        crossorigin="anonymous"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>



    </head>
    <body>
        <div class="container">
            <div class="row">

                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">

                </div>

                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                    <form id="form" action="/SistemaMicros/Formulario" method="post" role="form">  
                        <legend>Registro de Usuario</legend>

                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <input type="text" class="form-control" id="nombre" placeholder="Nombre del usuario" required>
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" placeholder="Correo electrónico">
                            <label for="pais">RUT</label>
                            <input type="text" class="form-control" id="pais" placeholder="09.999.999-k">
                            <label for="numero">Número de telefono</label>
                            <input type="text" class="form-control" id="numero" placeholder="+56 9 ">
                            <label for="pass">Contraseña</label>
                            <input type="password" class="form-control" id="pass" placeholder="xxxxxxx">
                            <div id="dialog" title="" hidden="true" >
                                <p id="dialogInfo"></p>
                            </div>
                        </div>


                        <div class="btn-group-vertical">
                            <button type="submit" class="btn btn-block btn-success">Registrarse</button></form>

                            <form action="/SistemaMicros/index.html" method="POST" role="form">
                                <button type="submit" class="btn btn-block btn-primary">Volver</button>
                            </form>
                        </div>
                        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">

                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script type="text/javascript">
            jQuery(document).ready(function($) {
        //Establishing validations
        $('#form').submit(function(event){

            var validator = /^[a-zA-Z.]+$/g;
            if (!$('#nombre').val().search(validator) == -1) {
                $('#dialog').attr({
                    title: 'Nombre incorrecto',
                });
                $('dialogInfo').val('El nombre debe tener solamente letras y espacios');
                $('#dialog').dialog();
                event.preventDefault();
                return;
            }
            var validator = /^[a-zA-Z.]+@$[a-zA-Z.]+\.[a-zA-Z.]+/g;
            if (!$('email').val().search(validator) == -1) {
                $('#dialog').attr({
                    title: 'Email incorrecto',
                });
                $('dialogInfo').val('email : /^[a-zA-Z.]+@$[a-zA-Z.]+\.[a-zA-Z.]+/g');
                $('#dialog').dialog();
                event.preventDefault();
                return;
            }
            var validator = /^\d{1,2}\.?\d{3}\.?\d{3}-?\d/g;
            if (!$('pais').val().search(validator) == -1) {
                $('#dialog').attr({
                    title: 'RUT incorrecto',
                });
                $('dialogInfo').val('Rut inválido');
                $('#dialog').dialog();
                event.preventDefault();
                return;

            }
            var validator = /^\+?[\d ]{8,12}$/g;
            if (!$('numero').val().search(validator) == -1) {
                $('#dialog').attr({
                    title: 'Numero invalido',
                });
                $('dialogInfo').val('Solo se permiten caracteres numéricos y el signo + al principio');
                $('#dialog').dialog();
                event.preventDefault();
                return;
            }
            var validator = /^.{8,32}/g;
            if (!$('pass').val().search(validator) == -1) {
                $('#dialog').attr({
                    title: 'Email incorrecto',
                });
                $('dialogInfo').val('La contraseña debe tener entre 8 y 32 caracteres');
                $('#dialog').dialog();
                event.preventDefault();
                return;
            }
        });
    });
</script>
</html>
