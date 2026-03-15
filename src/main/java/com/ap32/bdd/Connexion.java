package com.ap32.bdd;

/*
Connexion.java
Classe permettant d'établir une connexion avec une base de données mySQL
 */
import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;

public class Connexion {

    private static Connection connect = null;      // Variable de connexion
    private static Dotenv dotenv = null;

    /**
     * Constructeur
     *
     * @param serveur nom du serveur, localhost si local
     * @param bdd nom de la base de données
     * @param nomUtil nom utilisateur
     * @param mdp mot de passe lié à l'utilisateur
     */
    private Connexion() {
        try {
            dotenv = Dotenv.configure().ignoreIfMissing().load();
            
            System.out.println("Fichier .env chargé: " + (dotenv != null));
            // 1. Chargement du driver
            //Class.forName("com.mysql.jdbc.Driver");
            Class.forName("org.mariadb.jdbc.Driver");
            System.out.println("Driver accessible");

            // 2. Initialisation des paramètres de connexion
            String host = System.getProperty("MYSQL_HOST");                             // Serveur de bd
            String port = System.getProperty("MYSQL_PORT");                             // Port
            String dbname = System.getProperty("MYSQL_DATABASE");                                 // Nom bd
            String url = "jdbc:mariadb://" + host + ":"+ port+"/" + dbname;   // url de connexion
            url += "?autoReconnect=true";  // Ajout 26/09/2021
            System.out.println("url : " + url);
            String user = System.getProperty("MYSQL_USER");                                // nom du user
            System.out.println("nomUtil : " + user);
            String passwd = System.getProperty("MYSQL_PASSWORD");                                  // mot de passe
            System.out.println("mdp : " + passwd);

            // 3. Connexion
            connect = (Connection) DriverManager.getConnection(url, user, passwd);
            System.out.println("Connexion réussie !");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Retourne la connection établie (Création d'une connection si elle
     * n'existe pas)
     *
     * @return connection établie
     */
    public static Connection getConnect() {
        System.out.println("getConnect");
        if (connect == null) {
            new Connexion();
        }
        return connect;
    }
}
