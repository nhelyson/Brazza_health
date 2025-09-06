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

@WebServlet("/CommentaireServlet")
public class CommentaireServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupération du contenu et de l'article concerné
        String contenu = request.getParameter("contenu");
        String articleIdStr = request.getParameter("article_id");

        if (contenu == null || contenu.trim().isEmpty() || articleIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/Affiche_wiki");
            return;
        }

        int articleId;
        try {
            articleId = Integer.parseInt(articleIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/Affiche_wiki");
            return;
        }

        // Vérification que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Insertion du commentaire
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB)) {
                String sql = "INSERT INTO commentaires (article_id, utilisateur_id, contenu) VALUES (?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, articleId);
                    stmt.setInt(2, userId);
                    stmt.setString(3, contenu);
                    stmt.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Erreur lors de l'enregistrement du commentaire.", e);
        }

        // Retour sur l'article après insertion
        response.sendRedirect(request.getContextPath() + "/LireArticle?id=" + articleId);
    }
}
