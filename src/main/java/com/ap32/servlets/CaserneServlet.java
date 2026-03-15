/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ap32.servlets;

import com.ap32.bdd.CaserneMysql;
import com.ap32.bdd.ParametreMysql;
import com.ap32.bdd.PompierMysql;
import com.ap32.beans.Caserne;
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
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjuster;
import java.time.temporal.TemporalAdjusters;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.Locale;

/**
 *
 * @author steve.maingana
 */
@WebServlet(name = "CaserneServlet", urlPatterns = {"/caserne"})
public class CaserneServlet extends HttpServlet {

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
            out.println("<title>Servlet CaserneServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CaserneServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method. Gère l'accès à la page de
     * gestion de caserne Vérifie les permissions et charge les données de la
     * caserne
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

        // Charge les données du chef de centre et de sa caserne
        Pompier pompier = new PompierMysql().read((int) maSession.getAttribute("user"));
        CaserneMysql caserneBDD = new CaserneMysql();
        Caserne caserne = caserneBDD.read(pompier.getCaserne());

        LocalDate dateActuelle = LocalDate.now();
        LocalDate lundi = dateActuelle.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        ArrayList<Object[]> semaine = new ArrayList<>();

        for (int i = 0; i < 7; i++) {
            LocalDate jour = lundi.plusDays(i);
            String affichage = jour.format(DateTimeFormatter.ofPattern("EE dd/MM", Locale.FRENCH));
            affichage = affichage.substring(0, 1).toUpperCase() + affichage.substring(1).replace(".", "");

            semaine.add(new Object[]{
                jour,
                affichage
            });
        }
        
        int numeroSemaine = lundi.get(WeekFields.of(Locale.FRANCE).weekOfWeekBasedYear());
        
        request.setAttribute("semaine1", semaine);
        request.setAttribute("numeroSemaine1", numeroSemaine);
        
        lundi = dateActuelle.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
        semaine = new ArrayList<>();

        for (int i = 0; i < 7; i++) {
            LocalDate jour = lundi.plusDays(i);
            String affichage = jour.format(DateTimeFormatter.ofPattern("EE dd/MM", Locale.FRENCH));
            affichage = affichage.substring(0, 1).toUpperCase() + affichage.substring(1).replace(".", "");

            semaine.add(new Object[]{
                jour,
                affichage
            });
        }
        
        numeroSemaine = lundi.get(WeekFields.of(Locale.FRANCE).weekOfWeekBasedYear());
        
        request.setAttribute("semaine2", semaine);
        request.setAttribute("numeroSemaine2", numeroSemaine);

        // Passe la caserne à la vue
        request.setAttribute("caserne", caserne);
        
        
        

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/caserneVue.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method. Gère les actions de gestion
     * des pompiers de la caserne Traite l'édition et la modification des
     * profils
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

        // Initialisation des données pour les listes déroulantes
        ParametreMysql parametreBDD = new ParametreMysql();
        String edit = request.getParameter("edit");
        PompierMysql pompierBDD = new PompierMysql();
        Pompier pompier;
        String pompierId = request.getParameter("pompier");

        // Charge les listes pour les formulaires
        request.setAttribute("statuts", parametreBDD.readAllRole());
        request.setAttribute("personnels", parametreBDD.readAllPersonnel());
        request.setAttribute("grades", parametreBDD.readAllGrade());
        request.setAttribute("action", "caserne"); // Indique le contexte caserne

        if (edit == null) {
            // Mode consultation : affichage du profil d'un pompier
            if (pompierId == null) {
                response.sendRedirect("caserne");
                return;
            }

            // Charge le pompier sélectionné
            pompier = pompierBDD.read(Integer.parseInt(request.getParameter("pompier")));

            ArrayList<Journee> disponibilites = pompierBDD.read(pompier.getId()).getDisponibilites(true);
            request.setAttribute("start1", disponibilites.get(0).getDateToString());
            request.setAttribute("end1", disponibilites.get(disponibilites.size() - 1).getDateToString());

            disponibilites = pompierBDD.read(pompier.getId()).getDisponibilites(false);
            request.setAttribute("start2", disponibilites.get(0).getDateToString());
            request.setAttribute("end2", disponibilites.get(disponibilites.size() - 1).getDateToString());
            request.setAttribute("parametres", parametreBDD);

            // Stocke le pompier en session et prépare l'affichage
            maSession.setAttribute("pompier", pompier);
            request.setAttribute("profil-editing", false);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/profilVue.jsp");
            dispatcher.forward(request, response);
        } else {
            // Mode édition : traitement des actions sur le profil
            
            pompier = (Pompier) maSession.getAttribute("pompier");
            pompierId = request.getParameter("pompier");

            if (pompier != null) {
                ArrayList<Journee> disponibilites = pompierBDD.read(pompier.getId()).getDisponibilites(true);
                request.setAttribute("start1", disponibilites.get(0).getDateToString());
                request.setAttribute("end1", disponibilites.get(disponibilites.size() - 1).getDateToString());

                disponibilites = pompierBDD.read(pompier.getId()).getDisponibilites(false);
                request.setAttribute("start2", disponibilites.get(0).getDateToString());
                request.setAttribute("end2", disponibilites.get(disponibilites.size() - 1).getDateToString());
                request.setAttribute("parametres", parametreBDD);
            }
            
            System.out.println("EDITION");
            switch (request.getParameter("edit")) {
                case "0":
                    System.out.println("Annuler les modifications");
                    request.setAttribute("profilEditing", false);
                    break;
                case "1":
                    System.out.println("Enregistrer une modification");
                    ModifForm modifForm = new ModifForm();
                    modifForm.modifierProfil(request, pompier);
                    request.setAttribute("profilEditing", false);
                    break;
                case "2":
                    System.out.println("Modifier le profil");
                    request.setAttribute("profilEditing", true);
                    break;
                case "3":
                    System.out.println("Retour à la caserne");
                    response.sendRedirect("caserne");
                    return;
                case "4":
                    modifForm = new ModifForm();
                    String horaire = request.getParameter("horaire");
                    modifForm.modifierGarde(request, Integer.parseInt(pompierId), horaire);
                    System.out.println("Modification du planning");
                    response.sendRedirect("caserne");
                    return;
                default:
                    break;
            }

            // Réaffiche la page de profil avec le nouvel état
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/profilVue.jsp");
            dispatcher.forward(request, response);
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
