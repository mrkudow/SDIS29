package com.ap32.bdd;

import com.ap32.bdd.Connexion;
import com.ap32.beans.Pompier;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 * Classe de relation avec la table pompier de la base de données
 *
 * @author steve.maingana
 */
public class PompierMysql {

    // private Connection laConnexion;
    private Statement stmt = null;
    private ResultSet result = null;

    // public ClientMysql() {
    Connection laConnexion = Connexion.getConnect();
    // }

    /**
     * Crée un pompier
     *
     * @param pompier Nouveau pompier
     * @return Identifiant du pompier
     */
    public int create(Pompier pompier) {
        int id = -1;
        String sql = "INSERT INTO pompier ("
                + "idCaserne, nom, prenom, statut, typePers,"
                + "mail, login, mdps, salt, adresse, cp, ville,"
                + "bip, nbGardes, grade, dateEnreg, dateModif)"
                + "VALUES (?, ?, ?, ?, ?,"
                + "?, ?, '', '', ?, ?, ?,"
                + "1, 0, ?, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP())";

        try (PreparedStatement preparedStmt1 = laConnexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            String login = "";
            String prenom = pompier.getPrenom();
            String nom = pompier.getNom();
            login += prenom.substring(0, 1).toUpperCase();
            login += nom.length() >= 4 ? nom.substring(0, 4).toUpperCase() : nom.toUpperCase();

            preparedStmt1.setInt(1, pompier.getCaserne());
            preparedStmt1.setString(2, pompier.getNom());
            preparedStmt1.setString(3, pompier.getPrenom());
            preparedStmt1.setInt(4, pompier.getStatut());
            preparedStmt1.setInt(5, pompier.getPersonnel());
            preparedStmt1.setString(6, pompier.getMail());
            preparedStmt1.setString(7, login);
            preparedStmt1.setString(8, pompier.getAdresse()); // Adresse
            preparedStmt1.setString(9, pompier.getCp()); // CP
            preparedStmt1.setString(10, pompier.getVille()); // Ville
            preparedStmt1.setInt(11, pompier.getGrade()); // Grade

            int status = preparedStmt1.executeUpdate();
            if (status > 0) {
                try (ResultSet result = preparedStmt1.getGeneratedKeys()) {
                    if (result.next()) {
                        id = result.getInt(1);
                        stmt = laConnexion.createStatement();
                        stmt.executeQuery("CALL initMdp(LAST_INSERT_ID())");
                    }
                }
            }

            stmt.close();
            preparedStmt1.close();
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return id;
    }

    /**
     * Met à jour des données d'un pompier
     *
     * @param id Identifiant du pompier
     * @param pompier Nouvelles données du pompier
     * @return true: Mise à jour réussie / false: Mise à jour échouée
     */
    public boolean update(int id, Pompier pompier) {
        int update = 0;
        try {
            String sql = "UPDATE pompier SET nom=?, prenom=?, statut=?, typePers=?, mail=?, login=?, adresse=?, cp=?, ville=?, dateModif=NOW(), grade=? WHERE id=?";
            PreparedStatement preparedStmt1 = laConnexion.prepareStatement(sql);

            preparedStmt1.setString(1, pompier.getNom());
            preparedStmt1.setString(2, pompier.getPrenom());
            preparedStmt1.setInt(3, pompier.getStatut());
            preparedStmt1.setInt(4, pompier.getPersonnel());
            preparedStmt1.setString(5, pompier.getMail());
            preparedStmt1.setString(6, pompier.getLogin());
            preparedStmt1.setString(7, pompier.getAdresse());
            preparedStmt1.setString(8, pompier.getCp());
            preparedStmt1.setString(9, pompier.getVille());
            preparedStmt1.setInt(10, pompier.getGrade());
            preparedStmt1.setInt(11, id);

            update = preparedStmt1.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        System.out.println(pompier.toString());
        System.out.println("Update: " + update);
        return update > 0;
    }

    /**
     * Retourne tous les pompiers
     *
     * @return Liste des pompiers
     */
    public ArrayList<Pompier> readAll() {
        ArrayList<Pompier> pompiers = new ArrayList<Pompier>();

        try {
            stmt = laConnexion.createStatement();

            result = stmt.executeQuery("SELECT * FROM pompier");
            while (result.next()) {
                Pompier pompier = new Pompier(
                        result.getInt("id"),
                        result.getInt("idCaserne"),
                        result.getString("nom"),
                        result.getString("prenom"),
                        result.getInt("statut"),
                        result.getInt("typePers"),
                        result.getString("mail"),
                        result.getString("login"),
                        result.getString("adresse"),
                        result.getString("cp"),
                        result.getString("ville"),
                        result.getInt("grade"),
                        result.getDate("dateEnreg"),
                        result.getDate("dateModif"),
                        result.getInt("bip")
                );

                pompiers.add(pompier);
            }

            result.close();
            stmt.close();
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return pompiers;
    }

    /**
     * Retourne un pompier selon son identifiant
     *
     * @param id Identifiant du pompier
     * @return Informations du pompier
     */
    public Pompier read(int id) {
        Pompier pompier = null;

        try {
            PreparedStatement preparedStmt = laConnexion.prepareStatement("SELECT * FROM pompier WHERE id = ?");

            preparedStmt.setInt(1, id);

            result = preparedStmt.executeQuery();
            if (result.next()) {
                pompier = new Pompier(
                        result.getInt("id"),
                        result.getInt("idCaserne"),
                        result.getString("nom"),
                        result.getString("prenom"),
                        result.getInt("statut"),
                        result.getInt("typePers"),
                        result.getString("mail"),
                        result.getString("login"),
                        result.getString("adresse"),
                        result.getString("cp"),
                        result.getString("ville"),
                        result.getInt("grade"),
                        result.getDate("dateEnreg"),
                        result.getDate("dateModif"),
                        result.getInt("bip")
                );
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return pompier;
    }

    /**
     * Retourne un pompier selon son identifiant
     *
     * @param login Identifiant du pompier
     * @param mdp Mot de passe du pompier
     * @return Informations du pompier
     */
    public Pompier read(String login, String mdp) {
        Pompier pompier = null;

        try {
            PreparedStatement preparedStmt = laConnexion.prepareStatement("SELECT * FROM pompier WHERE login=? AND mdps=TO_BASE64(SHA2(CONCAT(salt, UPPER(?)),256))");

            preparedStmt.setString(1, login);
            preparedStmt.setString(2, mdp);

            result = preparedStmt.executeQuery();
            if (result.next()) {
                pompier = new Pompier(
                        result.getInt("id"),
                        result.getInt("idCaserne"),
                        result.getString("nom"),
                        result.getString("prenom"),
                        result.getInt("statut"),
                        result.getInt("typePers"),
                        result.getString("mail"),
                        result.getString("login"),
                        result.getString("adresse"),
                        result.getString("cp"),
                        result.getString("ville"),
                        result.getInt("grade"),
                        result.getDate("dateEnreg"),
                        result.getDate("dateModif"),
                        result.getInt("bip")
                );
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }

        return pompier;
    }
}
