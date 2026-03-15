/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ap32.bdd;

import com.ap32.beans.Caserne;
import com.ap32.beans.Journee;
import com.ap32.beans.Pompier;
import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjuster;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;

/**
 * Classe de relation avec la table caserne de la base de données de la base de
 * données
 *
 * @author steve.maingana
 */
public class CalendrierMysql {

    // private Connection laConnexion;
    private Statement stmt = null;
    private ResultSet result = null;

    // public ClientMysql() {
    Connection laConnexion = Connexion.getConnect();
    // }

    /**
     * Retourne toutes les journées du calendrier de tous les pompiers
     *
     * @return Toutes les journées du calendrier de tous les pompiers
     */
    public ArrayList<Journee> readAll() {
        ArrayList<Journee> journees = new ArrayList<Journee>();

        try {
            stmt = laConnexion.createStatement();

            result = stmt.executeQuery("SELECT * FROM disponibilite");
            while (result.next()) {
                Journee journee = new Journee(
                        result.getDate("date_dispo").toLocalDate(),
                        result.getString("nuit"),
                        result.getString("matinee"),
                        result.getString("apres_midi"),
                        result.getString("soiree")
                );

                journees.add(journee);
            }

            result.close();
            stmt.close();
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return journees;
    }

    public Journee readJournee(LocalDate date) {
        Journee journee = null;

        try {
            PreparedStatement preparedStmt = laConnexion.prepareStatement("SELECT * FROM disponibilite WHERE date_dispo = ?");
            preparedStmt.setDate(1, java.sql.Date.valueOf(date));

            result = preparedStmt.executeQuery();
            if (result.next()) {
                journee = new Journee(
                        result.getDate("date_dispo").toLocalDate(),
                        result.getString("nuit"),
                        result.getString("matinee"),
                        result.getString("apres_midi"),
                        result.getString("soiree")
                );
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return journee;
    }

    public Journee readJournee(int pompier) {
        Journee journee = null;

        try {
            PreparedStatement preparedStmt = laConnexion.prepareStatement("SELECT * FROM disponibilite WHERE pompierId = ?");

            preparedStmt.setInt(1, pompier);

            result = preparedStmt.executeQuery();
            if (result.next()) {
                journee = new Journee(
                        result.getDate("date_dispo").toLocalDate(),
                        result.getString("nuit"),
                        result.getString("matinee"),
                        result.getString("apres_midi"),
                        result.getString("soiree")
                );
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return journee;
    }

    /**
     * Retourne une journée du calendrier selon son jour et le pompier
     *
     * @param date Date de la journee du calendrier
     * @return Journée du calendrier
     */
    public Journee readJournee(LocalDate date, int pompier) {
        Journee journee = null;

        try {
            PreparedStatement preparedStmt = laConnexion.prepareStatement("SELECT * FROM disponibilite WHERE date_dispo = ? AND pompierId = ?");

            preparedStmt.setDate(1, java.sql.Date.valueOf(date));
            preparedStmt.setInt(2, pompier);

            result = preparedStmt.executeQuery();
            if (result.next()) {
                journee = new Journee(
                        result.getDate("date_dispo").toLocalDate(),
                        result.getString("nuit"),
                        result.getString("matinee"),
                        result.getString("apres_midi"),
                        result.getString("soiree")
                );
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return journee;
    }

    public ArrayList<Journee> readSemaine(int pompier, boolean encours) {
        ArrayList<Journee> semaine = new ArrayList<>();

        try {
            LocalDate dateActuelle = LocalDate.now();
            LocalDate dateDebut;
            LocalDate dateFin;
            TemporalAdjuster lundi;

            if (encours) {
                lundi = TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY);
            } else {
                lundi = TemporalAdjusters.next(DayOfWeek.MONDAY);
            }

            dateDebut = dateActuelle.with(lundi);
            dateFin = dateDebut.with(TemporalAdjusters.next(DayOfWeek.SUNDAY));

            PreparedStatement preparedStmt = laConnexion.prepareStatement("SELECT * FROM disponibilite WHERE pompierId=? AND date_dispo >= ? AND date_dispo <= ? ORDER BY date_dispo ASC");
            preparedStmt.setInt(1, pompier);
            preparedStmt.setDate(2, java.sql.Date.valueOf(dateDebut));
            preparedStmt.setDate(3, java.sql.Date.valueOf(dateFin));

            result = preparedStmt.executeQuery();
            while (result.next()) {
                Journee journee = new Journee(
                        result.getDate("date_dispo").toLocalDate(),
                        result.getString("nuit"),
                        result.getString("matinee"),
                        result.getString("apres_midi"),
                        result.getString("soiree")
                );

                semaine.add(journee);
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return semaine;
    }

    public boolean update(Journee journee, int pompier) {
        int update = 0;
        try {
            String sql = "UPDATE disponibilite SET nuit=?, matinee=?, apres_midi=?, soiree=? WHERE pompierId=? AND date_dispo=?";
            PreparedStatement preparedStmt = laConnexion.prepareStatement(sql);
            
            System.out.print(pompier);
            System.out.print(java.sql.Date.valueOf(journee.getDate()));
            
            preparedStmt.setString(1, journee.getNuit());
            preparedStmt.setString(2, journee.getMatinee());
            System.out.println(journee.getNuit());
            preparedStmt.setString(3, journee.getApresMidi());
            preparedStmt.setString(4, journee.getSoiree());
            preparedStmt.setInt(5, pompier);
            preparedStmt.setDate(6, java.sql.Date.valueOf(journee.getDate()));
            
            update = preparedStmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        
        return update > 0;
    }
}
