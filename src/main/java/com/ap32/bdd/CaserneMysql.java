/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ap32.bdd;

import com.ap32.beans.Caserne;
import com.ap32.beans.Pompier;
import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * Classe de relation avec la table caserne de la base de données de la base de données
 * @author steve.maingana
 */
public class CaserneMysql {
    // private Connection laConnexion;
    private Statement stmt = null;
    private ResultSet result = null;

    // public ClientMysql() {
    Connection laConnexion = Connexion.getConnect();
    // }
    
    /**
     * Retourne toutes les casernes
     * @return Toutes les casernes
     */
    public ArrayList<Caserne> readAll() {
        ArrayList<Caserne> casernes = new ArrayList<Caserne>();

        try {
            stmt = laConnexion.createStatement();

            result = stmt.executeQuery("SELECT * FROM caserne");
            while (result.next()) {
                Caserne caserne = new Caserne(
                    result.getInt("id"),
                    result.getString("nom"),
                    result.getString("adresse"),
                    result.getString("tel"),
                    result.getString("groupement")
                );

                casernes.add(caserne);
            }

            result.close();
            stmt.close();
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return casernes;
    }

    /**
     * Retourne une caserne selon son ID
     * @param id Identifiant de la caserne
     * @return Caserne selon ID
     */
    public Caserne read(int id) {
        Caserne caserne = null;

        try {
            PreparedStatement preparedStmt = laConnexion.prepareStatement("SELECT * FROM caserne WHERE id = ?");

            preparedStmt.setInt(1, id);

            result = preparedStmt.executeQuery();
            if (result.next()) {
                caserne = new Caserne(
                    result.getInt("id"),
                    result.getString("nom"),
                    result.getString("adresse"),
                    result.getString("tel"),
                    result.getString("groupement")
                );
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return caserne;
    }
}
