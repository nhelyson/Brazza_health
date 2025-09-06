package com.brazza.servlet;

import com.brazza.model.ArticleBean;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Affiche_wiki")
public class AfficherArticlesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/connexion");
            return;
        }

        List<ArticleBean> articles = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB)) {
                String sql = "SELECT a.id, a.titre, a.contenu, a.date_publication, u.nom, u.prenom, MIN(i.chemin) AS image_principale " +
                             "FROM articles a " +
                             "JOIN utilisateurs u ON a.utilisateur_id = u.id " +
                             "LEFT JOIN images i ON a.id = i.article_id " +
                             "GROUP BY a.id " +
                             "ORDER BY a.date_publication DESC";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        ArticleBean article = new ArticleBean();
                        article.setId(rs.getInt("id"));
                        article.setTitre(rs.getString("titre"));
                        article.setContenu(rs.getString("contenu"));
                        article.setAuteur(rs.getString("prenom") + " " + rs.getString("nom"));
                        article.setDatePublication(rs.getTimestamp("date_publication"));
                        article.setImagePrincipale(rs.getString("image_principale"));
                        articles.add(article);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Erreur de base de données lors de l'affichage des articles.", e);
        }

        request.setAttribute("articles", articles);
        request.getRequestDispatcher("/WEB-INF/code_jsp/wiki.jsp").forward(request, response);
    }
}