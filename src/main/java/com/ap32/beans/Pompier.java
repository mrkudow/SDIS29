/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ap32.beans;

import com.ap32.bdd.CalendrierMysql;
import com.ap32.bdd.CaserneMysql;
import com.ap32.bdd.ParametreMysql;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

/**
 * Bean représentant un pompier
 *
 * @author steve.maingana
 */
public class Pompier {

    private Caserne laCaserne = null;
    private int id;
    private int caserne;
    private String nom;
    private String prenom;
    private int statut;
    private int personnel;
    private String mail;
    private String login;
    private String mdp;
    private String adresse;
    private String cp;
    private String ville;
    private int grade;
    private int bip;
    private Date dateEnreg;
    private Date dateModif;

    final private ParametreMysql parametreBDD = new ParametreMysql();
    final private CaserneMysql caserneBDD = new CaserneMysql();

    /**
     * Constructeur complet du pompier
     *
     * @param id Identifiant du pompier
     * @param caserne Identifiant de la caserne
     * @param nom Nom du pompier
     * @param prenom Prénom du pompier
     * @param statut Statut du pompier
     * @param personnel Type de personnel
     * @param mail Email du pompier
     * @param login Login du pompier
     * @param adresse Adresse du pompier
     * @param cp Code postal du pompier
     * @param ville Ville du pompier
     * @param grade Grade du pompier
     * @param dateEnreg Date d'enregistrement
     * @param dateModif Date de modification
     * @param bip N° Bip du pompier
     */
    public Pompier(int id, int caserne, String nom, String prenom, int statut, int personnel, String mail, String login, String adresse, String cp, String ville, int grade, Date dateEnreg, Date dateModif, int bip) {
        this.id = id;
        this.caserne = caserne;
        this.nom = nom;
        this.prenom = prenom;
        this.statut = statut;
        this.personnel = personnel;
        this.mail = mail;
        this.login = login;
        this.adresse = adresse;
        this.cp = cp;
        this.ville = ville;
        this.grade = grade;
        this.dateEnreg = dateEnreg;
        this.dateModif = dateModif;
        this.bip = bip;
    }

    /**
     * Constructeur pour création d'un nouveau pompier
     *
     * @param caserne Identifiant de la caserne
     * @param nom Nom du pompier
     * @param prenom Prénom du pompier
     * @param statut Statut du pompier
     * @param personnel Type de personnel
     * @param mail Email du pompier
     * @param login Login du pompier
     * @param adresse Adresse du pompier
     * @param cp Code postal du pompier
     * @param ville Ville du pompier
     * @param grade Grade du pompier
     */
    public Pompier(int caserne, String nom, String prenom, int statut, int personnel, String mail, String login, String adresse, String cp, String ville, int grade) {
        this.caserne = caserne;
        this.nom = nom;
        this.prenom = prenom;
        this.statut = statut;
        this.personnel = personnel;
        this.mail = mail;
        this.login = login;
        this.adresse = adresse;
        this.cp = cp;
        this.ville = ville;
        this.grade = grade;
    }

    /**
     * Retourne l'identifiant du pompier
     *
     * @return Identifiant du pompier
     */
    public int getId() {
        return id;
    }

    /**
     * Définit l'identifiant du pompier
     *
     * @param id Identifiant du pompier
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Retourne l'identifiant de la caserne
     *
     * @return Identifiant de la caserne
     */
    public int getCaserne() {
        return caserne;
    }

    /**
     * Retourne l'objet Caserne du pompier (lazy loading)
     *
     * @return Objet Caserne du pompier
     */
    public Caserne getLaCaserne() {
        if (laCaserne == null) {
            laCaserne = caserneBDD.read(this.caserne);
        }

        return laCaserne;
    }

    /**
     * Définit la caserne du pompier
     *
     * @param caserne Identifiant de la caserne
     */
    public void setCaserne(int caserne) {
        this.laCaserne = caserneBDD.read(caserne);
        this.caserne = caserne;
    }

    /**
     * Retourne le nom du pompier
     *
     * @return Nom du pompier
     */
    public String getNom() {
        return nom;
    }

    /**
     * Définit le nom du pompier
     *
     * @param nom Nom du pompier
     */
    public void setNom(String nom) {
        this.nom = nom;
    }

    /**
     * Retourne le prénom du pompier
     *
     * @return Prénom du pompier
     */
    public String getPrenom() {
        return prenom;
    }

    /**
     * Définit le prénom du pompier
     *
     * @param prenom Prénom du pompier
     */
    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    /**
     * Retourne le statut du pompier
     *
     * @return Statut du pompier
     */
    public int getStatut() {
        return statut;
    }

    /**
     * Définit le statut du pompier
     *
     * @param statut Statut du pompier
     */
    public void setStatut(int statut) {
        this.statut = statut;
    }

