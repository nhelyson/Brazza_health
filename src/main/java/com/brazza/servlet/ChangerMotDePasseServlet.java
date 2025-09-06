package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.security.MessageDigest;

@WebServlet("/ChangerMotDePasse")
public class ChangerMotDePasseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String ancienPwd = request.getParameter("ancienPwd");
        String nouveauPwd = request.getParameter("nouveauPwd");
        String confirmerPwd = request.getParameter("confirmerPwd");

        if (!nouveauPwd.equals(confirmerPwd)) {
            response.sendRedirect(request.getContextPath() + "/CompteUtilisateur?error=1");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB)) {

                // Vérifier l'ancien mot de passe
                String sqlCheck = "SELECT motdepasse FROM utilisateurs WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sqlCheck)) {
                    stmt.setInt(1, userId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            String motdepasseDB = rs.getString("motdepasse");
                            String hashedAncien = hashPassword(ancienPwd);
                            if (!motdepasseDB.equals(hashedAncien)) {
                                response.sendRedirect(request.getContextPath() + "/CompteUtilisateur?error=2");
                                return;
                            }
                        }
                    }
                }

                // Mettre à jour le mot de passe
                String sqlUpdate = "UPDATE utilisateurs SET motdepasse = ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sqlUpdate)) {
                    String hashedNouveau = hashPassword(nouveauPwd);
                    stmt.setString(1, hashedNouveau);
                    stmt.setInt(2, userId);
                    stmt.executeUpdate();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/CompteUtilisateur?error=3");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/CompteUtilisateur?success=1");
    }

    // Méthode utilitaire pour hasher le mot de passe en SHA-256
    private String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (byte b : hash) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}
