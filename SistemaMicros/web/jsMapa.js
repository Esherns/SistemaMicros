/* 
 * Diego Marquez
 * Script de mapa
 */


/* global ol, ol */

var map;
var coordMicro, coordParadero;
try
{

    function crearMapa()
    {

        //Centro inicial del mapa
        var center = ol.proj.fromLonLat([-70.73015156724392, -33.365678279804115]);

        //Controles del mapa
        var interaction = new ol.interaction.DragRotateAndZoom();

        //Creacion del mapa
        try
        {
            map = new ol.Map({
                target: 'mapContent', //div en la que el mapa se dibujará
                layers: [
                    new ol.layer.Tile({
                        source: new ol.source.OSM()
                    })
                ],
                view: new ol.View({
                    center: center,
                    zoom: 16
                })
            });

            map.on('click', function (event)
            {
                try
                {

                    var overlay = new ol.Overlay({
                        element: document.getElementById('overlayInfo'),
                        positioning: 'bottom-center'
                    });

                    // extract the spatial coordinate of the click event in map projection units
                    var coord = event.coordinate;

                    // transform it to decimal degrees
                    var degrees = ol.proj.transform(coord, 'EPSG:3857', 'EPSG:4326');

                    // format a human readable version
                    var hdms = degrees; //ol.coordinate.toStringHDMS(degrees);

                    // update the overlay element's content
                    var element = overlay.getElement();
                    element.innerHTML = hdms;

                    // position the element (using the coordinate in the map's projection)
                    overlay.setPosition(coord);

                    // and add it to the map
                    map.addOverlay(overlay);

                } catch (err)
                {
                    alert("Error while handling click event: " + err.message);
                }
            });

        } catch (err)
        {
            alert("error creating map : " + err.message);
        }
    }

    function zoom(direction)
    {
        try
        {
            map.getView().setZoom(map.getView().getZoom() + (direction ? 1 : -1));
        } catch (err)
        {
            alert("error while zooming : " + err.message);
        }
    }

    function compararParaderoYMicro() //retruns true if coords are the same
    {
        try
        {
            console.log('Entered compararParaderoYMicro()');

            console.log('coordMicro = ' + coordMicro
                    + '\ncoordParadero = ' + coordParadero);
            if (coordMicro == null || coordParadero == null ||
                    coordMicro == undefined || coordParadero == undefined) {
                console.log('coordMicro == null || cordParadero == null ||' +
                        'coordMicro == undefined || cordParadero == undefined ');
                return false;
            }
            console.log('Exiting compararParaderoYMicro() by returning '
                    +(coordMicro[0] === coordParadero[0] && coordMicro[1] === coordParadero[1]));
            return (coordMicro[0] === coordParadero[0] && coordMicro[1] === coordParadero[1]);
        } catch (err)
        {
            alert('error on compararParaderoYMicro(): ' + err.message);
            console.log('error on compararParaderoYMicro(): ' + err.message);
        }
    }




    function agregarLugar(nombre, coords, pointClass)
    {
        try
        {
            console.log('Entered agregarLugar()');

            if (pointClass === 'puntoMapaDeLaMuerte') {
                console.log("pointClass === 'puntoMapaDeLaMuerte'");
                coordParadero = coords;
            } else if (pointClass === 'puntoMapa') {
                console.log("pointClass === 'puntoMapa'");
                coordMicro = coords;
            }
            var style = "";
            if (compararParaderoYMicro()) {
                style += 'style="background-color:green;"';
                $('.puntoMapa').remove();
                $('.puntoMapaDeLaMuerte').hide();

            }
            nombre += 'point';
            console.log('nombre: ' + nombre + '\ncoords: ' + coords + '\npointClass: ' + pointClass);

            var element = '<div  class="' + pointClass + '" id="' + nombre + '" ' + style + ' ></div>';
            console.log('element: ' + element);
            //console.log('');
            $('.mainContainer').prepend(element);
//            selectedMicroconsole.log('New mainContainer html: \n'+$('.mainContainer').html());
            var nuevaUbicacion = new ol.Overlay({
                element: document.getElementById(nombre)
            });
            nuevaUbicacion.setPosition(coords);

            console.log('nuevaUbicacion element: ' + nuevaUbicacion.getElement());
            console.log('nuevaUbicacion coords: ' + nuevaUbicacion.getPosition());

            map.addOverlay(nuevaUbicacion);
            console.log('map Overlays: ' + map.getOverlays());
        } catch (err)
        {
            alert("error on agregarLugar() : " + err.message);
        }
    }



    $.urlParam = function (name)
    {
        try
        {

            var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
            if (results == null)
            {
                return null;
            } else
            {
                return results[1] || 0;
            }
        } catch (err)
        {
            alert("error on $.urlParam()");
            alert(err.message);

        }
    };
} catch (err)
{
    alert("general error on jsMapa.js :: " + err.message);
}






/*// create a DOM Input helper for the checkbox
 var visible = new ol.dom.Input(document.getElementById('visible'));
 // and bind its 'checked' property to the layer's 'visible' property
 visible.bindTo('checked', layer, 'visible');
 //alert("success on creating map (on js file)");*/

//Adding marker to the map
/*var markers = new ol.layer.Marker("Markers");
 map.addLayer(markers);
 var size = new ol.Size(21, 25);
 var offset = new ol.Pixel(-(size.w / 2), -size.h);
 var icon = new ol.Icon('http://www.openlayers.org/dev/img/marker.png', size, offset);
 markers.addMarker(new ol.Marker(new ol.LonLat(-71.2145493748054, -33.68552322652857), icon));
 markers.addMarker(new ol.Marker(new ol.LonLat(-71.2145493748054, -33.68552322652857), icon.clone()));*/



/*
 map.on('click', function (event)
 {
 try
 {
 var coord = event.coordinate;
 var degrees = ol.proj.transform(coord, 'EPSG:3857', 'EPSG:4326');
 var coordContainer = document.getElementById('coordContainer');
 coordContainer.innerHTML = degrees;
 } catch (err)
 {
 alert("map error on onClick(): " + err.message);
 }
 });
 */