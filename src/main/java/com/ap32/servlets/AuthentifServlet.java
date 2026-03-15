/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ap32.servlets;

import com.ap32.bdd.ParametreMysql;
import com.ap32.forms.AuthentifForm;
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

@WebServlet(name = "AuthentifServlet", urlPatterns = {"/authentification"})

public class AuthentifServlet extends HttpServlet {

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
            out.println("<title>Servlet AuthentifServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AuthentifServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
    * Handles the HTTP <code>GET</code> method.
    * Gère l'accès à la page d'authentification
    * Redirige vers le profil si l'utilisateur est déjà authentifié
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
       // Vérifie si l'utilisateur est déjà authentifié
       boolean isAuthentified = (maSession.getAttribute("isAuthentified") != null) ? (boolean) maSession.getAttribute("isAuthentified") : false;
       if (isAuthentified) {
           // Redirige vers le profil si déjà connecté
           response.sendRedirect("profil");
           return;
       }

       // Affiche la page d'authentification si non connecté
       getServletContext().getRequestDispatcher("/WEB-INF/authentificationVue.jsp").forward(request, response);
   }

   /**
    * Handles the HTTP <code>POST</code> method.
    * Traite la tentative de connexion de l'utilisateur
    * Redirige vers la page appropriée selon le rôle en cas de succès
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
       String pseudo = (String) request.getParameter("pseudo");
       String mdp = (String) request.getParameter("mdp");
       AuthentifForm authentification = new AuthentifForm();
       String role;
       String redirection;

       // Vérifie que les champs ne sont pas vides
       if (!pseudo.isBlank() && !mdp.isBlank()) {
           // Tente l'authentification
           if (authentification.existeUser(request, maSession)) {
               role = (String) maSession.getAttribute("role");

               // Détermine la redirection selon le rôle de l'utilisateur
               switch (role) {
                   case "chef de centre":
                       redirection = "caserne";  // Accès à la gestion de caserne
                       break;
                   case "responsable des alertes":
                       redirection = "profil";   // Temporairement vers le profil
                       // redirection = "interventions";  // Mission 2 : gestion des interventions
                       break;
                   default:
                       redirection = "profil";   // Pompier standard
                       break;
               }

               // Redirige vers la page appropriée
               response.sendRedirect(redirection);
               return;
           }
       }

       // Si échec de connexion, réaffiche le formulaire avec message d'erreur
       request.setAttribute("authentification", authentification);
       getServletContext().getRequestDispatcher("/WEB-INF/authentificationVue.jsp").forward(request, response);
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
