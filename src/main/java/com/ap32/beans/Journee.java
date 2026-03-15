/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ap32.beans;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;
import javax.swing.text.DateFormatter;

/**
 *
 * @author steve.maingana
 */
public class Journee {
    private LocalDate date;
    private String nuit;
    private String matinee;
    private String apresMidi;
    private String soiree;
    
    public Journee(LocalDate date, String nuit, String matinee, String apresMidi, String soiree) {
        this.date = date;
        this.nuit = nuit;
        this.matinee = matinee;
        this.apresMidi = apresMidi;
        this.soiree = soiree;
    }

    public LocalDate getDate() {
        return this.date;
    }
    
    public String getDateToString() {
        DateTimeFormatter format = DateTimeFormatter.ofPattern("EEEE dd/MM", Locale.FRENCH);
        return this.date.format(format);
    }

    public String getNuit() {
        return nuit;
    }

    public void setNuit(String nuit) {
        this.nuit = nuit;
    }

    public String getMatinee() {
        return matinee;
    }

    public void setMatinee(String matinee) {
        this.matinee = matinee;
    }

    public String getApresMidi() {
        return apresMidi;
    }

    public void setApresMidi(String apresMidi) {
        this.apresMidi = apresMidi;
    }

    public String getSoiree() {
        return soiree;
    }

    public void setSoiree(String soiree) {
        this.soiree = soiree;
    }
}
