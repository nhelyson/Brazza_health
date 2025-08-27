package com.brazza.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/creerArticleServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class creerArticleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final String URL = "jdbc:mysql://localhost:3306/brazza_db?useSSL=false&serverTimezone=UTC";
    private final String USER = "root";
    private final String PASSWORD_DB = "";
    
    // Chemin pour l'enregistrement des images. À adapter selon votre serveur.
    private static final String UPLOAD_DIRECTORY = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId"); // Assurez-vous d'avoir l'ID de l'utilisateur en session

        // 1. Vérification de la session utilisateur
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/connexion.jsp?error=not_authenticated");
            return;
        }
        
        // 2. Récupération des données du formulaire
        String titre = request.getParameter("titre");
        String contenu = request.getParameter("contenu");
        List<String> photoPaths = new ArrayList<>();

        // Validation des champs
        if (titre == null || titre.trim().isEmpty() || contenu == null || contenu.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/creer_article.jsp?error=invalid_data");
            return;
        }

        // 3. Sauvegarde des images
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        try {
            for (Part part : request.getParts()) {
                if (part.getName().equals("photos") && part.getSize() > 0) {
                    String fileName = UUID.randomUUID().toString() + "_" + part.getSubmittedFileName();
                    part.write(uploadPath + File.separator + fileName);
                    photoPaths.add(UPLOAD_DIRECTORY + File.separator + fileName);
                }
            }
        } catch (Exception ex) {
            response.sendRedirect(request.getContextPath() + "/creer_article.jsp?error=upload_failed");
            return;
        }

        // 4. Enregistrement de l'article et des images dans la base de données
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD_DB)) {
                
                // Insertion de l'article
                String insertArticleSQL = "INSERT INTO articles (titre, contenu, utilisateur_id) VALUES (?, ?, ?)";
                try (PreparedStatement stmtArticle = conn.prepareStatement(insertArticleSQL, Statement.RETURN_GENERATED_KEYS)) {
                    stmtArticle.setString(1, titre);
                    stmtArticle.setString(2, contenu);
                    stmtArticle.setInt(3, userId);
                    stmtArticle.executeUpdate();

                    ResultSet generatedKeys = stmtArticle.getGeneratedKeys();
                    int articleId = 0;
                    if (generatedKeys.next()) {
                        articleId = generatedKeys.getInt(1);
                    } else {
                        throw new ServletException("Échec de l'obtention de l'ID de l'article.");
                    }

                    // Insertion des images
                    String insertImageSQL = "INSERT INTO images (chemin, nom_fichier, article_id) VALUES (?, ?, ?)";
                    try (PreparedStatement stmtImage = conn.prepareStatement(insertImageSQL)) {
                        for (String path : photoPaths) {
                            String fileName = path.substring(path.lastIndexOf(File.separator) + 1);
                            stmtImage.setString(1, path);
                            stmtImage.setString(2, fileName);
                            stmtImage.setInt(3, articleId);
                            stmtImage.addBatch();
                        }
                        stmtImage.executeBatch();
                    }
                }
                
                response.sendRedirect(request.getContextPath() + "/wiki_accueil.jsp?success=article_created");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/creer_article.jsp?error=database_error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/creer_article.jsp");
    }
}