package com.brazza.servlet;

import com.brazza.model.ArticleBean;
import com.brazza.model.CommentaireBean;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/LireArticle")
public class LireArticle extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String articleIdStr = request.getParameter("id");
        if (articleIdStr == null || articleIdStr.isEmpty()) {
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

        ArticleBean article = null;
        List<ArticleBean> recentArticles = new ArrayList<>();
        List<CommentaireBean> commentaires = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB)) {

                // Article principal
                String sqlArticle = "SELECT a.id, a.titre, a.contenu, a.date_publication, " +
                        "u.nom, u.prenom, u.photo AS photoAuteur, i.chemin AS imagePrincipale " +
                        "FROM articles a " +
                        "JOIN utilisateurs u ON a.utilisateur_id = u.id " +
                        "LEFT JOIN images i ON a.id = i.article_id " +
                        "WHERE a.id = ? LIMIT 1";
                try (PreparedStatement stmt = conn.prepareStatement(sqlArticle)) {
                    stmt.setInt(1, articleId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            article = new ArticleBean();
                            article.setId(rs.getInt("id"));
                            article.setTitre(rs.getString("titre"));
                            article.setContenu(rs.getString("contenu"));
                            article.setAuteur(rs.getString("prenom") + " " + rs.getString("nom"));
                            article.setDatePublication(rs.getTimestamp("date_publication"));
                            article.setImagePrincipale(rs.getString("imagePrincipale"));
                        }
                    }
                }

                // Articles récents
                String sqlRecent = "SELECT a.id, a.titre, a.date_publication, u.nom, u.prenom " +
                        "FROM articles a " +
                        "JOIN utilisateurs u ON a.utilisateur_id = u.id " +
                        "WHERE a.id != ? ORDER BY a.date_publication DESC LIMIT 5";
                try (PreparedStatement stmt = conn.prepareStatement(sqlRecent)) {
                    stmt.setInt(1, articleId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            ArticleBean ra = new ArticleBean();
                            ra.setId(rs.getInt("id"));
                            ra.setTitre(rs.getString("titre"));
                            ra.setAuteur(rs.getString("prenom") + " " + rs.getString("nom"));
                            ra.setDatePublication(rs.getTimestamp("date_publication"));
                            recentArticles.add(ra);
                        }
                    }
                }

                // Commentaires avec photo de l'auteur
                String sqlCom = "SELECT c.id, c.contenu, c.date_commentaire, c.utilisateur_id, c.article_id, " +
                        "u.nom, u.prenom, u.photo AS photoAuteur " +
                        "FROM commentaires c " +
                        "JOIN utilisateurs u ON c.utilisateur_id = u.id " +
                        "WHERE c.article_id = ? ORDER BY c.date_commentaire ASC";
                try (PreparedStatement stmt = conn.prepareStatement(sqlCom)) {
                    stmt.setInt(1, articleId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            CommentaireBean com = new CommentaireBean();
                            com.setId(rs.getInt("id"));
                            com.setContenu(rs.getString("contenu"));
                            com.setDateCommentaire(rs.getTimestamp("date_commentaire"));
                            com.setUtilisateurId(rs.getInt("utilisateur_id"));
                            com.setArticleId(rs.getInt("article_id"));
                            com.setAuteur(rs.getString("prenom") + " " + rs.getString("nom"));
                            com.setPhotoAuteur(rs.getString("photoAuteur")); // Nouvelle propriété
                            commentaires.add(com);
                        }
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Erreur BDD : " + e.getMessage(), e);
        }

        request.setAttribute("article", article);
        request.setAttribute("recentArticles", recentArticles);
        request.setAttribute("commentaires", commentaires);
        request.getRequestDispatcher("/WEB-INF/code_jsp/lire_article.jsp").forward(request, response);
    }
}
