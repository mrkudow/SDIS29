/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ap32.servlets;

import com.ap32.bdd.ParametreMysql;
import com.ap32.forms.NouveauForm;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author steve.maingana
 */

@WebServlet(name = "DeconnexionServlet", urlPatterns = {"/nouveau-pompier"})
public class NouveauPompierServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NouveauPompierServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NouveauPompierServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
    * Handles the HTTP <code>GET</code> method.
    * Gère l'affichage du formulaire de création d'un nouveau pompier
    * Vérifie les permissions et charge les données pour les listes déroulantes
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession maSession = request.getSession();
        // Vérifie que l'utilisateur est authentifié
        boolean isAuthentified = (maSession.getAttribute("isAuthentified") != null) ? (boolean) maSession.getAttribute("isAuthentified") : false;
        if (!isAuthentified) {
            response.sendRedirect("authentification");
            return;
        }

        // Vérifie que l'utilisateur a le rôle de chef de centre
        String role = (String) maSession.getAttribute("role");
        if (!role.equals("chef de centre")) {
            response.sendRedirect("profil");
            return;
        }

        // Charge les listes pour les champs du formulaire
        ParametreMysql parametreBDD = new ParametreMysql();
        request.setAttribute("statuts", parametreBDD.readAllRole());
        request.setAttribute("personnels", parametreBDD.readAllPersonnel());
        request.setAttribute("grades", parametreBDD.readAllGrade());

        // Affiche le formulaire de création
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/nouveauPompierVue.jsp");
        dispatcher.forward(request, response);
    }

    /**
    * Handles the HTTP <code>POST</code> method.
    * Gère la soumission du formulaire de création d'un nouveau pompier
    * Traite les données et effectue l'enregistrement en base
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession maSession = request.getSession();
        // Vérifie l'authentification
        boolean isAuthentified = (maSession.getAttribute("isAuthentified") != null) ? (boolean) maSession.getAttribute("isAuthentified") : false;
        if (!isAuthentified) {
            response.sendRedirect("authentification");
            return;
        }

        // Vérifie les permissions de chef de centre
        String role = (String) maSession.getAttribute("role");
        if (!role.equals("chef de centre")) {
            response.sendRedirect("profil");
            return;
        }

        // Traite la création du nouveau pompier
        NouveauForm nouveauForm = new NouveauForm();
        boolean enregistrement = nouveauForm.nouveauPompier(request);

        // Passe le résultat de l'enregistrement à la vue
        request.setAttribute("enregistrement", enregistrement);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/nouveauPompierVue.jsp");
        dispatcher.forward(request, response);
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
