/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ap32.forms;

import com.ap32.bdd.PompierMysql;
import com.ap32.beans.Pompier;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Classe du formulaire de création d'un pompier
 * @author steve.maingana
 */
public class NouveauForm {
    public String resultat;
    
    /**
     * Constructeur par défaut
     */
    public NouveauForm() {};
    
    /**
     * Retourne le résultat de la création
     * @return Résultat de la création
     */
    public String getResultat() {
        return this.resultat;
    }
    
    /**
     * Définit le résultat de la création
     * @param resultat Résultat de la création
     */
    public void setResultat(String resultat) {
        this.resultat = resultat;
    }
    
    /**
     * Crée un nouveau pompier avec les données du formulaire
     * @param request Requête HTTP contenant les paramètres du formulaire
     * @return true si la création a réussi, false sinon
     */
    public boolean nouveauPompier(HttpServletRequest request) {
        // Récupération de la session et du chef de centre authentifié
        HttpSession maSession = request.getSession();
        PompierMysql pompierBDD = new PompierMysql();
        Pompier chefCentre = pompierBDD.read((int) maSession.getAttribute("user"));
        
        // Récupération des paramètres du formulaire
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        int statut = Integer.parseInt(request.getParameter("statut"));
        int personnel = Integer.parseInt(request.getParameter("personnel"));
        String mail = request.getParameter("mail");
        String login = request.getParameter("login");
        String adresse = request.getParameter("adresse");
        String cp = request.getParameter("cp");
        String ville = request.getParameter("ville");
        int grade = Integer.parseInt(request.getParameter("grade"));
        
        // Création du nouvel objet Pompier
        // Le pompier est automatiquement affecté à la caserne du chef de centre
        Pompier nouveauPompier = new Pompier(chefCentre.getCaserne(), nom, prenom, statut, personnel, mail, login, adresse, cp, ville, grade);
        
        // Enregistrement en base de données
        int enregistrement = pompierBDD.create(nouveauPompier);
        
        // Définition du message de résultat
        if (enregistrement > -1) {
            this.setResultat("Enregistrement du pompier réussie (#"+enregistrement+")");
        } else {
            this.setResultat("Le pompier n'a pas pu être enregistré.");
        }
        
        return enregistrement > -1;
    }
}