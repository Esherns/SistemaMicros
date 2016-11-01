/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Visual;

import Clases.Cliente;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Silvio
 */
public class Formulario extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String validar = Validacion(request);
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        
        if (validar.equals("true")) 
        {
            String nombre = request.getParameter("nombre");
            String mail = request.getParameter("mail");
            String numero = request.getParameter("numero");
            String rut = request.getParameter("pais");
            String pass = request.getParameter("pass");
            
            Cliente c = new Cliente(nombre,mail,rut,numero,pass);
            session.setAttribute("Usuario", c);
            out.println("Se ha registrado con exito!");
            request.getRequestDispatcher("/index.html").include(request, response);
        }
        else
        {
            out.println(validar);
            request.getRequestDispatcher("/FormularioJSP.jsp").include(request, response);
        }
        
    }
    
    protected String Validacion(HttpServletRequest request)
        {
            if (request.getParameter("nombre").trim().equals("") || request.getParameter("nombre") == null) 
            {
                return "El nombre no puede estar vacio";
            }
            try 
            { 
                int a = Integer.parseInt(request.getParameter("numero"));
                if (request.getParameter("numero").trim().length() != 9 ) 
                {
                    return "El numero debe tener 9 caracteres";
                }
            } 
            catch(NumberFormatException e )
            { 
                return "El campo numero debe ser numerico";
            }
            if (request.getParameter("mail").trim().equals("") || request.getParameter("mail") == null) 
            {
                return "El mail no puede estar vacio";
            }    
            if (request.getParameter("pais").trim().equals("") || request.getParameter("pais") == null) 
            {
                return "El rut no puede estar vacio";
            }  
            if (request.getParameter("pass").trim().equals("") || request.getParameter("pass") == null) 
            {
                return "El procedimiento no puede estar vacio";
            }
            if (request.getParameter("pass").trim().length() < 8) 
            {
                return "La contraseña debe tener al menos 8 caracteres";
            }
            
            
            return "true";
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
            throws ServletException, IOException {
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
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
