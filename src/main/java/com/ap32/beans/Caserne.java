/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ap32.beans;

import com.ap32.bdd.PompierMysql;
import java.util.ArrayList;

/**
 * Bean d'interaction avec les informations d'une caserne
 * @author steve.maingana
 */
public class Caserne {
    private int id;
    private String nom;
    private String adresse;
    private String tel;
    private String groupement;
    private ArrayList<Pompier> pompiers = new ArrayList<Pompier>();
    
    /**
     * Constructeur de la caserne
     * @param id Identifiant de la caserne
     * @param nom Nom de la caserne
     * @param adresse Adresse de la caserne
     * @param tel Téléphone de la caserne
     * @param groupement Groupement de la caserne
     */
    public Caserne(int id, String nom, String adresse, String tel, String groupement) {
        PompierMysql pompierBDD = new PompierMysql();
        this.id = id;
        this.nom = nom;
        this.adresse = adresse;
        this.tel = tel;
        this.groupement = groupement;
        for (Pompier pompier : pompierBDD.readAll()) {
            if (pompier.getCaserne() == this.id) {
                pompiers.add(pompier);
            }
        }
    }

    /**
     * Retourne l'identifiant de la caserne
     * @return Identifiant de la caserne
     */
    public int getId() {
        return id;
    }
    
    /**
     * Définit l'identifiant de la caserne
     * @param id Identifiant de la caserne
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Retourne le nom de la caserne
     * @return Nom de la caserne
     */
    public String getNom() {
        return nom;
    }
    
    /**
     * Définit le nom de la caserne
     * @param nom Nom de la caserne
     */
    public void setNom(String nom) {
        this.nom = nom;
    }

    /**
     * Retourne l'adresse de la caserne
     * @return Adresse de la caserne
     */
    public String getAdresse() {
        return adresse;
    }

    /**
     * Définit l'adresse de la caserne
     * @param adresse Adresse de la caserne
     */
    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    /**
     * Retourne le téléphone de la caserne
     * @return Téléphone de la caserne
     */
    public String getTel() {
        return tel;
    }

    /**
     * Définit le téléphone de la caserne
     * @param tel Téléphone de la caserne
     */
    public void setTel(String tel) {
        this.tel = tel;
    }

    /**
     * Retourne le groupement de la caserne
     * @return Groupement de la caserne
     */
    public String getGroupement() {
        return groupement;
    }

    /**
     * Définit le groupement de la caserne
     * @param groupement Groupement de la caserne
     */
    public void setGroupement(String groupement) {
        this.groupement = groupement;
    }

    /**
     * Retourne la liste des pompiers de la caserne
     * @return Liste des pompiers de la caserne
     */
    public ArrayList<Pompier> getPompiers() {
        return pompiers;
    }
}