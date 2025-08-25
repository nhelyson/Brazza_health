package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/inscriptionServlet")
public class InscriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String prenom = request.getParameter("prenom"); 
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motdepasse = request.getParameter("motdepasse");
        String confirmMotdepasse = request.getParameter("confirmMotdepasse");
        String telephone = request.getParameter("telephone");

        if (!motdepasse.equals(confirmMotdepasse)) {
            response.sendRedirect("forminscription.jsp?error=password");
            return;
        }

        // Hash du mot de passe
        String hashedPassword = hashPassword(motdepasse);

        // Définir le rôle par défaut
        String role = "user";

        // Tableau des emails qui doivent être admins
        String[] admins = {"japhetikoume@gmail.com"};

        // Tableau des emails spéciaux avec rôle prédéfini (ex: rester membre)
        String[] membresSpeciaux = {"ikoumejaphet@gmail.com"};

        // Vérification si l'email est un admin
        for(String adminEmail : admins) {
            if(email.equalsIgnoreCase(adminEmail)) {
                role = "admin";
                break;
            }
        }

        // Vérification si l'email doit rester membre malgré tout
        for(String membreEmail : membresSpeciaux) {
            if(email.equalsIgnoreCase(membreEmail)) {
                role = "membre";
                break;
            }
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB);
                     PreparedStatement stmt = conn.prepareStatement(
                             "INSERT INTO utilisateurs (nom, prenom, role ,  email, motdepasse, telephone) VALUES (?, ?, ?, ?, ?, ?)")) {

                   
                    stmt.setString(1, nom);
                    stmt.setString(2, prenom);
                    stmt.setString(3, role); // ajouter le rôle
                    stmt.setString(4, email);
                    stmt.setString(5, hashedPassword);
                    stmt.setString(6, telephone);
                  

                    int rows = stmt.executeUpdate();

                    if (rows > 0) {
                        // Création de la session après inscription réussie
                        HttpSession session = request.getSession();
                        session.setAttribute("userPrenom", prenom);
                        session.setAttribute("userNom", nom);
                        session.setAttribute("userEmail", email);
                        session.setAttribute("userRole", role); // ajouter rôle dans la session

                        response.sendRedirect("confirmation.jsp");
                    } else {
                        out.println("<h2>Erreur : impossible d'insérer l'utilisateur.</h2>");
                        out.println("<a href='forminscription.jsp'>Retour</a>");
                    }
                }

            } catch (Exception e) {
                out.println("<h2>Erreur SQL :</h2>");
                out.println("<pre>" + e.getMessage() + "</pre>");
                out.println("<a href='forminscription.jsp'>Retour</a>");
                e.printStackTrace();
            }

        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
