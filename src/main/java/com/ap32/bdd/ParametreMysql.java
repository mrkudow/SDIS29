/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ap32.bdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * Classe de relation avec les tables parametre et typeParametre de la base de données
 * @author steve.maingana
 */
public class ParametreMysql {
     private Statement stmt = null;
    private ResultSet result = null;

    // public ClientMysql() {
    Connection laConnexion = Connexion.getConnect();
    // }
    
    /**
     * Retourne le rôle selon son identifiant dans la vue "statut"
     * @param id Indice du rôle
     * @return Rôle
     */
    public Object[] readRole(int id) {
        Object[] role = null;
        
        try {
            String sql = "SELECT indice, libelle FROM statut INNER JOIN pompier ON pompier.statut = statut.indice WHERE pompier.id = ?"; 
            PreparedStatement preparedStmt = laConnexion.prepareStatement(sql);
            preparedStmt.setInt(1, id);
            
            result = preparedStmt.executeQuery();
            if (result.next()) {
                role = new Object[]{
                    result.getInt("indice"),
                    result.getString("libelle")
                };
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        
        return role;
    }
    /**
     * Retourne tous les rôles dans la vue "statut"
     * @return 
     */
    public ArrayList<Object[]> readAllRole() {
        ArrayList<Object[]> roles = new ArrayList<Object[]>();
        
        try {
            stmt = laConnexion.createStatement();
            result = stmt.executeQuery("SELECT indice, libelle FROM statut");
            
            while (result.next()) {
                Object[] role = new Object[]{
                    result.getInt("indice"),
                    result.getString("libelle")
                };
                
                roles.add(role);
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        
        return roles;
    }
    
    /**
     * Retourne le grade selon son identifiant dans la vue "grade"
     * @param id
     * @return 
     */
    public Object[] readGrade(int id) {
        Object[] grade = null;
        
        try {
            String sql = "SELECT indice, libelle FROM grade INNER JOIN pompier ON pompier.grade = grade.indice WHERE pompier.id = ?"; 
            PreparedStatement preparedStmt = laConnexion.prepareStatement(sql);
            preparedStmt.setInt(1, id);
            
            result = preparedStmt.executeQuery();
            if (result.next()) {
                grade = new Object[]{
                    result.getInt("indice"),
                    result.getString("libelle")
                };
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        
        return grade;
    }
    
    /**
     * Retourne tous les grades dans la vue "grade"
     * @return 
     */
    public ArrayList<Object[]> readAllGrade() {
        ArrayList<Object[]> grades = new ArrayList<Object[]>();
        
        try {
            stmt = laConnexion.createStatement();
            result = stmt.executeQuery("SELECT indice, libelle FROM grade");
            
            while (result.next()) {
                Object[] grade = new Object[]{
                    result.getInt("indice"),
                    result.getString("libelle")
                };
                
                grades.add(grade);
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        
        return grades;
    }
    
    /**
     * Retourne le type de personnel selon son identifiant dans la vue "personnel"
     * @param id
     * @return 
     */
    public Object[] readPersonnel(int id) {
        Object[] personnel = null;
        
        try {
            String sql = "SELECT indice, libelle FROM personnel INNER JOIN pompier ON pompier.typePers = personnel.indice WHERE pompier.id = ?"; 
            PreparedStatement preparedStmt = laConnexion.prepareStatement(sql);
            preparedStmt.setInt(1, id);
            
            result = preparedStmt.executeQuery();
            if (result.next()) {
                personnel = new Object[]{
                    result.getInt("indice"),
                    result.getString("libelle")
                };
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        
        return personnel;
    }
    
    /**
     * Retourne tous les types de personnel dans la vue "personnel"
     * @return 
     */
    public ArrayList<Object[]> readAllPersonnel() {
        ArrayList<Object[]> personnels = new ArrayList<Object[]>();
        
        try {
            stmt = laConnexion.createStatement();
            result = stmt.executeQuery("SELECT indice, libelle FROM personnel");
            
            while (result.next()) {
                Object[] personnel = new Object[]{
                    result.getInt("indice"),
                    result.getString("libelle")
                };
                
                personnels.add(personnel);
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        
        return personnels;
    }
    
    /**
     * Retourne le type de personnel selon son identifiant dans la vue "personnel"
     * @param id
     * @return 
     */
    public Object[] readDisponible(int id) {
        Object[] disponible = null;
        
        try {
            String sql = "SELECT indice, libelle FROM disponible WHERE indice=?"; 
            PreparedStatement preparedStmt = laConnexion.prepareStatement(sql);
            preparedStmt.setInt(1, id);
            
            result = preparedStmt.executeQuery();
            if (result.next()) {
                disponible = new Object[]{
                    result.getInt("indice"),
                    result.getString("libelle")
                };
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        
        return disponible;
    }
    
    /**
     * Retourne tous les types de disponibilités dans la vue "disponible"
     * @return 
     */
    public ArrayList<Object[]> readAllDisponible() {
        ArrayList<Object[]> disponibles = new ArrayList<Object[]>();
        
        try {
            stmt = laConnexion.createStatement();
            result = stmt.executeQuery("SELECT indice, libelle FROM disponible");
            
            while (result.next()) {
                Object[] disponible = new Object[]{
                    result.getInt("indice"),
                    result.getString("libelle")
                };
                
                disponibles.add(disponible);
            }
        } catch (SQLException ex) {
            System.out.println("SQLException : " + ex.getMessage());
            System.out.println("SQLState : " + ex.getSQLState());
            System.out.println("Code erreur : " + ex.getErrorCode());
        }
        
        return disponibles;
    }
}
