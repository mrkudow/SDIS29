/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ap32.forms;

import com.ap32.bdd.ParametreMysql;
import com.ap32.bdd.PompierMysql;
import com.ap32.beans.Pompier;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Classe du formulaire d'authentification
 * @author steve.maingana
 */
public class AuthentifForm {
    public String resultat;
    
    /**
     * Constructeur par défaut
     */
    public AuthentifForm() {};
    
    /**
     * Retourne le résultat de l'authentification
     * @return Résultat de l'authentification
     */
    public String getResultat() {
        return this.resultat;
    }
    
    /**
     * Définit le résultat de l'authentification
     * @param resultat Résultat de l'authentification
     */
    public void setResultat(String resultat) {
        this.resultat = resultat;
    }
    
    /**
     * Vérifie l'existence de l'utilisateur et authentifie si valide
     * @param request Requête HTTP
     * @param session Session HTTP
     * @return true si l'utilisateur existe et est authentifié, false sinon
     */
    public boolean existeUser(HttpServletRequest request, HttpSession session) {
        PompierMysql pompierBDD = new PompierMysql();
        String pseudo = (String) request.getParameter("pseudo");
        String mdp = (String) request.getParameter("mdp");
        Pompier user = pompierBDD.read(pseudo, mdp);
        
        boolean existe = user != null;
        
        if (!existe) {
            this.setResultat("Il y a une erreur dans le nom d'utilisateur ou le mot de passe");
        } else {
            System.out.println(user.getStatutName());
            this.setResultat("Connexion réussie");
            session.setAttribute("user", user.getId());
            session.setAttribute("nom", user.getNom()+" "+user.getPrenom());
            session.setAttribute("role", user.getStatutName());
            session.setAttribute("isAuthentified", true);
        }
        
        return existe;
    }
}