    /**
     * Retourne le libellé du statut du pompier
     *
     * @return Libellé du statut
     */
    public String getStatutName() {
        return (String) parametreBDD.readRole(this.id)[1];
    }

    /**
     * Retourne le type de personnel
     *
     * @return Type de personnel
     */
    public int getPersonnel() {
        return personnel;
    }

    /**
     * Définit le type de personnel
     *
     * @param personnel Type de personnel
     */
    public void setPersonnel(int personnel) {
        this.personnel = personnel;
    }

    /**
     * Retourne le libellé du type de personnel
     *
     * @return Libellé du type de personnel
     */
    public String getPersonnelName() {
        return (String) parametreBDD.readPersonnel(this.id)[1];
    }

    /**
     * Retourne l'email du pompier
     *
     * @return Email du pompier
     */
    public String getMail() {
        return mail;
    }

    /**
     * Définit l'email du pompier
     *
     * @param mail Email du pompier
     */
    public void setMail(String mail) {
        this.mail = mail;
    }

    /**
     * Retourne le login du pompier
     *
     * @return Login du pompier
     */
    public String getLogin() {
        return login;
    }

    /**
     * Définit le login du pompier
     *
     * @param login Login du pompier
     */
    public void setLogin(String login) {
        this.login = login;
    }

    /**
     * Retourne le mot de passe du pompier
     *
     * @return Mot de passe du pompier
     */
    public String getMdp() {
        return mdp;
    }

    /**
     * Définit le mot de passe du pompier
     *
     * @param mdp Mot de passe du pompier
     */
    public void setMdp(String mdp) {
        this.mdp = mdp;
    }

    /**
     * Retourne l'adresse du pompier
     *
     * @return Adresse du pompier
     */
    public String getAdresse() {
        return adresse;
    }

    /**
     * Définit l'adresse du pompier
     *
     * @param adresse Adresse du pompier
     */
    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    /**
     * Retourne le code postal du pompier
     *
     * @return Code postal du pompier
     */
    public String getCp() {
        return cp;
    }

    /**
     * Définit le code postal du pompier
     *
     * @param cp Code postal du pompier
     */
    public void setCp(String cp) {
        this.cp = cp;
    }

    /**
     * Retourne la ville du pompier
     *
     * @return Ville du pompier
     */
    public String getVille() {
        return ville;
    }

    /**
     * Définit la ville du pompier
     *
     * @param ville Ville du pompier
     */
    public void setVille(String ville) {
        this.ville = ville;
    }

    /**
     * Retourne le grade du pompier
     *
     * @return Grade du pompier
     */
    public int getGrade() {
        return this.grade;
    }

    /**
     * Retourne le libellé du grade du pompier
     *
     * @return Libellé du grade
     */
    public String getGradeName() {
        return (String) parametreBDD.readGrade(this.id)[1];
    }

    /**
     * Définit le grade du pompier
     *
     * @param id Identifiant du grade
     */
    public void setGrade(int id) {
        this.grade = id;
    }

    /**
     * Retourne le numéro de bip du pompier
     *
     * @return Numeéro de bip du pompier
     */
    public int getBip() {
        return this.bip;
    }

    /**
     * Retourne la date d'enregistrement
     *
     * @return Date d'enregistrement
     */
    public Date getDateEnreg() {
        return dateEnreg;
    }

    /**
     * Définit la date d'enregistrement
     *
     * @param dateEnreg Date d'enregistrement
     */
    public void setDateEnreg(Date dateEnreg) {
        this.dateEnreg = dateEnreg;
    }

    /**
     * Retourne la date de modification
     *
     * @return Date de modification
     */
    public Date getDateModif() {
        return dateModif;
    }

    /**
     * Définit la date de modification
     *
     * @param dateModif Date de modification
     */
    public void setDateModif(Date dateModif) {
        this.dateModif = dateModif;
    }

    public ArrayList<Journee> getDisponibilites(boolean encours) {
        CalendrierMysql calendrierBDD = new CalendrierMysql();
        return calendrierBDD.readSemaine(this.id, encours);
    }
    
    public Journee getDisponibilite(boolean encours, LocalDate date) {
        ArrayList<Journee> disponibilites = this.getDisponibilites(encours);
        Journee journee = null;
        
        for (Journee j : disponibilites) {
            if (j.getDate().equals(date)) journee = j;
        }
        
        return journee;
    }
    
    /**
     * Retourne une représentation textuelle du pompier
     *
     * @return Représentation textuelle du pompier
     */
    @Override
    public String toString() {
        return "Pompier{" + "id=" + id + ", caserne=" + caserne + ", nom=" + nom + ", prenom=" + prenom + ", statut=" + statut + ", personnel=" + personnel + ", mail=" + mail + ", login=" + login + ", mdp=" + mdp + ", adresse=" + adresse + ", cp=" + cp + ", ville=" + ville + ", grade=" + grade + ", dateEnreg=" + dateEnreg + ", dateModif=" + dateModif + '}';
    }
}
