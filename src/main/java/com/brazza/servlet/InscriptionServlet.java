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
        String dateNaissance = request.getParameter("dateNaissance");
        String genre = request.getParameter("genre");

        if (!motdepasse.equals(confirmMotdepasse)) {
            response.sendRedirect("forminscription.jsp?error=password");
            return;
        }

        String hashedPassword = hashPassword(motdepasse);

        // Rôle par défaut
        String role = "user";
        String[] admins = {"japhetikoume@gmail.com"};
        String[] membresSpeciaux = {"ikoumejaphet@gmail.com"};

        for (String adminEmail : admins) {
            if (email.equalsIgnoreCase(adminEmail)) {
                role = "admin";
                break;
            }
        }

        for (String membreEmail : membresSpeciaux) {
            if (email.equalsIgnoreCase(membreEmail)) {
                role = "membre";
                break;
            }
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB);
                 PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO utilisateurs (nom, prenom, motdepasse, telephone, date_naissance, email, genre, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {

                stmt.setString(1, nom);
                stmt.setString(2, prenom);
                stmt.setString(3, hashedPassword);
                stmt.setString(4, telephone);
                stmt.setString(5, dateNaissance);
                stmt.setString(6, email);
                stmt.setString(7, genre);
                stmt.setString(8, role);

                int rows = stmt.executeUpdate();

                if (rows > 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userPrenom", prenom);
                    session.setAttribute("userNom", nom);
                    session.setAttribute("userEmail", email);
                    session.setAttribute("userRole", role);

                    // Redirection corrigée vers le servlet qui affiche le wiki
                    response.sendRedirect(request.getContextPath() + "/code_jsp/index.jsp");
                } else {
                    out.println("<h2>Erreur : impossible d'insérer l'utilisateur.</h2>");
                    out.println("<a href='forminscription.jsp'>Retour</a>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
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