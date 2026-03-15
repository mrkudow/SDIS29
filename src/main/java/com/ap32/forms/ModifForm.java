/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ap32.forms;

import com.ap32.bdd.CalendrierMysql;
import com.ap32.bdd.PompierMysql;
import com.ap32.beans.Journee;
import com.ap32.beans.Pompier;
import jakarta.servlet.http.HttpServletRequest;
import java.net.http.HttpRequest;
import java.time.LocalDate;

/**
 * Classe du formulaire de modification d'un pompier
 *
 * @author steve.maingana
 */
public class ModifForm {

    public String resultat;

    /**
     * Constructeur par défaut
     */
    public ModifForm() {
    }

    ;
    
    /**
     * Retourne le résultat de la modification
     * @return Résultat de la modification
     */
    public String getResultat() {
        return this.resultat;
    }

    /**
     * Définit le résultat de la modification
     *
     * @param resultat Résultat de la modification
     */
    public void setResultat(String resultat) {
        this.resultat = resultat;
    }

    /**
     * Modifie le profil d'un pompier avec les données du formulaire
     *
     * @param request Requête HTTP contenant les paramètres du formulaire
     * @param pompier Objet Pompier à modifier
     * @return true si la modification a réussi, false sinon
     */
    public boolean modifierProfil(HttpServletRequest request, Pompier pompier) {
        PompierMysql pompierBDD = new PompierMysql();

        // Récupération des paramètres du formulaire
        String statut = request.getParameter("statut");
        String personnel = request.getParameter("personnel");
        String grade = request.getParameter("grade");
        String mail = request.getParameter("mail");
        String adresse = request.getParameter("adresse");
        String cp = request.getParameter("cp");
        String ville = request.getParameter("ville");

        // Debug des valeurs reçues
        System.out.println("mail: " + mail);
        System.out.println("adresse: " + adresse);
        System.out.println("cp: " + cp);
        System.out.println("ville: " + ville);

        // Mise à jour du statut
        if (statut != null && !statut.isEmpty()) {
            pompier.setStatut(Integer.parseInt(statut));
        }

        // Mise à jour du type de personnel
        if (personnel != null && !personnel.isEmpty()) {
            pompier.setPersonnel(Integer.parseInt(personnel));
        }

        // Mise à jour du grade
        if (grade != null && !grade.isEmpty()) {
            pompier.setGrade(Integer.parseInt(grade));
        }

        // Mise à jour de l'email
        if (mail != null && !mail.isEmpty()) {
            pompier.setMail(mail);
        }

        // Mise à jour de l'adresse
        if (adresse != null && !adresse.isEmpty()) {
            pompier.setAdresse(adresse);
        }

        // Mise à jour du code postal
        if (cp != null && !cp.isEmpty()) {
            pompier.setCp(cp);
        }

        // Mise à jour de la ville
        if (ville != null && !ville.isEmpty()) {
            pompier.setVille(ville);
        }

        // Mise à jour en base de données
        boolean modification = pompierBDD.update(pompier.getId(), pompier);
        System.out.println("Modification: " + modification);

        // Message de résultat
        if (modification) {
            this.setResultat("Modification enregistrée !");
        } else {
            this.setResultat("Problème rencontré lors de l'enregistrement de la modification.");
        }

        return modification;
    }

    public boolean modifierDisponibilite(HttpServletRequest request, int pompier) {
        CalendrierMysql calendrierBDD = new CalendrierMysql();
        LocalDate date = LocalDate.parse(request.getParameter("date"));
        String nuit = request.getParameter("nuit");
        String matinee = request.getParameter("matinee");
        String apresMidi = request.getParameter("apres_midi");
        String soiree = request.getParameter("soiree");

        Journee journee = calendrierBDD.readJournee(date, pompier);

        System.out.println(journee.getDateToString());

        if (nuit != null && !nuit.equals(journee.getNuit())) {
            journee.setNuit(nuit);
        }

        if (matinee != null && !matinee.equals(journee.getMatinee())) {
            journee.setMatinee(matinee);
        }

        if (apresMidi != null && !apresMidi.equals(journee.getApresMidi())) {
            journee.setApresMidi(apresMidi);
        }

        if (soiree != null && !soiree.equals(journee.getSoiree())) {
            journee.setSoiree(soiree);
        }

        boolean modification = calendrierBDD.update(journee, pompier);

        if (modification) {
            this.setResultat("Modification enregistrée !");
        } else {
            this.setResultat("Problème rencontré lors de l'enregistrement de la modification.");
        }

        return modification;
    }

    public boolean modifierGarde(HttpServletRequest request, int pompier, String horaire) {
        CalendrierMysql calendrierBDD = new CalendrierMysql();
        LocalDate date = LocalDate.parse(request.getParameter("date"));
        int valeur = (request.getParameter("valeur") != null) ? 1 : 0;
        int etat = Integer.parseInt(request.getParameter("etat"));
        Journee journee = calendrierBDD.readJournee(date, pompier);
        
        switch (horaire) {
            case "nuit":
                journee.setNuit(etatDisponibilite(valeur, etat));
                break;
            case "matinee":
                journee.setMatinee(etatDisponibilite(valeur, etat));
                break;
            case "apres_midi":
                journee.setApresMidi(etatDisponibilite(valeur, etat));
                break;
            case "soiree":
                journee.setSoiree(etatDisponibilite(valeur, etat));
                break;
        }

        boolean modification = calendrierBDD.update(journee, pompier);

        if (modification) {
            this.setResultat("Modification enregistrée !");
        } else {
            this.setResultat("Problème rencontré lors de l'enregistrement de la modification.");
        }

        return modification;
    }

    public String etatDisponibilite(int checkbox, int etatInitial) {
        String etat = "0";
        
        if (checkbox > 0) {
            switch (etatInitial) {
                case 0:
                    etat = "0";
                    break;
                case 1:
                    etat = "3";
                    break;
                case 2:
                    etat = "4";
                    break;
                case 3:
                    etat = "3";
                    break;
                case 4:
                    etat = "4";
                    break;
            }
        } else {
            switch (etatInitial) {
                case 0:
                    etat = "0";
                    break;
                case 1:
                    etat = "1";
                    break;
                case 2:
                    etat = "2";
                    break;
                case 3:
                    etat = "1";
                    break;
                case 4:
                    etat = "2";
                    break;
            }
        }

        return etat;
    }
}
