/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Visual;

import Clases.Micro;
import Clases.Paradero;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        getMicros().add(new Micro("303", "06:00 - 24:00", "Quilicura"));
        micros.add(new Micro("315", "06:00 - 24:00", "Quilicura"));
        micros.add(new Micro("314", "06:00 - 24:00", "Quilicura"));
        micros.add(new Micro("307", "06:00 - 24:00", "Quilicura"));

        ArrayList<Micro> m1 = new ArrayList<Micro>();
        m1.add(micros.get(0));
        m1.add(micros.get(1));
        getParaderos().add(new Paradero("Supermercado", "Quilicura", m1,
               new Double[]{-70.7331770990127,-33.36456717292718}));

        ArrayList<Micro> m2 = new ArrayList<Micro>();
        m2.add(micros.get(2));
        m2.add(micros.get(3));
        getParaderos().add(new Paradero("Plaza", "Quilicura", m2,
        new Double[]{-70.72995844819484,-33.36555283296405}));

        ArrayList<Micro> m3 = new ArrayList<Micro>();
        m3.add(micros.get(1));
        m3.add(micros.get(2));
        getParaderos().add(new Paradero("Colegio", "Quilicura", m3,
        new Double[]{-70.73143902757106,-33.367828768935084}));

        micros.get(0).setParaderoActual(paraderos.get(0));
        micros.get(1).setParaderoActual(paraderos.get(1));
        micros.get(2).setParaderoActual(paraderos.get(0));
        micros.get(3).setParaderoActual(paraderos.get(2));
        
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
