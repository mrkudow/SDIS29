/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ap32.servlets;

import com.ap32.bdd.CalendrierMysql;
import com.ap32.bdd.ParametreMysql;
import com.ap32.bdd.PompierMysql;
import com.ap32.beans.Journee;
import com.ap32.beans.Pompier;
import com.ap32.forms.ModifForm;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author steve.maingana
 */

@WebServlet(name = "ProfilServlet", urlPatterns = {"/profil"})

public class ProfilServlet extends HttpServlet {

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
            out.println("<title>Servlet ProfilServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfilServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
    * Handles the HTTP <code>GET</code> method.
    * Gère l'affichage du profil de l'utilisateur connecté
    * Charge les données du pompier et prépare l'affichage en mode consultation
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

        // Charge les données du pompier connecté
        PompierMysql pompierBDD = new PompierMysql();
        ParametreMysql parametreBDD = new ParametreMysql();
        int userId = (int) maSession.getAttribute("user");
        

        // Configure le contexte pour l'affichage
        request.setAttribute("action", "profil");        // Contexte "profil personnel"
        request.setAttribute("profil-editing", false);   // Mode consultation par défaut
        request.setAttribute("pompier", pompierBDD.read(userId)); // Données du pompier
        
        ArrayList<Journee> disponibilites = pompierBDD.read(userId).getDisponibilites(true);
        request.setAttribute("start1", disponibilites.get(0).getDateToString());
        request.setAttribute("end1", disponibilites.get(disponibilites.size()-1).getDateToString());
        
        disponibilites = pompierBDD.read(userId).getDisponibilites(false);
        request.setAttribute("start2", disponibilites.get(0).getDateToString());
        request.setAttribute("end2", disponibilites.get(disponibilites.size()-1).getDateToString());
        request.setAttribute("parametres", parametreBDD);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/profilVue.jsp");
        dispatcher.forward(request, response);
    }

    /**
    * Handles the HTTP <code>POST</code> method.
    * Gère les actions sur le profil (édition, modification, annulation)
    * Traite les différents états du formulaire de profil
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
        PompierMysql pompierBDD = new PompierMysql();
        ParametreMysql parametreBDD = new ParametreMysql();
        request.setAttribute("grades", parametreBDD.readAllGrade());
        int userId = (int) maSession.getAttribute("user");
        String edit = request.getParameter("edit");

        // Charge toujours les données du pompier pour la vue
        request.setAttribute("pompier", pompierBDD.read(userId));

        // Vérifie la présence du paramètre d'action
        if (edit == null) {
            response.sendRedirect("profil");
            return;
        }

        // Traite l'action demandée
        switch (request.getParameter("edit")) {
            case "0":
                // Annuler les modifications : retour au mode consultation
                request.setAttribute("profilEditing", false);
                response.sendRedirect("profil");
                break;
            case "1":
                // Enregistrer les modifications profil
                Pompier pompier = pompierBDD.read((int) maSession.getAttribute("user"));
                ModifForm modifForm = new ModifForm();
                modifForm.modifierProfil(request, pompier); // Applique les modifications
                request.setAttribute("profilEditing", false); // Retour en mode consultation
                response.sendRedirect("profil");
                break;
            case "2":
                // Passer en mode édition
                request.setAttribute("profilEditing", true);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/profilVue.jsp");
                dispatcher.forward(request, response); // Réaffiche la page en mode édition
                break;
            case "4":
                modifForm = new ModifForm();
                modifForm.modifierDisponibilite(request, userId);
            default:
                // Action non reconnue, redirection vers le profil
                response.sendRedirect("profil");
                break;
        }
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
