/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Visual;

import Clases.Micro;
import Clases.MicroBD;
import Clases.Paradero;
import Clases.ParaderoBD;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Diego
 */
@WebServlet(name = "ParaderosYMicrosServlet", urlPatterns =
{
    "/ParaderosYMicrosServlet"
})
public class ParaderosYMicrosServlet extends HttpServlet
{

    private static ArrayList<Paradero> paraderos;
    private static ArrayList<Micro> micros;

    static
    {
        //Agregar información aquí
        // getMicros().add(new Micro("303", "06:00 - 24:00", "Quilicura"));
        // micros.add(new Micro("315", "06:00 - 24:00", "Quilicura"));
        // micros.add(new Micro("314", "06:00 - 24:00", "Quilicura"));
        // micros.add(new Micro("307", "06:00 - 24:00", "Quilicura"));

        ArrayList<MicroBD> microsFormatoDB = (ArrayList<MicroBD>)new dao.MicroDAO().findAll();

        for ( MicroBD mdb : microsFormatoDB) 
        {

            Micro m = new Micro(mdb.getRecorrido_codigoRecorrido(),mdb.getHorario());

            getMicros().add(m);
            
        }


        ArrayList<ParaderoBD> paraderosFormatoDB = (ArrayList<ParaderoBD>) new dao.ParaderoDAO().findAll();
        Random gn = new Random();

        for (ParaderoBD pbd : paraderosFormatoDB ) 
        {
            Paradero p = new Paradero(pbd.getNombre(),pbd.getComuna(),
                new ArrayList<Micro>(), new Double[]{pbd.getLatitud(),pbd.getLongitud()});

            getMicros().stream().filter((m) -> (gn.nextBoolean())).map((m) -> 
            {
                p.getMicros().add(m);
                return m;
            }).forEachOrdered((m) ->
            {
                m.setComuna(p.getComuna());
            });
            getParaderos().add(p);
        }         

        getMicros().forEach((m) -> 
        {
            m.setParaderoActual(getParaderos().get(gn.nextInt()%getParaderos().size()));
        });

        
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo()
    {
        return "Short description";
    }// </editor-fold>

    /**
     * Crea un nuevo arreglo si éste no existe
     *
     * @return paraderos registrados
     */
    public static ArrayList<Paradero> getParaderos()
    {
        if (paraderos == null)
        {
            paraderos = new ArrayList<Paradero>();
        }
        return paraderos;
    }

    /**
     * Crea un nuevo arreglo si éste no existe
     *
     * @return micros registradas
     */
    public static ArrayList<Micro> getMicros()
    {
        if (micros == null)
        {
            micros = new ArrayList<Micro>();
        }
        return micros;
    }

}
