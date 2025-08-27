package com.brazza.servlet;

import com.brazza.model.ArticleBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/affiche_article", "/affiche_article.jsp"})
public class AfficherArticlesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<ArticleBean> articles = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("MySQL JDBC Driver not found", e);
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB)) {
            String sql = "SELECT a.id, a.titre, a.contenu, a.date_publication, u.nom, u.prenom, i.chemin " +
                         "FROM articles a " +
                         "JOIN utilisateurs u ON a.utilisateur_id = u.id " +
                         "LEFT JOIN images i ON a.id = i.article_id " +
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
                    article.setImagePrincipale(rs.getString("chemin"));
                    articles.add(article);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database access error", e);
        }

        request.setAttribute("articles", articles);
        request.getRequestDispatcher("affiche_article.jsp").forward(request, response);
    }
}
