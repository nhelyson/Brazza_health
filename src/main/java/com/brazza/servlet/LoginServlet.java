package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login = request.getParameter("identifiant");
        String motdepasse = request.getParameter("motdepasse");

        String hashedPassword = hashPassword(motdepasse);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB);
                 PreparedStatement stmt = conn.prepareStatement(
                         "SELECT id, nom, prenom, email, role FROM utilisateurs WHERE (email=? OR nom=?) AND motdepasse=?")) {

                stmt.setString(1, login);
                stmt.setString(2, login);
                stmt.setString(3, hashedPassword);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession();

                    session.setAttribute("userId", rs.getInt("id")); 
                    session.setAttribute("userNom", rs.getString("nom"));
                    session.setAttribute("userPrenom", rs.getString("prenom"));
                    session.setAttribute("userEmail", rs.getString("email"));
                    session.setAttribute("userRole", rs.getString("role"));

                    // Redirection corrigée vers le servlet qui affiche le wiki
                    response.sendRedirect(request.getContextPath() + "/code_jsp/index.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/connexion.jsp?error=invalid");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/connexion.jsp?error=exception");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/connexion.jsp");
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